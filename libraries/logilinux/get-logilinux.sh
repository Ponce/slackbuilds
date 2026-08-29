#!/bin/sh

#!# Set at least these two #!#
#
PRGNAM=logilinux

set -e

# Clear download area:
rm -rf $PRGNAM

# Clone repository:
git clone git@github.com:$PRGNAM/$PRGNAM.git

HEADISAT="$( cd $PRGNAM && git log -1 --format=%h )"
DATE="$( cd $PRGNAM && git log -1 --format=%cd --date=format:%Y%m%d )"
VERSION="${DATE}_${HEADISAT}"

echo "DATE = $DATE"
echo "HEADISAT = $HEADISAT"


# Generate tarball
echo "Generating tarball ..."
( cd $PRGNAM && find . -name ".git*" -exec rm -rf {} \; 2>/dev/null || true )
mv $PRGNAM $PRGNAM-$VERSION
tar cf $PRGNAM-$VERSION.tar $PRGNAM-$VERSION
plzip -9 $PRGNAM-$VERSION.tar
rm -rf $PRGNAM-$VERSION
echo
echo "$PRGNAM tarball generated as $PRGNAM-$VERSION.tar.lz"
echo "MD5SUM is: $(md5sum  $PRGNAM-$VERSION.tar.lz)"
echo
