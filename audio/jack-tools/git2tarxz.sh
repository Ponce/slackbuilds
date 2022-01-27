#!/bin/sh

# Create source tarball from rju (aka jack-tools) git repo, with
# generated version number.

# Note that this script doesn't need to be run as root. It does need to
# be able to write to the current directory it's run from.

# Takes one optional argument, which is the commit or tag to create a
# tarball of. With no arg, HEAD is used.

PRGNAM=jack-tools
CLONE_URL=https://gitlab.com/rd--/rju.git

set -e

GITDIR=$( mktemp -dt $PRGNAM.git.XXXXXX )
rm -rf $GITDIR
git clone --depth 1 $CLONE_URL $GITDIR

CWD="$( pwd )"
cd $GITDIR

if [ "$1" != "" ]; then
  git reset --hard "$1" || exit 1
fi

git submodule update --init --recursive --depth 1

GIT_SHA=$( git rev-parse --short HEAD )

DATE=$( git log --date=format:%Y%m%d --format=%cd | head -1 )

VERSION=${DATE}_${GIT_SHA}

rm -rf .git cmd/r-common/.git

cd "$CWD"
rm -rf $PRGNAM-$VERSION $PRGNAM-$VERSION.tar.xz
mv $GITDIR $PRGNAM-$VERSION
tar cvfJ $PRGNAM-$VERSION.tar.xz $PRGNAM-$VERSION

echo
echo "Created tarball: $PRGNAM-$VERSION.tar.xz"
echo "VERSION=$VERSION"
