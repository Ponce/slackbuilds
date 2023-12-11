#!/bin/sh

# Create source tarball from git repo.

# Takes one optional argument, which is the commit or tag to create a
# tarball of. With no arg, HEAD is used.

# Version number example: 0.0.1+20200227_ad7ec17

# Notes:

# This script doesn't need to be run as root. It does need to be able
# to write to the current directory it's run from.

# Running this script twice for the same commit will NOT give identical
# tarballs, even if the contents are identical. This is because tar
# includes the current time in a newly-created tarball (plus there may
# be other git-related reasons).

# Once you've generated a tarball, you'll still need a place to host it.
# Ask on the mailing list, if you don't have your own web server to
# play with.

## Config:
VERSION=0.9.5

# final tarball and slackbuild PRGNAM:
PRGNAM=sbsigntools

# what it says on the tin:
CLONE_URL=https://git.kernel.org/pub/scm/linux/kernel/git/jejb/sbsigntools.git

## End of config.

set -e

GITDIR=$( mktemp -dt $PRGNAM.git.XXXXXX )
rm -rf $GITDIR
git clone --recursive $CLONE_URL $GITDIR

CWD="$( pwd )"
cd $GITDIR

git reset --hard "v$VERSION"

rm -rf .git
find . -name .gitignore -print0 | xargs -0 rm -f

cd "$CWD"
rm -rf $PRGNAM-$VERSION $PRGNAM-$VERSION.tar.xz
mv $GITDIR $PRGNAM-$VERSION
tar cvfJ $PRGNAM-$VERSION.tar.xz $PRGNAM-$VERSION

echo
echo "Created tarball: $PRGNAM-$VERSION.tar.xz"
echo "VERSION=\"$VERSION\""
echo "MD5SUM=\"$( md5sum $PRGNAM-$VERSION.tar.xz | cut -d' ' -f1 )\""
