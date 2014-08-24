#!/bin/sh

# This requires the texlive-$VERSION-texmf.tar.xz (large) and
# texlive-$VERSION-extra.tar.xz tarballs to be present in $CWD
# ftp://tug.org/historic/systems/texlive/2014/texlive-20140525-texmf.tar.xz
# ftp://tug.org/historic/systems/texlive/2014/texlive-20140525-extra.tar.xz

# If texlive.tlpdb is not present, it will have to be obtained from 
# subversion (based on the # release date), e.g.
# svn co -r {20140525} svn://tug.org/texlive/trunk/Master/tlpkg
# You can then copy tlpkg/texlive.tlpdb to $CWD

set -eu

VERSION=20140525

pkglist=${pkglist:-"texmf-tetexish texmf-extra texmf-docs texmf-src"}

CWD=$(pwd)
TMP=${TMP:-$CWD/tmplists}
PACKLISTS=${PACKLISTS:-$CWD/packlists}
TARBALLS=${TARBALLS:-$CWD/tarballs}

export CWD TMP PACKLISTS TARBALLS

TMF="$CWD/texlive-$VERSION-texmf";

if [ ! -e $CWD/texlive.tlpdb ] ; then
  printf "\nYou need texlive.tlpdb in $CWD - get it here:\n"
  printf "http://harrier.slackbuilds.org/texlive-2014/texscythe/contrib/texlive.tlpdb\n\n"
  exit 1 
fi

printf "\nMaking these tarballs: $pkglist\n\n" ; sleep 2

rm -rf $TMP $PACKLISTS
mkdir -p $TMP $PACKLISTS

# Initialize the texscyther db
if [ ! -r $CWD/$CWD/texscythe.db ]; then
  texscyther --initdb --sqldb $CWD/texscythe.db
fi

for pkg in $(printf "$pkglist") ; do ./helpers/$pkg ; done

if [ ! -d $TMF ]; then
  printf "Extracting sources to create tarballs - please be patient...\n"
  tar xf texlive-$VERSION-texmf.tar.xz
  tar xf texlive-$VERSION-extra.tar.xz
  mv texlive-$VERSION-extra/* $TMF && rmdir texlive-$VERSION-extra
fi

printf "Creating tarballs - please be moar patient...\n"
rm -rf $TARBALLS ; mkdir -p $TARBALLS

for pkg in $(printf "$pkglist") ; do \
  printf "\tCreating $TARBALLS/texlive-$pkg-$VERSION.tar\n"
    tar cf $TARBALLS/texlive-$pkg-$VERSION.tar -C $TMF \
           -T $PACKLISTS/$pkg-packlist
done

printf "Compressing tarballs - please be MOAR patient...\n"
xz -9 $TARBALLS/*.tar

# Cleanup the leftovers
rm -rf $TMP $PACKLISTS #$TMF #leave TMF for now

