#!/bin/sh

# This script helps you to download and compress the
# sourcecode for ffmpeg from its svn server.
# Copyright (c) 2008 alkos333 <me@alkos333.net>

# Based on ffmpeg-mksrctarball.sh (SlackBuilds.org, Slackware 12.0)

# Thanks to Antonio Hernández Blas for a suggestion on SBo mailing list

set -e

PRGNAM=hdapsd
VERSION=$(date +"%Y%m%d")
GITSERVER=git://repo.or.cz/hdapsd.git

echo "--> Downloading sourcecode from $GITSERVER"
git clone $GITSERVER $PRGNAM-$VERSION 2>&1 

echo "--> Making the sourcecode tarball: $PRGNAM-$VERSION.tar.bz2 "
tar -c $PRGNAM-$VERSION/ | bzip2 -9 > $PRGNAM-$VERSION.tar.bz2

echo "--> Erasing the sourcecode directory: $PRGNAM-$VERSION/"
rm -rf $PRGNAM-$VERSION/

echo "--> Sourcecode tarball for $PRGNAM: $PRGNAM-$VERSION.tar.bz2"
