#!/bin/sh

# Create source tarball from cc65 git repo, with generated version
# number. We don't want to include the whole git history in the tarball,
# but we do want to build the git hash into the binary (for --version),
# so there's a bit of extra stuff here.

# Note that this script doesn't need to be run as root. It does
# need to be able to write to the current directory it's run from.

# Takes one optional argument, which is the commit or tag to create
# a tarball of. With no arg, HEAD is used.

PRGNAM=cc65
CLONE_URL=https://github.com/$PRGNAM/$PRGNAM.git

set -e

GITDIR=$( mktemp -dt cc65.git.XXXXXX )
rm -rf $GITDIR
git clone $CLONE_URL $GITDIR

CWD="$( pwd )"
cd $GITDIR

if [ "$1" != "" ]; then
  git reset --hard "$1" || exit 1
fi

GIT_SHA=$( git rev-parse --short HEAD )
sed -i "1iGIT_SHA=$GIT_SHA" src/Makefile

# 6878ede and earlier commits are missing a \ in src/Makefile, which
# causes the git hash *not* to be part of --version output. Fix, if
# needed.
sed -i '/-DLD65_LIB[^\\]*$/s,$, \\,' src/Makefile

DATE=$( git log --date=format:%Y%m%d --format=%cd | head -1 )

VERFILE=src/common/version.c
MAJOR=$( sed -n 's,#define\s\+VER_MAJOR\s\+\([0-9]\+\)U.*,\1,p' $VERFILE )
MINOR=$( sed -n 's,#define\s\+VER_MINOR\s\+\([0-9]\+\)U.*,\1,p' $VERFILE )

VERSION=${MAJOR}.${MINOR}_$DATE

rm -rf .git
find . -name .gitignore -print0 | xargs -0 rm -f

# DIRTY HACK ALERT:
# -current's linuxdoc-tools hates upstream's sgml docs, and it's not
# obvious what's wrong (bug/regression in linuxdoc-tools? 14.2's worked
# fine). I'm not interested in trying to fix the problem because I
# fucking hate XML, and I especially hate the mess that's the Slackware
# linuxdoc-tools (28 source tarballs, interdependent). So I'll just
# include pre-generated (on 14.2) HTML docs in my self-hosted source
# tarball.
make -C doc html

cd "$CWD"
rm -rf $PRGNAM-$VERSION $PRGNAM-$VERSION.tar.xz
mv $GITDIR $PRGNAM-$VERSION
tar cvfJ $PRGNAM-$VERSION.tar.xz $PRGNAM-$VERSION

echo
echo "Created tarball: $PRGNAM-$VERSION.tar.xz"
echo "VERSION=$VERSION"
