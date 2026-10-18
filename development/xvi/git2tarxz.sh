#!/bin/sh

# Create source tarball from git repo, with generated version
# number.

# Note that this script doesn't need to be run as root. It does
# need to be able to write to the current directory it's run from.

# Takes one optional argument, which is the commit or tag to create
# a tarball of. With no arg, HEAD is used.

# xvi upstream doesn't use tags. Extract version number from man page.

PRGNAM=xvi
CLONE_URL=http://codeberg.org/martinwguy/xvi

set -e

GITDIR=$( mktemp -dt $PRGNAM.git.XXXXXX )
rm -rf $GITDIR
git clone $CLONE_URL $GITDIR

CWD="$( pwd )"
cd $GITDIR

if [ "$1" != "" ]; then
  git reset --hard "$1" || exit 1
fi

MANVER="$( grep '^\.TH' doc/xvi.1 | cut -d' ' -f4 )"

GIT_SHA=$( git rev-parse --short HEAD )

DATE=$( git log --date=format:%Y%m%d --format=%cd | head -1 )

VERSION=$MANVER+${DATE}_${GIT_SHA}

rm -rf .git
find . -name .gitignore -print0 | xargs -0 rm -f

cd "$CWD"
rm -rf $PRGNAM-$VERSION $PRGNAM-$VERSION.tar.xz
mv $GITDIR $PRGNAM-$VERSION
tar cvfJ $PRGNAM-$VERSION.tar.xz $PRGNAM-$VERSION

echo
echo "Created tarball: $PRGNAM-$VERSION.tar.xz"
echo "VERSION=$VERSION"
