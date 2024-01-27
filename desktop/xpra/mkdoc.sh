#!/bin/sh

# Create the xpra-prebuilt-docs tarball. Part of SlackBuilds.org xpra
# build. Run from within the SlackBuild dir. Does not require root
# acces, but does need to write to its current directory.

set -e

# get VERSION:
source ./xpra.info

OUTDIR=xpra-$VERSION-prebuilt-docs
TARBALL=$OUTDIR.tar.xz

RPMFILE=xpra-common-5.0.4-10.r0.el8.x86_64.rpm
URL=https://www.xpra.org/dists/CentOS/8/x86_64/$RPMFILE

# only download the file if we don't already have it.
[ -e $RPMFILE ] || wget $URL
[ -e $RPMFILE ] || exit 1

rm -rf $OUTDIR
mkdir -p $OUTDIR
cd $OUTDIR

# extract without creating an intermediate tarball (as rpm2targz would):
rpm2cpio ../$RPMFILE | cpio -imd

# remove everything but the docs:
mkdir .keep
mv usr/share/doc/xpra/* .keep
rm -rf *
mv .keep/* .
rmdir .keep

# now ready to create the tarball.
cd -
tar cvfJ $TARBALL $OUTDIR
md5sum $TARBALL
