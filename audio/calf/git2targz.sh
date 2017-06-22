#!/bin/sh

PRGNAM=calf
URL=https://github.com/calf-studio-gear/$PRGNAM.git
DATE=$( date +%Y%m%d )

rm -rf $PRGNAM
git clone $URL $PRGNAM
cd $PRGNAM
REV=$( git rev-parse --short @ )
rm -rf .git*
cd -

VERSION=$DATE.$REV
rm -rf $PRGNAM-$VERSION
mv $PRGNAM $PRGNAM-$VERSION
tar cvfJ $PRGNAM-$VERSION.tar.xz $PRGNAM-$VERSION
