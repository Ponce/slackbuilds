#!/bin/sh

# get git tag of of Tribler project release, turn into a src tarball.
# needed because their source archive release is broken (it's
# missing some of its own python libraries).

PRGNAM=tribler
VERSION=6.4.0

GITURL="https://github.com/Tribler/tribler.git"

OUTDIR=$PRGNAM-$VERSION
TARBALL=$OUTDIR.tar.xz

rm -rf $OUTDIR $TARBALL

git clone --branch v$VERSION --recursive --depth 1 "$GITURL" $OUTDIR
find $OUTDIR -name '.git*' -print0 | xargs -0 rm -rf

# there is absolutely no reason to include a giant windows executable.
rm -f $OUTDIR/ffmpeg.exe

tar cvfJ $TARBALL $OUTDIR

# a reminder to myself...
md5sum $TARBALL
echo "Don't forget to update the MD5SUM= line in the .info file"
