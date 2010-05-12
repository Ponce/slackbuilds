#!/bin/sh
# This script helps you to make the source package
# of the virtualbox host kernel module.
# IMPORTANT: The virtualbox-ose version you want to use
# must already be installed!

# Based on the ffmpeg-mksrctarball.sh from the SlackBuilds.org repository

set -e

PRGNAM=virtualbox-kernel
VERSION=$(VBoxManage -v | grep -e ^[0-9].*_OSE | cut -d "_" -f 1)

MODULE_SRC=$(grep "MODULE_SRC=" /etc/vbox/vbox.cfg | cut -d "=" -f 2 | cut -d "\"" -f 2)

echo "--> Copying sourcecode from $MODULE_SRC/$PRGNAM-$VERSION"
cp -rf $MODULE_SRC/$PRGNAM-$VERSION $PRGNAM-$VERSION

echo "--> Making the sourcecode tarball: ./$PRGNAM-$VERSION.tar.xz"
tar -cJf $PRGNAM-$VERSION.tar.xz $PRGNAM-$VERSION

echo "--> Erasing the sourcecode directory: ./$PRGNAM-$VERSION/"
rm -rf $PRGNAM-$VERSION/

echo "--> Sourcecode tarball for $PRGNAM: $(pwd)/$PRGNAM-$VERSION.tar.xz"
