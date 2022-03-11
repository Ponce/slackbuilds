#!/bin/sh

# Create source tarball from git repo, with generated version number.

# NOTE: if you're copying this to use in another build, get rid of
# the "rm -rf platform" or you might get surprised!

# Takes one optional argument, which is the commit or tag to create a
# tarball of. With no arg, HEAD is used.

# Version number example: 0.0.1+20200227_ad7ec17

# Notes:

# Do not use this if you're packaging a release.

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
# final tarball and slackbuild PRGNAM:
PRGNAM=nblood

# Github project and user names:
PROJNAME=NBlood
GITUSER=nukeykt

# For github projects, you can use this unmodified:
CLONE_URL=https://github.com/$GITUSER/$PROJNAME.git

# For non-github projects, you might not need GITUSER, in which case
# just omit it from the script.

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

# 20211101 bkw: wha? there used to be tags, now they're gone.
#VERTAG=$( git tag -l | tail -1 )
VERTAG=v1.01

VERSION=${VERTAG}+${DATE}_${GIT_SHA}

rm -rf .git
find . -name .gitignore -print0 | xargs -0 rm -f

# NOTE: this line is specific to nblood!
rm -rf platform

cd "$CWD"
rm -rf $PRGNAM-$VERSION $PRGNAM-$VERSION.tar.xz
mv $GITDIR $PRGNAM-$VERSION
tar cvfJ $PRGNAM-$VERSION.tar.xz $PRGNAM-$VERSION

echo
echo "Created tarball: $PRGNAM-$VERSION.tar.xz"
echo "VERSION=\"$VERSION\""
echo "MD5SUM=\"$( md5sum $PRGNAM-$VERSION.tar.xz | cut -d' ' -f1 )\""
