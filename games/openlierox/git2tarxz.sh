#!/bin/sh

# Create source tarball from git repo, with generated version
# number.

# Note that this script doesn't need to be run as root. It does
# need to be able to write to the current directory it's run from.

# Takes one optional argument, which is the commit or tag to create
# a tarball of. With no arg, HEAD is used.

# If you're using this as a template for another script, beware it
# has openlierox-specific code! A bunch of windows/osx/ios specific
# directories get deleted.

PRGNAM=openlierox
CLONE_URL=https://github.com/albertz/openlierox

set -e

GITDIR=$( mktemp -dt $PRGNAM.git.XXXXXX )
rm -rf $GITDIR
git clone --depth 1 $CLONE_URL $GITDIR

CWD="$( pwd )"
cd $GITDIR

if [ "$1" != "" ]; then
  git reset --hard "$1" || exit 1
fi

GIT_SHA=$( git rev-parse --short HEAD )

DATE=$( git log --date=format:%Y%m%d --format=%cd | head -1 )

VERSION=${DATE}_${GIT_SHA}

rm -rf .git
find . -name .gitignore -print0 | xargs -0 rm -f

# 20220301 bkw: remove the stuff we don't need.
rm -rf build libs/breakpad/src/*/{windows,mac,ios} tools/*/build \
       tools/OLXDedServerWindowsService

cd "$CWD"
rm -rf $PRGNAM-$VERSION $PRGNAM-$VERSION.tar.xz
mv $GITDIR $PRGNAM-$VERSION
tar cvfJ $PRGNAM-$VERSION.tar.xz $PRGNAM-$VERSION

echo
echo "Created tarball: $PRGNAM-$VERSION.tar.xz"
echo "VERSION=$VERSION"
