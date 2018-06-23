
Here is a hopefully informative mini-rant about shared library support
for mupdf.

Upstream doesn't do shared libraries and doesn't recommend distro
packages use them. This build used to follow that advice. However,
mupdf is just too large to use as a static library. We end up with a
47MB libmupdf.a, plus 7 33MB binaries. *Every* distro I've looked at
ships mupdf as shared libs, despite upstream's policy.

A long time ago (in 2013), I used to patch mupdf for shared lib support,
but I removed it when it stopped applying cleanly. Thomas Morper on the
slackbuilds-users mailing list recently (2018) asked if I could include
a patch (from LFS) that adds shared library support, so starting with
mupdf 1.13.0, BUILD 2, we have shared libraries again.

In case someone *really* disagrees with this change, I added a STATIC=yes
environment setting. If you use this, you get static libs and no
shared ones, per upstream's policy. This has been tested and works for
1.13.0-2, but be aware that I probably won't be testing static builds
for every mupdf release. If you run into trouble, email me and/or the
slackbuilds-users list.

The library versioning scheme I had to use is unfortunate. The major
soname version is supposed to only change when there's an incompatible ABI
change. The way I'm doing it, it changes for every mupdf release [*]. This
is because upstream doesn't tell us when the ABI changes, because it's
not relevant for them. They support only static libs specifically to
avoid the headache of having to track and minimize ABI changes. Whenever
they want to change the ABI, they just do it. Anything built against the
old version will keep working fine, because it's statically linked. With
shared libs, I have to invent my own library versioning scheme.

The end result of this is, I (humble packager) can't easily tell when
the ABI has changed, so I treat every release [*] as an ABI change. Means
anything linked with libmupdf will fail with 'cannot open shared object
file' after a mupdf upgrade, so it'll have to be rebuilt. The alternative
would be to use unversioned shared libs, which would (seem to) avoid
the need to rebuild... but whenever the undocumented ABI changed, we'd
get weird behaviour and segfaults instead of a clean error message.

The shared library patch used here is by me (B. Watson), based on a
patch from Linux From Scratch. The original LFS patch doesn't include
versioned libs, I suspect becase in LFS you tend to upgrade the entire
OS by rebuilding it, instead of upgrading just one library.

Right now, the only SBo builds affected by mupdf upgrades will be
zathura-pdf-mupdf and possibly fbpdf (if built with optional mupdf
support). Both have been tested with shared mupdf, and both compile and
run cleanly.

[*] Actually, not micro-version point releases (e.g. 1.13.0 => 1.13.1).
    Hopefully this doesn't cause a problem later. Upstream has just
    switched to a major.minor.micro version scheme starting with 1.13.0,
    so I don't know how often there will be micro-version bumps, and
    whether or not they'll have ABI changes.
