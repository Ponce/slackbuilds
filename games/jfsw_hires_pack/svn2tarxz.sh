#!/bin/bash

# create a source tarball from upstream's SVN repo.
# this would be easier, with git.

PRGNAM=jfsw_hires_pack
URL=http://svn.eduke32.com/sw_hrp/

rm -rf sw_hrp
svn co $URL

cd sw_hrp

svn log -l 1 | grep '^r[0-9]' > logtmp

DATE=$( grep '^r[0-9]' logtmp | cut -d'|' -f3 | cut -d' ' -f2 | sed 's,-,,g' )
REV=$( cut -d' ' -f1 logtmp )
VERSION="${DATE}_$REV"
DIR=$PRGNAM-$VERSION

rm -rf .svn logtmp

cd -
rm -rf $DIR $DIR.tar.xz
mv sw_hrp $DIR
tar cvfJ $DIR.tar.xz $DIR
echo
md5sum $DIR.tar.xz
