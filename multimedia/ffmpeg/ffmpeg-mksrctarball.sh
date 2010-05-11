#!/bin/sh
# This script helps you to download and compress the
# sourcecode for ffmpeg from its svn server.

set -e

PRGNAM=ffmpeg
VERSION=$(date +"%Y%m%d")
SVNSERVER=svn://svn.mplayerhq.hu

echo "--> Downloading sourcecode from $SVNSERVER"
svn export $SVNSERVER/$PRGNAM/trunk $PRGNAM-$VERSION 2>&1 | tee svn-$PRGNAM-$VERSION.log

echo "--> Making the sourcecode tarball: $PRGNAM-$VERSION.tar.bz2 "
tar -c $PRGNAM-$VERSION/ | bzip2 > $PRGNAM-$VERSION.tar.bz2

echo "--> Erasing the sourcecode directory: $PRGNAM-$VERSION/"
rm -rf $PRGNAM-$VERSION/

echo "--> Sourcecode tarball for $PRGNAM: $PRGNAM-$VERSION.tar.bz2"
