#!/bin/sh

# Create source tarball from git repo, with generated version
# number.

# Note that this script doesn't need to be run as root. It does
# need to be able to write to the current directory it's run from.

# This git2tarxz's output is a tarball with 2 separate projects.
# Upstream doesn't use tags. The version number of the tarball is the
# version of vwm, taken from vwm.h, plus the commit date and hash of
# the vwm tree. The libvterm version isn't included in the version
# number.

PRGNAM=vwm
PRGURL=https://github.com/TragicWarrior/vwm
LIBURL1=https://github.com/TragicWarrior/libvterm
LIBURL2=https://github.com/TragicWarrior/libviper

set -e

CWD="$( pwd )"

GITDIR=$( mktemp -dt $PRGNAM.git.XXXXXX )
rm -rf $GITDIR
mkdir -p $GITDIR

cd $GITDIR

git clone $PRGURL
git clone $LIBURL1
git clone $LIBURL2

cd $PRGNAM
GIT_SHA=$( git rev-parse --short HEAD )

DATE=$( git log --date=format:%Y%m%d --format=%cd | head -1 )

RELVER="$( grep '#define *VWM_VERSION' vwm.h | cut -d'"' -f2 )"
VERSION=$RELVER+${DATE}_${GIT_SHA}

cd -

rm -rf */.git
find . -name .gitignore -print0 | xargs -0 rm -f

cd "$CWD"
rm -rf $PRGNAM-$VERSION $PRGNAM-$VERSION.tar.xz
mv $GITDIR $PRGNAM-$VERSION
tar cvfJ $PRGNAM-$VERSION.tar.xz $PRGNAM-$VERSION

echo
echo "Created tarball: $PRGNAM-$VERSION.tar.xz"
echo "VERSION=$VERSION"
