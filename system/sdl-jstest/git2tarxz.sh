#!/bin/sh

# Create source tarball from sdl-jstest git repo, with generated version
# number. Since the build expects to have the git log available (for
# embedding the git hash in --version output), don't rm -rf .git,
# but do use --depth 1 when cloning.

# Note that this script doesn't need to be run as root. It does need to
# be able to write to the current directory it's run from.

# Takes one optional argument, which is the commit or tag to create a
# tarball of. With no arg, HEAD is used.

PRGNAM=sdl-jstest
CLONE_URL=https://gitlab.com/$PRGNAM/$PRGNAM.git

set -e

GITDIR=$( mktemp -dt $PRGNAM.git.XXXXXX )
rm -rf $GITDIR
git clone --depth 1 $CLONE_URL $GITDIR

CWD="$( pwd )"
cd $GITDIR

if [ "$1" != "" ]; then
  git reset --hard "$1" || exit 1
fi

git submodule update --init --recursive

GIT_SHA=$( git rev-parse --short HEAD )

DATE=$( git log --date=format:%Y%m%d --format=%cd | head -1 )

VERSION=${DATE}_${GIT_SHA}

mv .git .keep.git
find . -name .git\* -print0 | xargs -0 rm -rf
mv .keep.git .git
rm -rf .git/modules .git/hooks

cd "$CWD"
rm -rf $PRGNAM-$VERSION $PRGNAM-$VERSION.tar.xz
mv $GITDIR $PRGNAM-$VERSION
tar cvfJ $PRGNAM-$VERSION.tar.xz $PRGNAM-$VERSION

echo
echo "Created tarball: $PRGNAM-$VERSION.tar.xz"
echo "VERSION=$VERSION"
