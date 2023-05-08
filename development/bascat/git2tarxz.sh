#!/bin/sh

# Create source tarball from repo

# Note that this script doesn't need to be run as root. It does need to
# be able to write to the current directory it's run from.

# Takes one optional argument, which is the commit or tag to create a
# tarball of. With no arg, HEAD is used.

PRGNAM=bascat
CLONE_URL=git://git.distorted.org.uk/~mdw/bascat

set -e

GITDIR=$( mktemp -dt $PRGNAM.git.XXXXXX )
rm -rf $GITDIR
git clone $CLONE_URL $GITDIR

CWD="$( pwd )"
cd $GITDIR

if [ "$1" != "" ]; then
  git reset --hard "$1" || exit 1
fi

GIT_SHA=$( git rev-parse --short HEAD )

DATE=$( git log --date=format:%Y%m%d --format=%cd | head -1 )

VERTAG=$( git tag -l | tail -1 | sed 's,^v,,' )

VERSION=${VERTAG}+${DATE}_${GIT_SHA}

find . -name .git\* -print0 | xargs -0 rm -rf

find . -type f -exec chmod 644 {} \+
find . -type d -exec chmod 755 {} \+

cd "$CWD"
rm -rf $PRGNAM-$VERSION $PRGNAM-$VERSION.tar.xz
mv $GITDIR $PRGNAM-$VERSION
tar cvfJ $PRGNAM-$VERSION.tar.xz $PRGNAM-$VERSION

echo
echo "Created tarball: $PRGNAM-$VERSION.tar.xz"
echo "VERSION=$VERSION"
