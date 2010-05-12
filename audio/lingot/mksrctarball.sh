#!/bin/sh

# Create a source tarball from the lingot CVS repository.
# The result will be /tmp/lingot-$VERSION.tar.xz

REV=${1:-20091225}

TMP=${TMP:-/tmp}
WORKDIR=$TMP/tarball.$$.$RANDOM

set -e

rm -rf $WORKDIR
mkdir -p $WORKDIR
cd $WORKDIR

cvs \
		 -d:pserver:anonymous@cvs.savannah.nongnu.org:/sources/lingot \
		 export \
		 -D "$REV" \
		 lingot

mv lingot lingot-$REV
tar cvfJ $TMP/lingot-$REV.tar.xz lingot-$REV
md5sum $TMP/lingot-$REV.tar.xz
cd $TMP
rm -rf $WORKDIR
