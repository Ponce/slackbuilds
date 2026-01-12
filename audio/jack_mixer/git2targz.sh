#!/bin/sh

set -e

source /etc/sbopkg/sbopkg.conf

PRGNAM=jack_mixer
URL=https://github.com/synthnassizer/$PRGNAM.git
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
mv $PRGNAM-$VERSION.tar.xz $SRCDIR/
ln -s $SRCDIR/$PRGNAM-$VERSION.tar.xz

MD5SUM=$(md5sum $PRGNAM-$VERSION.tar.xz | awk '{print $1}')

sed -i -E "s|VERSION=.*|VERSION=\"$VERSION\"|g" jack_mixer.info
sed -i -E "s|MD5SUM=.*|MD5SUM=\"$MD5SUM\"|g" jack_mixer.info
sed -i -E "s|DOWNLOAD=.*|DOWNLOAD=\"$URL\"|g" jack_mixer.info

sed -i -E "s|^VERSION=\\$\{VERSION:\-git\}|VERSION=\\$\{VERSION:-$VERSION\}|g" jack_mixer.SlackBuild
