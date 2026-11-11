I used to maintain a build-from-source network/dog. It's too much
of a PITA to deal with, and the vendored sources for version 0.8.6
would take up abour 170MB on my web server. I just don't love this
application enough for the hassle.

However, it's useful. Upstream does binary releases, but I can't
package them for 15.0 because they need too new of a glibc. So I built
my own binary.

This binary was built on Slackware 15.0, with rust-opt, thus:

git clone https://github.com/l1a/dog a
cd a
git checkout v0.8.6
PATH=/opt/rust/bin:$PATH cargo build -r

Did this twice (for x86 and x86_64).

...then strip and tar up target/release/dog, plus the man page,
and docs.

Added the sources (since it's GPL) from:

https://github.com/l1a/dog/archive/v0.8.6/dog-0.8.6.tar.gz

Since I don't own aarch64 hardware and I'm not patient enough to
emulate it, I didn't do an aarch64 binary. If you want, you can
compile one and get in touch with me, I'll include it here.
