#!/usr/bin/env python3
"""
sbo-vendor-generate -- maintainer-side vendoring tool I use for SlackBuilds.org.

Point it at an unpacked Rust source tree; it produces, in the current
directory, everything needed to ship and later verify an offline Rust build:

    sbo-vendor-generate  /path/to/foo-1.2.3

Outputs (in $PWD by default):

    vendor.tar.gz        deterministic archive of the vendored crates,
                         to be uploaded wherever the maintainer wants
    cargo-config.toml    the [source.*] stanza the SlackBuild drops into
                         $CARGO_HOME/config.toml so cargo builds offline
    vendor.json          a small record (lockfile hash, crate set, archive
                         hash) -- a convenience, NOT a trust anchor

If the source has no vendor/ directory, `cargo vendor` is run to create one
(requires network, this once). If vendor/ already exists it is reused as-is.

The archive is built reproducibly (mtime=0, uid/gid=0, sorted entries, gzip
without a timestamp) so the recorded sha256 is stable across rebuilds and can
go straight into the SlackBuild .info file.

Standard library only; Python 3.7+ (sorted tar.add). No f-strings with
backslashes, so it also parses on the 3.9 shipped with Slackware 15.0.
"""

import argparse
import gzip
import hashlib
import json
import subprocess
import sys
import tarfile
from pathlib import Path

SCHEMA = "sbo-vendor/1"
CHUNK = 1024 * 1024
OK = "\u2714"


# ---------------------------------------------------------------------------
# hashing (the tree hash MUST match sbo-vendor-verify)
# ---------------------------------------------------------------------------

def sha256_file(path):
    h = hashlib.sha256()
    with open(path, "rb") as f:
        for chunk in iter(lambda: f.read(CHUNK), b""):
            h.update(chunk)
    return h.hexdigest()


def iter_regular_files(root):
    files = []
    for p in root.rglob("*"):
        if p.is_file() and not p.is_symlink():
            files.append((p.relative_to(root).as_posix(), p))
    files.sort(key=lambda t: t[0])
    return files


def tree_sha256(root):
    h = hashlib.sha256()
    for rel, path in iter_regular_files(root):
        h.update(rel.encode("utf-8"))
        h.update(b"\0")
        h.update(sha256_file(path).encode("ascii"))
        h.update(b"\n")
    return h.hexdigest()


# ---------------------------------------------------------------------------
# Cargo.lock (minimal, modern inline-checksum layout)
# ---------------------------------------------------------------------------

def toml_scalar(val):
    """Extract a TOML scalar: quoted string, or bare value minus inline comment."""
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
    if source.startswith("registry+"):
        return "registry"
    if source.startswith("git+"):
        return "git"
    return "other"


def crate_name_from_cargo_toml(source):
    toml = source / "Cargo.toml"
    if not toml.is_file():
        return None
    in_pkg = False
    for raw in toml.read_text(encoding="utf-8", errors="replace").splitlines():
        line = raw.strip()
        if line.startswith("[") and line.endswith("]"):
            in_pkg = (line == "[package]")
            continue
        if in_pkg and line.startswith("name"):
            _, _, val = line.partition("=")
            return toml_scalar(val)
    return None


# ---------------------------------------------------------------------------
# cargo vendor
# ---------------------------------------------------------------------------

def run_cargo_vendor(source, vendor_name, cargo_bin, versioned):
    cmd = [cargo_bin, "vendor"]
    if versioned:
        cmd.append("--versioned-dirs")
    cmd.append(vendor_name)
    print("[*] running: %s  (cwd=%s)" % (" ".join(cmd), source))
    try:
        proc = subprocess.run(
            cmd, cwd=str(source),
            stdout=subprocess.PIPE, stderr=None,
            universal_newlines=True,
        )
    except FileNotFoundError:
        sys.exit("error: '%s' not found. Install Rust/cargo, or point at a "
                 "source that already contains a vendor/ directory." % cargo_bin)
    if proc.returncode != 0:
        sys.exit("error: cargo vendor failed (exit %d)" % proc.returncode)
    return proc.stdout or ""


def synthesize_cargo_config(vendor_name, has_git):
    lines = [
        "[source.crates-io]",
        'replace-with = "vendored-sources"',
        "",
        "[source.vendored-sources]",
        'directory = "%s"' % vendor_name,
        "",
    ]
    if has_git:
        lines.append("# NOTE: this source tree has git dependencies. The exact")
        lines.append('# [source."git+..."] replacement stanzas were not captured')
        lines.append("# here. Re-run with --force so they come straight from")
        lines.append("# `cargo vendor`, or add them by hand.")
        lines.append("")
    return "\n".join(lines)


# ---------------------------------------------------------------------------
# deterministic archive
# ---------------------------------------------------------------------------

def _normalize(ti):
    ti.mtime = 0
    ti.uid = ti.gid = 0
    ti.uname = ti.gname = ""
    if ti.isdir():
        ti.mode = 0o755
    elif ti.isfile():
        ti.mode = 0o755 if (ti.mode & 0o100) else 0o644
    return ti


def make_archive(vendor_dir, out_path, arcname="vendor"):
    name = out_path.name
    if name.endswith((".tar.gz", ".tgz")):
        comp = "gz"
    elif name.endswith((".tar.xz", ".txz")):
        comp = "xz"
    elif name.endswith((".tar.bz2", ".tbz2", ".tbz")):
        comp = "bz2"
    elif name.endswith(".tar"):
        comp = None
    else:
        comp = "gz"

    if comp == "gz":
        raw = open(out_path, "wb")
        gz = gzip.GzipFile(filename="", fileobj=raw, mode="wb",
                           mtime=0, compresslevel=9)
        try:
            with tarfile.open(fileobj=gz, mode="w") as tar:
                tar.add(str(vendor_dir), arcname=arcname, filter=_normalize)
        finally:
            gz.close()
            raw.close()
    else:
        mode = "w:" + comp if comp else "w"
        with tarfile.open(str(out_path), mode=mode) as tar:
            tar.add(str(vendor_dir), arcname=arcname, filter=_normalize)


# ---------------------------------------------------------------------------
# record (vendor.json)
# ---------------------------------------------------------------------------

def build_record(source, lock_path, vendor_dir, archive_path):
    packages = parse_cargo_lock(lock_path)
    crates = []
    git_deps = []
    for p in packages:
        kind = classify(p.get("source", ""))
        if kind == "local":
            continue
        item = {
            "name": p.get("name"),
            "version": p.get("version"),
            "source": p.get("source", ""),
        }
        if kind == "git":
            git_deps.append(item)
        else:
            item["checksum"] = p.get("checksum")
            crates.append(item)
    crates.sort(key=lambda c: (c["name"] or "", c["version"] or ""))
    git_deps.sort(key=lambda c: (c["name"] or "", c["version"] or ""))

    return {
        "schema": SCHEMA,
        "package": crate_name_from_cargo_toml(source) or source.name,
        "cargo_lock_sha256": sha256_file(lock_path),
        "vendor_tree_sha256": tree_sha256(vendor_dir),
        "archive": {
            "name": archive_path.name,
            "sha256": sha256_file(archive_path),
        },
        "counts": {
            "registry": len(crates),
            "git": len(git_deps),
            "total": len(crates) + len(git_deps),
        },
        "crates": crates,
        "git_deps": git_deps,
    }


# ---------------------------------------------------------------------------
# main
# ---------------------------------------------------------------------------

def main():
    ap = argparse.ArgumentParser(
        description="Vendor a Rust source tree into a deterministic "
                    "vendor.tar.gz for SlackBuilds.org."
    )
    ap.add_argument("source", help="unpacked Rust source dir (has Cargo.toml)")
    ap.add_argument("-o", "--outdir", default=".",
                    help="where to write outputs (default: current dir)")
    ap.add_argument("--archive", default="vendor.tar.gz",
                    help="archive name; extension picks compression "
                         "(.tar.gz/.tar.xz/.tar.bz2/.tar). Default vendor.tar.gz")
    ap.add_argument("--manifest", default="vendor.json",
                    help="record filename, or '' to skip (default vendor.json)")
    ap.add_argument("--cargo-config", default="cargo-config.toml",
                    help="cargo offline config filename, or '' to skip")
    ap.add_argument("--vendor-dir", default="vendor",
                    help="vendor subdir name inside the source (default vendor)")
    ap.add_argument("--force", action="store_true",
                    help="run `cargo vendor` even if vendor/ already exists")
    ap.add_argument("--no-cargo", action="store_true",
                    help="never run cargo; require an existing vendor/")
    ap.add_argument("--cargo-bin", default="cargo", help="cargo binary")
    ap.add_argument("--versioned-dirs", action="store_true",
                    help="pass --versioned-dirs to cargo vendor")
    args = ap.parse_args()

    source = Path(args.source).resolve()
    outdir = Path(args.outdir).resolve()
    if not source.is_dir():
        sys.exit("error: source is not a directory: %s" % source)
    outdir.mkdir(parents=True, exist_ok=True)

    vendor_dir = source / args.vendor_dir
    lock_path = source / "Cargo.lock"

    cargo_config_text = None
    need_vendor = args.force or not vendor_dir.is_dir()
    if need_vendor:
        if args.no_cargo:
            sys.exit("error: %s has no vendor/ and --no-cargo was given"
                     % source)
        cargo_config_text = run_cargo_vendor(
            source, args.vendor_dir, args.cargo_bin, args.versioned_dirs)
    else:
        print("[*] reusing existing %s" % vendor_dir)

    if not vendor_dir.is_dir():
        sys.exit("error: vendor directory not found after vendoring: %s"
                 % vendor_dir)
    if not lock_path.is_file():
        sys.exit("error: no Cargo.lock in %s (a committed lockfile is "
                 "required for reproducible vendoring)" % source)

    archive_path = outdir / args.archive
    print("[*] writing deterministic archive -> %s" % archive_path)
    make_archive(vendor_dir, archive_path, arcname="vendor")

    record = build_record(source, lock_path, vendor_dir, archive_path)

    if args.manifest:
        man_path = outdir / args.manifest
        man_path.write_text(json.dumps(record, indent=2, sort_keys=True) + "\n")
    else:
        man_path = None

    if args.cargo_config:
        cfg_path = outdir / args.cargo_config
        if cargo_config_text is None:
            cargo_config_text = synthesize_cargo_config(
                args.vendor_dir, record["counts"]["git"] > 0)
        cfg_path.write_text(cargo_config_text.rstrip("\n") + "\n")
    else:
        cfg_path = None

    c = record["counts"]
    print("")
    print("  package          : %s" % record["package"])
    print("  registry / git   : %d / %d" % (c["registry"], c["git"]))
    print("  cargo_lock_sha256: %s" % record["cargo_lock_sha256"])
    print("  vendor_tree_sha  : %s" % record["vendor_tree_sha256"])
    print("  %s sha256: %s" % (args.archive, record["archive"]["sha256"]))
    print("")
    print("%s wrote %s" % (OK, archive_path))
    if cfg_path:
        print("%s wrote %s" % (OK, cfg_path))
    if man_path:
        print("%s wrote %s" % (OK, man_path))
    print("")
    print("Verify it the way SBo will, against the upstream source:")
    print("  sbo-vendor-verify %s %s" % (source, archive_path))


if __name__ == "__main__":
    main()
