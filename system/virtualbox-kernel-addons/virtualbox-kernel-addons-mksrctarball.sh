#!/bin/sh
# This script helps you to make the source package
# of the virtualbox guest additions kernel modules.
# IMPORTANT: The virtualbox-ose-addons version you want to use
# must already be installed!

# Based on the ffmpeg-mksrctarball.sh from the SlackBuilds.org repository

set -e

PRGNAM=virtualbox-kernel-addons
VERSION=$(VBoxControl --help 2>/dev/null | grep OSE | rev | cut -d " " -f 1 | rev | cut -d "_" -f 1)

mkdir $PRGNAM

echo "--> Copying sourcecode from /usr/src"
cp -rf /usr/src/vboxguest-$VERSION $PRGNAM/vboxguest
cp -rf /usr/src/vboxsf-$VERSION $PRGNAM/vboxsf
cp -rf /usr/src/vboxvideo-$VERSION $PRGNAM/vboxvideo

echo "--> Making the sourcecode tarball: $PRGNAM-src-$VERSION.tar.xz"
tar -cJf $PRGNAM-$VERSION.tar.xz $PRGNAM

echo "--> Erasing the sourcecode directory: $PRGNAM/"
rm -rf $PRGNAM/

echo "--> Sourcecode tarball for $PRGNAM: $PRGNAM-$VERSION.tar.xz"
