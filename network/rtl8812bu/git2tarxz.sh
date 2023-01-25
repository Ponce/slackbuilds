#!/bin/sh

# Create source tarball from git repo. Takes a branch (not a commit or tag)
# as an argument! Warning, this is different from all the other git2tarxz
# scripts on SBo!

# Note that this script doesn't need to be run as root. It does need to
# be able to write to the current directory it's run from.

# Takes one optional argument, which is the *branch* to create a
# tarball of. With no arg, this is used:
BRANCH=${1:-v5.13.1}

PRGNAM=rtl8812bu
CLONE_URL=https://github.com/fastoe/RTL8812BU

set -e

GITDIR=$( mktemp -dt $PRGNAM.git.XXXXXX )
rm -rf $GITDIR
git clone -b $BRANCH $CLONE_URL $GITDIR

CWD="$( pwd )"
cd $GITDIR

GIT_SHA=$( git rev-parse --short HEAD )

DATE=$( git log --date=format:%Y%m%d --format=%cd | head -1 )

# don't want our tarball's version number to start with "v":
VERTAG=$( echo $BRANCH | sed 's,^v,,' )

VERSION=${VERTAG}+${DATE}_${GIT_SHA}

find . -name .git\* -print0 | xargs -0 rm -rf

cd "$CWD"
rm -rf $PRGNAM-$VERSION $PRGNAM-$VERSION.tar.xz
mv $GITDIR $PRGNAM-$VERSION
tar cvfJ $PRGNAM-$VERSION.tar.xz $PRGNAM-$VERSION

echo
echo "Created tarball: $PRGNAM-$VERSION.tar.xz"
echo "VERSION=$VERSION"
