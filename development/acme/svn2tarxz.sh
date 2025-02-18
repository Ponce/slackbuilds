#!/bin/bash

# create a source tarball from upstream's SVN repo.
# this would be easier, with git.

PRGNAM=acme
URL=https://svn.code.sf.net/p/acme-crossass/code-0/trunk

rm -rf $PRGNAM.svn
svn co $URL $PRGNAM.svn

cd $PRGNAM.svn

svn log -l 1 | grep '^r[0-9]' > logtmp

RELEASE="$( grep '^ *#define  *RELEASE' src/version.h | cut -d'"' -f2 )"
DATE=$( grep '^r[0-9]' logtmp | cut -d'|' -f3 | cut -d' ' -f2 | sed 's,-,,g' )
REV=$( cut -d' ' -f1 logtmp )
VERSION="$RELEASE+${DATE}_$REV"
DIR=$PRGNAM-$VERSION

rm -rf .svn logtmp

cd -
rm -rf $DIR $DIR.tar.xz
mv $PRGNAM.svn $DIR
tar cvfJ $DIR.tar.xz $DIR
echo
md5sum $DIR.tar.xz
