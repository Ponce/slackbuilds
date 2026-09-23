#!/usr/bin/env python3
"""
verify-vendor -- prove a maintainer's vendor.tar.gz has not been tampered.

    verify-vendor  /path/to/foo-1.2.3  vendor.tar.gz

The trust model: the *maintainer is not trusted*. The only trust anchor is the
Cargo.lock inside the upstream source tree (which SBo already verifies via the
upstream tarball's own checksum). For every registry crate, Cargo.lock pins the
sha256 of the exact .crate published on crates.io -- a value the maintainer
cannot forge without breaking the upstream tarball.

So this is the real anti-hacking check, per registry crate:

    1. download the authentic .crate from crates.io
    2. assert sha256(.crate) == the checksum pinned in Cargo.lock
    3. extract it and compare it file-by-file against the vendored crate

A .cargo-checksum.json self-check is intentionally NOT trusted as proof: the
maintainer controls that file, so it can be rewritten to match tampered source.
Only an independent copy from crates.io exposes tampering.

Checks performed:

    [structure] the vendored crate set equals the registry+git set in
                Cargo.lock -- no missing crates, and (critically) no *extra*
                crates that could smuggle in code.
    [content]   each registry crate matches its authentic crates.io .crate,
                byte for byte (this is the core guarantee; needs network).
    [git]       git dependencies cannot be anchored to crates.io; they are
                reported, and optionally deep-checked with --git-clone.

Exit status is 0 only if every enabled check passes.

Standard library only; Python 3.7+. No f-strings with backslashes (parses on
the Python 3.9 shipped with Slackware 15.0).
"""

import argparse
import concurrent.futures as futures
import hashlib
import io
import json
import os
import shutil
import subprocess
import sys
import tarfile
import tempfile
import urllib.request
from pathlib import Path

CHUNK = 1024 * 1024
CRATE_URL = "https://static.crates.io/crates/%s/%s-%s.crate"
USER_AGENT = "slacker-vendor-verify (https://forge.slackware.nl/rizitis/slacker)"

OK = "\u2714"
NO = "\u2718"
WARN = "!"


def _join(items, limit=8):
    head = ", ".join(items[:limit])
    return head + (" ..." if len(items) > limit else "")


# ---------------------------------------------------------------------------
# hashing
# ---------------------------------------------------------------------------

def sha256_bytes(data):
    return hashlib.sha256(data).hexdigest()


def sha256_file(path):
    h = hashlib.sha256()
    with open(path, "rb") as f:
        for chunk in iter(lambda: f.read(CHUNK), b""):
            h.update(chunk)
    return h.hexdigest()


def tree_hashes(root):
    """{posix_relpath: sha256} for every regular file under root."""
    out = {}
    for p in root.rglob("*"):
        if p.is_file() and not p.is_symlink():
            out[p.relative_to(root).as_posix()] = sha256_file(p)
    return out


def tree_sha256(root):
    """Ordered digest of a tree's contents.

    Byte-for-byte identical to the algorithm in sbo-vendor-generate, so the
    value here can be compared against the vendor_tree_sha256 it records.
    """
    h = hashlib.sha256()
    for rel, fh in sorted(tree_hashes(root).items()):
        h.update(rel.encode("utf-8"))
        h.update(b"\0")
        h.update(fh.encode("ascii"))
        h.update(b"\n")
    return h.hexdigest()


# ---------------------------------------------------------------------------
# Cargo.lock
# ---------------------------------------------------------------------------

def toml_scalar(val):
    """Extract a simple TOML scalar: a quoted string, or a bare value with any
    trailing inline comment removed. Handles e.g. version = "0.5.3"  # note."""
    val = val.strip()
    if val[:1] in ('"', "'"):
        q = val[0]
        end = val.find(q, 1)
        return val[1:end] if end != -1 else val[1:]
    pos = val.find("#")
    if pos != -1:
        val = val[:pos]
    return val.strip()


def parse_cargo_lock(path):
    packages = []
    current = None
    in_array = False
    with open(path, "r", encoding="utf-8") as f:
        for raw in f:
            line = raw.strip()
            if in_array:
                if line.endswith("]"):
                    in_array = False
                continue
            if line == "[[package]]":
                if current is not None:
                    packages.append(current)
                current = {}
                continue
            if current is None or "=" not in line:
                continue
            key, _, val = line.partition("=")
            key = key.strip()
            val = val.strip()
            if val.startswith("[") and not val.endswith("]"):
                in_array = True
                continue
            current[key] = toml_scalar(val)
    if current is not None:
        packages.append(current)
    return packages


def classify(source):
    if not source:
        return "local"
    if source.startswith("registry+https://github.com/rust-lang/crates.io-index"):
        return "crates-io"
    if source.startswith("registry+"):
        return "registry-other"
    if source.startswith("git+"):
        return "git"
    return "other"


def read_pkg_id(crate_dir):
    toml = crate_dir / "Cargo.toml"
    if not toml.is_file():
        return None, None
    name = version = None
    in_pkg = False
    try:
        text = toml.read_text(encoding="utf-8", errors="replace")
    except OSError:
        return None, None
    for raw in text.splitlines():
        line = raw.strip()
        if line.startswith("[") and line.endswith("]"):
            in_pkg = (line == "[package]")
            continue
        if not in_pkg or "=" not in line:
            continue
        key, _, val = line.partition("=")
        key = key.strip()
        val = toml_scalar(val)
        if key == "name" and name is None:
            name = val
        elif key == "version" and version is None:
            version = val
        if name and version:
            break
    return name, version


# ---------------------------------------------------------------------------
# safe extraction
# ---------------------------------------------------------------------------

def _safe_members(tar):
    for m in tar.getmembers():
        if Path(m.name).is_absolute() or ".." in Path(m.name).parts:
            raise SystemExit("error: unsafe path in archive: %s" % m.name)
        if (m.issym() or m.islnk()):
            ln = Path(m.linkname)
            if ln.is_absolute() or ".." in ln.parts:
                raise SystemExit("error: unsafe link in archive: %s" % m.name)
    return True


def safe_extract(archive_path, dest):
    with tarfile.open(archive_path, "r:*") as tar:
        _safe_members(tar)
        try:
            tar.extractall(dest, filter="data")
        except TypeError:
            tar.extractall(dest)


def locate_vendor_root(extracted):
    named = extracted / "vendor"
    if named.is_dir():
        return named
    children = [p for p in extracted.iterdir() if p.is_dir()]
    if len(children) == 1:
        return children[0]
    return extracted


# ---------------------------------------------------------------------------
# crates.io download + comparison
# ---------------------------------------------------------------------------

def download_crate(name, version, cache_dir):
    """Return the raw .crate bytes, using an on-disk cache when available."""
    cached = None
    if cache_dir is not None:
        cached = cache_dir / ("%s-%s.crate" % (name, version))
        if cached.is_file():
            return cached.read_bytes()
    url = CRATE_URL % (name, name, version)
    req = urllib.request.Request(url, headers={"User-Agent": USER_AGENT})
    data = urllib.request.urlopen(req, timeout=60).read()
    if cached is not None:
        try:
            cache_dir.mkdir(parents=True, exist_ok=True)
            tmp = cached.with_suffix(".crate.part")
            tmp.write_bytes(data)
            tmp.replace(cached)
        except OSError:
            pass
    return data


def crate_file_hashes(crate_bytes):
    """{relpath: sha256} of the files inside a .crate, top dir stripped."""
    out = {}
    with tarfile.open(fileobj=io.BytesIO(crate_bytes), mode="r:gz") as tf:
        for m in tf.getmembers():
            if not m.isfile():
                continue
            parts = m.name.split("/", 1)
            rel = parts[1] if len(parts) == 2 else parts[0]
            f = tf.extractfile(m)
            if f is None:
                continue
            out[rel] = sha256_bytes(f.read())
    return out


def vendored_file_hashes(crate_dir):
    """{relpath: sha256} of a vendored crate, minus cargo's own metadata."""
    out = {}
    for p in crate_dir.rglob("*"):
        if not p.is_file() or p.is_symlink():
            continue
        rel = p.relative_to(crate_dir).as_posix()
        if rel == ".cargo-checksum.json":
            continue
        out[rel] = sha256_file(p)
    return out


def verify_registry_crate(name, version, checksum, crate_dir, cache_dir):
    """Compare a vendored crate against its authentic crates.io .crate.

    Returns (status, info):
      status == "ok"       -> no added/modified files (info['removed'] may list
                              files cargo legitimately drops, e.g. .gitignore)
      status == "tampered" -> info has 'modified' and/or 'added' file lists
      status == "lockfail" -> .crate sha256 disagrees with Cargo.lock
      status == "error"    -> could not download / read the crate

    Rationale: cargo vendor writes a *subset* of the published .crate (it omits
    VCS files like .gitignore), so files present upstream but absent here are
    benign -- a missing file cannot inject code. Only files that were *added*
    or *changed* relative to the authentic source can introduce behaviour.
    """
    try:
        data = download_crate(name, version, cache_dir)
    except Exception as exc:                       # noqa: BLE001
        return "error", {"msg": "download failed: %s" % exc}

    got = sha256_bytes(data)
    if checksum and got != checksum:
        return "lockfail", {"msg": "crates.io .crate sha256 %s != Cargo.lock %s"
                            % (got, checksum)}

    authentic = crate_file_hashes(data)
    vendored = vendored_file_hashes(crate_dir)

    both = set(authentic) & set(vendored)
    modified = sorted(r for r in both if authentic[r] != vendored[r])
    added = sorted(set(vendored) - set(authentic))      # .cargo-checksum.json excluded
    removed = sorted(set(authentic) - set(vendored))

    if modified or added:
        return "tampered", {"modified": modified, "added": added, "removed": removed}
    return "ok", {"removed": removed}


# ---------------------------------------------------------------------------
# git deep check (optional)
# ---------------------------------------------------------------------------

def parse_git_source(source):
    """git+URL?params#rev -> (url, rev)."""
    body = source[len("git+"):]
    rev = None
    if "#" in body:
        body, rev = body.rsplit("#", 1)
    url = body.split("?", 1)[0]
    return url, rev


# files cargo legitimately *adds* when vendoring (not present in the git tree)
GIT_BENIGN_ADDED = {"Cargo.toml.orig", ".cargo_vcs_info.json", ".cargo-ok"}


def git_fetch_rev(url, rev, dest):
    """Check out an exact commit from url into dest. Returns None on success,
    else an error string. Tries a shallow fetch of the SHA first (works on
    GitHub), then falls back to a full clone."""
    if shutil.which("git") is None:
        return "git not available"
    quiet = subprocess.DEVNULL
    if rev:
        subprocess.run(["git", "init", "-q", dest],
                       stdout=quiet, stderr=quiet)
        subprocess.run(["git", "-C", dest, "remote", "add", "origin", url],
                       stdout=quiet, stderr=quiet)
        r = subprocess.run(["git", "-C", dest, "fetch", "-q", "--depth", "1",
                            "origin", rev], stdout=quiet, stderr=quiet)
        if r.returncode == 0:
            r = subprocess.run(["git", "-C", dest, "checkout", "-q",
                                "FETCH_HEAD"], stdout=quiet, stderr=quiet)
            if r.returncode == 0:
                return None
    # fallback: full clone then checkout
    shutil.rmtree(dest, ignore_errors=True)
    r = subprocess.run(["git", "clone", "-q", url, dest],
                       stdout=quiet, stderr=quiet)
    if r.returncode != 0:
        return "clone failed"
    if rev:
        r = subprocess.run(["git", "-C", dest, "checkout", "-q", rev],
                           stdout=quiet, stderr=quiet)
        if r.returncode != 0:
            return "checkout %s failed (commit unreachable?)" % rev
    return None


def index_repo_crates(repo):
    """{(name, version): dir, ...} for every crate (Cargo.toml) in the repo."""
    out = {}
    by_name = {}
    for toml in repo.rglob("Cargo.toml"):
        if ".git/" in toml.as_posix():
            continue
        d = toml.parent
        n, v = read_pkg_id(d)
        if n:
            if v:
                out[(n, v)] = d
            by_name.setdefault(n, d)
    return out, by_name


def compare_git_crate(crate_dir, upstream_dir):
    """Compare a vendored git crate against its upstream checkout.

    Code files must be byte-identical (modified/added => tampering). Cargo.toml
    is allowed to differ (cargo rewrites it for git workspace members) and is
    reported as a warning, not a failure. Files missing downstream are benign.
    """
    upstream = {k: v for k, v in tree_hashes(upstream_dir).items()
                if not k.startswith(".git/")}
    vendored = vendored_file_hashes(crate_dir)

    both = set(upstream) & set(vendored)
    modified = sorted(r for r in both
                      if r != "Cargo.toml" and upstream[r] != vendored[r])
    cargo_toml_differs = ("Cargo.toml" in both
                          and upstream["Cargo.toml"] != vendored["Cargo.toml"])
    added = sorted(r for r in (set(vendored) - set(upstream))
                   if r not in GIT_BENIGN_ADDED)
    removed = len(set(upstream) - set(vendored))

    return {
        "modified": modified,
        "added": added,
        "cargo_toml_differs": cargo_toml_differs,
        "removed": removed,
    }


# ---------------------------------------------------------------------------
# transport integrity (archive vs the record shipped beside it)
# ---------------------------------------------------------------------------

def load_record(path):
    try:
        return json.loads(Path(path).read_text(encoding="utf-8"))
    except (ValueError, OSError):
        return None


def transport_check(record, archive, vendor_dir, lock_path):
    """Compare the artifact to its own vendor.json record.

    This answers only one question: 'is this the exact archive the maintainer
    recorded?'. It proves the file was not swapped or corrupted in transit. It
    does NOT prove the maintainer was honest -- that is the [content] check.

    Returns a list of human-readable mismatch strings (empty == match).
    """
    bad = []

    rec_lock = record.get("cargo_lock_sha256")
    if rec_lock is not None:
        got = sha256_file(lock_path)
        if got != rec_lock:
            bad.append("Cargo.lock sha256 differs from the record "
                       "(record was built against a different lockfile)")

    rec_tree = record.get("vendor_tree_sha256")
    if rec_tree is not None:
        got = tree_sha256(vendor_dir)
        if got != rec_tree:
            bad.append("vendor tree sha256 differs from the record "
                       "(this is not the directory tree that was recorded)")

    rec_arc = (record.get("archive") or {}).get("sha256")
    if rec_arc is not None:
        got = sha256_file(archive)
        if got != rec_arc:
            bad.append("archive sha256 differs from the record "
                       "(file swapped or corrupted, or record is stale)")

    return bad


# ---------------------------------------------------------------------------
# main verification
# ---------------------------------------------------------------------------

def main():
    ap = argparse.ArgumentParser(
        description="Verify a vendor.tar.gz against an upstream Rust source, "
                    "anchored on Cargo.lock and crates.io."
    )
    ap.add_argument("source", help="unpacked upstream Rust source (has Cargo.lock)")
    ap.add_argument("archive", help="the maintainer's vendor.tar.gz")
    ap.add_argument("--offline", action="store_true",
                    help="skip crates.io downloads (structure check only -- "
                         "does NOT prove absence of tampering)")
    ap.add_argument("--git-clone", action="store_true",
                    help="deep-check git deps by cloning at the pinned rev")
    ap.add_argument("--record", default=None,
                    help="vendor.json to cross-check (transport integrity). "
                         "If omitted, a vendor.json beside the archive is used.")
    ap.add_argument("--no-record", action="store_true",
                    help="do not look for or use a vendor.json record")
    ap.add_argument("--jobs", type=int, default=8,
                    help="parallel crate downloads (default 8)")
    ap.add_argument("--cache", default=None,
                    help="directory to cache downloaded .crate files")
    args = ap.parse_args()

    source = Path(args.source)
    archive = Path(args.archive)
    lock_path = source / "Cargo.lock"

    if not lock_path.is_file():
        sys.exit("error: no Cargo.lock under %s" % source)
    if not archive.is_file():
        sys.exit("error: archive not found: %s" % archive)

    cache_dir = Path(args.cache) if args.cache else None

    # locate an optional vendor.json record for the transport check
    record = None
    record_src = None
    if not args.no_record:
        if args.record:
            record_src = Path(args.record)
        else:
            guess = archive.parent / "vendor.json"
            if guess.is_file():
                record_src = guess
        if record_src is not None:
            if not record_src.is_file():
                sys.exit("error: record not found: %s" % record_src)
            record = load_record(record_src)
            if record is None:
                sys.exit("error: could not parse record: %s" % record_src)

    packages = parse_cargo_lock(lock_path)

    # expected sets from the trusted lockfile
    registry = {}   # (name, version) -> checksum
    git_deps = {}   # (name, version) -> source
    other = []
    for p in packages:
        kind = classify(p.get("source", ""))
        name = p.get("name")
        version = p.get("version")
        if not name or not version:
            continue
        if kind == "crates-io":
            registry[(name, version)] = p.get("checksum")
        elif kind == "git":
            git_deps[(name, version)] = p.get("source")
        elif kind in ("registry-other", "other"):
            other.append((name, version, p.get("source")))
        # 'local' = workspace member, not vendored

    expected = set(registry) | set(git_deps) | {(n, v) for n, v, _ in other}

    tmpdir = tempfile.mkdtemp(prefix="slacker-vendor-verify.")
    failures = []
    try:
        safe_extract(archive, tmpdir)
        vendor = locate_vendor_root(Path(tmpdir))

        # map vendored dirs -> (name, version)
        present = {}            # (name, version) -> Path
        unknown_dirs = []
        for entry in sorted(p for p in vendor.iterdir() if p.is_dir()):
            n, v = read_pkg_id(entry)
            if n and v:
                present[(n, v)] = entry
            else:
                unknown_dirs.append(entry.name)

        present_ids = set(present)

        # ---- [structure] ----
        print("[structure] vendored crate set vs Cargo.lock")
        missing = sorted(expected - present_ids)
        extra = sorted(present_ids - expected)
        if missing:
            print("  %s missing %d crate(s) the lockfile requires:"
                  % (NO, len(missing)))
            for n, v in missing[:20]:
                print("      - %s %s" % (n, v))
            failures.append("vendor is missing crates from Cargo.lock")
        if extra:
            print("  %s %d EXTRA crate(s) not in Cargo.lock (possible "
                  "injection):" % (NO, len(extra)))
            for n, v in extra[:20]:
                print("      - %s %s" % (n, v))
            failures.append("vendor contains crates absent from Cargo.lock")
        if unknown_dirs:
            print("  %s %d vendored dir(s) without a readable Cargo.toml:"
                  % (WARN, len(unknown_dirs)))
            for d in unknown_dirs[:20]:
                print("      - %s" % d)
        if not missing and not extra and not unknown_dirs:
            print("  %s exact match (%d crates)" % (OK, len(expected)))

        if other:
            print("  %s %d crate(s) from a non-crates.io registry "
                  "(not auto-verifiable):" % (WARN, len(other)))
            for n, v, s in other[:20]:
                print("      - %s %s  [%s]" % (n, v, s))

        # ---- [transport] ----
        if record is None:
            print("[transport] no vendor.json record (skipped). This only "
                  "checks the file matches its own record, not honesty.")
        else:
            print("[transport] cross-checking archive against %s" % record_src)
            if record.get("schema") not in (None, "sbo-vendor/1"):
                print("  %s record schema %r is unexpected; checking anyway"
                      % (WARN, record.get("schema")))
            tbad = transport_check(record, archive, vendor, lock_path)
            if tbad:
                for m in tbad:
                    print("  %s %s" % (NO, m))
                failures.append("archive does not match its vendor.json record")
            else:
                print("  %s archive is the exact artifact recorded "
                      "(transport intact; not a proof of honesty)" % OK)

        # ---- [content] ----
        verifiable = [(n, v) for (n, v) in registry if (n, v) in present]
        if args.offline:
            print("[content] SKIPPED (--offline): structure only does NOT "
                  "prove the absence of tampering")
        else:
            print("[content] comparing %d crate(s) against authentic "
                  "crates.io .crate files" % len(verifiable))
            results = {}

            def work(item):
                n, v = item
                return item, verify_registry_crate(
                    n, v, registry[(n, v)], present[(n, v)], cache_dir)

            jobs = max(1, args.jobs)
            with futures.ThreadPoolExecutor(max_workers=jobs) as ex:
                for item, res in ex.map(work, verifiable):
                    results[item] = res

            okc = 0
            removed_total = 0
            crates_with_removed = 0
            tampered = []
            lockfail = []
            errs = []
            for item, (st, info) in results.items():
                if st == "ok":
                    okc += 1
                    rm = len(info.get("removed", []))
                    if rm:
                        removed_total += rm
                        crates_with_removed += 1
                elif st == "tampered":
                    tampered.append((item, info))
                elif st == "lockfail":
                    lockfail.append((item, info))
                else:
                    errs.append((item, info))

            print("  %s %d verified identical to crates.io" % (OK, okc))
            if removed_total:
                print("  - %d crate(s) omit %d upstream-only file(s) cargo "
                      "vendor strips (e.g. .gitignore) -- benign"
                      % (crates_with_removed, removed_total))
            if tampered:
                print("  %s %d TAMPERED crate(s) (added/modified vs crates.io):"
                      % (NO, len(tampered)))
                for (n, v), info in sorted(tampered):
                    parts = []
                    if info.get("modified"):
                        parts.append("modified: " + _join(info["modified"]))
                    if info.get("added"):
                        parts.append("injected: " + _join(info["added"]))
                    print("      - %s %s : %s" % (n, v, "; ".join(parts)))
                failures.append("vendored crates differ from crates.io")
            if lockfail:
                print("  %s %d crate(s) where crates.io disagrees with "
                      "Cargo.lock:" % (NO, len(lockfail)))
                for (n, v), info in sorted(lockfail):
                    print("      - %s %s : %s" % (n, v, info.get("msg")))
                failures.append("crates.io content does not match Cargo.lock")
            if errs:
                print("  %s %d crate(s) could not be checked:" % (WARN, len(errs)))
                for (n, v), info in sorted(errs):
                    print("      - %s %s : %s" % (n, v, info.get("msg")))
                failures.append("some crates could not be fetched for checking")

        # ---- [git] ----
        if git_deps:
            present_git = [(n, v) for (n, v) in git_deps if (n, v) in present]
            if args.git_clone and not args.offline:
                # group members by (url, rev) so each repo is cloned once
                groups = {}
                for (n, v) in present_git:
                    url, rev = parse_git_source(git_deps[(n, v)])
                    groups.setdefault((url, rev), []).append((n, v))

                print("[git] deep-checking %d git dep(s) from %d repo(s)"
                      % (len(present_git), len(groups)))
                if shutil.which("git") is None:
                    print("  %s git not available; cannot deep-check" % WARN)
                    failures.append("git deps requested but git is missing")
                for (url, rev), members in sorted(groups.items()):
                    repo = tempfile.mkdtemp(prefix="sbo-git.")
                    try:
                        err = git_fetch_rev(url, rev, repo)
                        if err:
                            print("  %s %s @ %s : %s"
                                  % (NO, url, (rev or "?")[:12], err))
                            failures.append("could not fetch git source %s" % url)
                            continue
                        index, by_name = index_repo_crates(Path(repo))
                        for (n, v) in sorted(members):
                            up = index.get((n, v)) or by_name.get(n)
                            if up is None:
                                print("  %s %s %s : crate not found in repo"
                                      % (WARN, n, v))
                                failures.append("git crate %s not found upstream"
                                                % n)
                                continue
                            res = compare_git_crate(present[(n, v)], up)
                            if res["modified"] or res["added"]:
                                parts = []
                                if res["modified"]:
                                    parts.append("modified: "
                                                 + _join(res["modified"]))
                                if res["added"]:
                                    parts.append("injected: "
                                                 + _join(res["added"]))
                                print("  %s %s %s : %s"
                                      % (NO, n, v, "; ".join(parts)))
                                failures.append("git dep %s differs from upstream"
                                                % n)
                            elif res["cargo_toml_differs"]:
                                print("  %s %s %s : ok (Cargo.toml rewritten by "
                                      "cargo, code matches)" % (WARN, n, v))
                            else:
                                print("  %s %s %s" % (OK, n, v))
                    finally:
                        shutil.rmtree(repo, ignore_errors=True)
            else:
                groups = {}
                for (n, v) in present_git:
                    url, rev = parse_git_source(git_deps[(n, v)])
                    groups.setdefault((url, rev), []).append((n, v))
                print("[git] %d git dependency(ies) from %d repo(s); trust is "
                      "the pinned rev (use --git-clone to deep-check):"
                      % (len(present_git), len(groups)))
                for (url, rev), members in sorted(groups.items()):
                    print("      %s @ %s" % (url, (rev or "?")))
                    for (n, v) in sorted(members):
                        print("        - %s %s" % (n, v))
    finally:
        shutil.rmtree(tmpdir, ignore_errors=True)

    print("")
    if failures:
        print("%s FAIL" % NO)
        for f in sorted(set(failures)):
            print("  - %s" % f)
        raise SystemExit(2)

    if args.offline:
        print("%s structure OK (offline: tamper-resistance NOT verified)" % WARN)
        raise SystemExit(0)
    print("%s PASS -- vendor matches Cargo.lock and crates.io" % OK)


if __name__ == "__main__":
    main()
