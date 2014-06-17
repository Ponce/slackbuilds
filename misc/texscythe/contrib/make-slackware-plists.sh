#!/bin/sh

# This only requires the big texlive-$VERSION-texmf.tar.xz and
# texlive-$VERSION-extra.tar.xz tarballs to be present in $CWD

# If texlive.tlpdb is not present, it will have to be obtained from
# subversion (based on the # release date), e.g.
# svn co -r {20140525} svn://tug.org/texlive/trunk/Master/tlpkg
# You can then copy tlpkg/texlive.tlpdb to $CWD

set -eu

VERSION=20140525

CWD=$(pwd)
TMF="$CWD/texlive-$VERSION-texmf";

if [ ! -e $CWD/texlive.tlpdb ] ; then
  printf "\nYou need texlive.tlpdb in $CWD - get it here:\n"
  printf "http://ftp.ctex.org/mirrors/CTAN/systems/texlive/tlnet/tlpkg/texlive.tlpdb\n\n"
  exit 1
fi

rm -rf tmplists ; mkdir tmplists

# Initialize the texscyther db
texscyther --initdb

# Build a packaging list for all of the texmf stuff, but exclude docs and src
texscyther \
  --tlpdb $CWD/texlive.tlpdb \
  --nodirs \
  --subset \
    --include scheme-full \
    --exclude scheme-full:doc scheme-full:src \
  --output-plist tmplists/full

# Build a packaging list for the docs (bibarts is for DOS)
texscyther \
  --tlpdb $CWD/texlive.tlpdb \
  --nodirs \
  --subset \
    --include scheme-full:doc \
    --exclude scheme-full:src bibarts \
  --output-plist tmplists/docs

# Build a packaging list for the texmf sources
texscyther \
  --tlpdb $CWD/texlive.tlpdb \
  --nodirs \
  --subset \
    --include scheme-full:src \
    --exclude bibarts \
  --output-plist tmplists/src

# These next bits could probably be done using the --regex option passed to
# texscyther, but I already know how to do it this way :-)

# Filter some stuff out of texmf (build a ladder over UUOC if needed)
cat tmplists/full | \
  grep "texmf-dist/" | \
  grep -v "win32" \
  > full-packlist

# Filter some stuff out of docs (use that ladder again)
cat tmplists/docs | \
  grep "texmf-dist/" | \
  grep -v "context/stubs/mswin/" | \
  grep -v "win32" | \
  grep -v "MinGW" \
  > docs-packlist

# No filtering (for now) of src stuff
cat $CWD/tmplists/src | \
  > $CWD/src-packlist

printf "Generating tarballs - please be patient...\n"

rm -rf $TMF

tar xf texlive-$VERSION-texmf.tar.xz
tar xf texlive-$VERSION-extra.tar.xz
mv texlive-$VERSION-extra/* $TMF && rmdir texlive-$VERSION-extra

rm -rf tarballs ; mkdir tarballs

printf "\tCreating tarballs/texlive-texmf-$VERSION.tar\n"
tar cf \
  tarballs/texlive-texmf-$VERSION.tar \
  -C $TMF \
  -T full-packlist

printf "\tCreating tarballs/texlive-docs-$VERSION.tar\n"
tar cf \
  tarballs/texlive-docs-$VERSION.tar \
  -C $TMF \
  -T docs-packlist

printf "\tCreating tarballs/texlive-src-$VERSION.tar\n"
tar cf \
  tarballs/texlive-src-$VERSION.tar \
  -C $TMF \
  -T src-packlist

printf "Compressing tarballs - please be MOAR patient...\n"
xz -9 tarballs/*.tar

# Cleanup the leftovers
rm -rf tmplists $TMF {full,docs,src}-packlist *.db

