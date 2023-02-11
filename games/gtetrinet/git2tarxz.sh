#!/bin/sh

# Create source tarball from git repo, with generated version number.

# This is not a generic git2tarxz script, it's specific to gtetrinet.
# Upstream doesn't use tags for version bumps, so the version number
# is extracted from configure.ac.

# Takes one optional argument, which is the commit or tag to create a
# tarball of. With no arg, HEAD is used.

# Version number example: 0.0.1+20200227_ad7ec17

## Config:
PRGNAM=gtetrinet
CLONE_URL=https://github.com/tatankat/gtetrinet
## End of config.

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

VERMAIN="$( grep AC_INIT configure.ac | cut -d, -f2 | sed 's,\[\(.*\)\],\1,' )"
VERSION=${VERMAIN}_${DATE}_${GIT_SHA}

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
