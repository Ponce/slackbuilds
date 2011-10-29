#!/bin/bash

# Repackage the official UltimaIV.zip from http://www.ultimaforever.com/
# so that its zip file structure is the more-or-less the same as the dragon
# release listed in the .info file. Also the official release includes the
# PDF docs, so we pack them into ultima4_scanned_docs.zip like the build
# script expects.

# The resulting package will be missing Keyboard.txt. Since the contents
# of Keyboard.txt are in the man page, I don't see it as a problem. The
# package will also have an extra copy of the map (Map.jpg), higher res
# than Map.bmp, but scanned from a creased map.

SRCZIP="$1"
if [ -z "$SRCZIP" -o ! -e "$SRCZIP" ]; then
	echo "Usage: $0 /full/path/to/UltimaIV.zip"
fi

TMP=${TMP:-/tmp/SBo}
WORK=$TMP/u4_repackage

set -e

OUTPUT="$( dirname $SRCZIP )"

rm -rf $WORK
mkdir -p $WORK
cd $WORK
unzip "$SRCZIP"

# The manuals & map. This map is a jpeg, higher quality than the
# bmp version, except the jpeg was scanned from a map with a big
# crease in the middle. The dragon release lacks the jpeg map,
# so the SlackBuild script will be smart enough to handle the
# case where it's missing.
mkdir ultima4_scanned_docs
mv ultima4/EXTRAS/*.pdf ultima4_scanned_docs
zip -r "$OUTPUT/ultima4_scanned_docs.zip" ultima4_scanned_docs
mv "ultima4/EXTRAS/UltimaIV_Cloth Map.jpg" ultima4/Map.jpg
rm -rf ultima4_scanned_docs ultima4/EXTRAS

# dragon release has no containing directory inside the zipfile, so work
# from here.
cd ultima4

# Rename some files:

# The low-res (but not creased) map.
mv MAP.BMP Map.bmp

# there is no KEYBOARD.TXT. Use the word doc or the man page.
# there is no README.TXT. It doesn't apply to xu4 anyway.
mv HINTS.TXT Hints.txt
mv WISDOM.TXT Wisdom.txt
mv HISTORY.TXT History.txt

mv KEYBOARD.DOC "Keyboard Reference.doc"
# Readme.doc is different but has the same name. We don't need it anyway.
mv HINTS.DOC Hints.doc
mv THEBOOKO.DOC "The Book of Mystic Wisdom.doc"
mv THEHISTO.DOC "The History of Britannia.doc"

zip -r "$OUTPUT/ultima4.zip" .

if [ "$2" != "--keep" ]; then
	cd $TMP
	rm -rf $WORK
fi
