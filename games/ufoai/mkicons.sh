#!/bin/sh

# create PNG icons for ufoai.
# requires icoutils and perl-rename from SBo.
# this is a support script, not to be run from within the SlackBuild.
# please do not remove this from git!

SRC=${TMP:-/tmp}/SBo/ufoai-${VERSION:-2.5}

mkdir -p icons
cd icons
for i in $SRC/build/projects/*.ico; do
  name="$( basename $i .ico )"
  mkdir -p $name
  ( cd $name
    icotool -x $i
    rename.pl 's,.*_(\d+)x.*,$1.png,' *
  )
done

# upstream doesn't ship 64x64 icons, let's make them.
convert -resize 64x64 ufo/256.png ufo/64.png
convert -resize 64x64 ufoded/256.png ufoded/64.png

# the radiant icon is tiny, make a better one.
mkdir -p uforadiant
composite radiant/32.png ufo/64.png -geometry +16+28 uforadiant/64.png
convert -resize 48x48 uforadiant/64.png uforadiant/48.png
convert -resize 32x32 uforadiant/64.png uforadiant/32.png
convert -resize 16x16 uforadiant/64.png uforadiant/16.png
rm -rf radiant
