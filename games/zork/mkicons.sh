#!/bin/bash

# 20211011 bkw: create zork icon, part of zork.SlackBuild.

set -e

CWD=$( pwd )
mkdir -p $CWD/icons
DIR=$( mktemp -d )
cd $DIR

wget http://www.ifarchive.org/if-archive/infocom/icons/ZorkLetters.zip
unzip ZorkLetters.zip 'ZORK?.ICO'

convert +append ZORKZ.ICO ZORKO.ICO zo.png
convert +append ZORKR.ICO ZORKK.ICO rk.png
convert -append zo.png rk.png $CWD/icons/64.png

convert -resize 48x48 $CWD/icons/64.png $CWD/icons/48.png
convert -resize 32x32 $CWD/icons/64.png $CWD/icons/32.png

rm *.ICO *.png *.zip
cd $CWD
rmdir $DIR

exit 0
