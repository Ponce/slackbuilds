#!/bin/sh
# This script helps you to make the source package
# of the virtualbox host kernel module.
# IMPORTANT: The virtualbox-ose version you want to use
# must already be installed!

# Based on the ffmpeg-mksrctarball.sh from the SlackBuilds.org repository

set -e

PRGNAM=vbox-kernel-module
SRCNAM=vboxdrv
VBOX_VERSION=$(VBoxManage -v | grep -e ^[0-9].*_OSE)
VERSION=${VBOX_VERSION:0:5}

MODULE_SRC=$(grep "MODULE_SRC=" /etc/vbox/vbox.cfg | cut -d "=" -f 2 | cut -d "\"" -f 2)

echo "--> Copying sourcecode from $INSTALL_DIR/src"
cp -rf $MODULE_SRC/$SRCNAM-$VERSION $SRCNAM

echo "--> Making the sourcecode tarball: $PRGNAM-src-$VERSION.tar.bz2 "
tar -c $SRCNAM/ | bzip2 > $PRGNAM-src-$VERSION.tar.bz2

echo "--> Erasing the sourcecode directory: $SRCNAM/"
rm -rf $SRCNAM/

echo "--> Sourcecode tarball for $PRGNAM: $PRGNAM-src-$VERSION.tar.bz2"
