#!/bin/sh
# This script helps you to make the source package
# of the virtualbox guest additions kernel modules.
# IMPORTANT: The virtualbox-ose-addons version you want to use
# must already be installed!

# Based on the ffmpeg-mksrctarball.sh from the SlackBuilds.org repository

set -e

PRGNAM=virtualbox-kernel-addons
VERSION=$(VBoxControl --help 2>/dev/null | grep OSE | cut -d " " -f 9 | cut -d "_" -f 1)

mkdir $PRGNAM

echo "--> Copying sourcecode from /usr/src"
cp -rf /usr/src/vboxadd-$VERSION $PRGNAM/vboxadd
cp -rf /usr/src/vboxvfs-$VERSION $PRGNAM/vboxvfs

echo "--> Making the sourcecode tarball: $PRGNAM-src-$VERSION.tar.bz2 "
tar -c $PRGNAM/ | bzip2 > $PRGNAM-$VERSION.tar.bz2

echo "--> Erasing the sourcecode directory: $PRGNAM/"
rm -rf $PRGNAM/

echo "--> Sourcecode tarball for $PRGNAM: $PRGNAM-$VERSION.tar.bz2"
