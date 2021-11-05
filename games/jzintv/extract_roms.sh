#!/bin/bash

# extract_roms.sh: find the Intellivision and/or ECS ROM images,
# either as zip files (which get unzipped) or as extracted contents,
# and copy them to the destination dir (if it exists). This script is
# intended to be run by jzintv.SlackBuild.

# First arg: the SlackBuild dir ($CWD in the caller).
srcdir="$1"

# 2nd arg: where the .bin files should go ($ROMDIR in the caller).
destdir="$2"

# Full list of dirs where we'll look for ROMs.
alldirs="$srcdir /usr/share/jzintv/rom /usr/share/games/jzintv/rom /usr/share/games/mame/roms ${JZINTV_ROM_PATH//: }"

echo "=== Will search for ROMs in: $alldirs"

# nocaseglob means we can handle intv.zip, intv.ZIP, INTV.ZIP, etc.
shopt -s nocaseglob

shopt -s nullglob

# First, extract any likely-looking zip files we find.
for dir in $alldirs; do
  [ -d $dir ] || continue
  for zipfile in $dir/intv*.zip $dir/ecs*.zip; do
    echo "===> Extracting $zipfile"
    unzip -o -LL $zipfile '*.rom' '*.bin' '*.int' '*.20' '*.70' '*.e0' '*.u21'
  done
  cd -
done

# Handle MAME/MESS split rom.
if [ -e ecs_rom.20 -a -e ecs_rom.70 -a -e ecs_rom.e0 ]; then
  echo "===> found split ECS ROM, combining"
  cat ecs_rom.20 ecs_rom.70 ecs_rom.e0 > ecs.bin
fi

# Handle the new MAME name for grom.bin.
if [ -e "ro-3-9503-003.u21" ]; then
  echo "===> found MAME's ro-3-9503-003.u21, renaming to grom.bin"
  mv ro-3-9503-003.u21 grom.bin
fi

# Now look for the actual ROMs, including any we just extracted above.
for dir in $(pwd) $alldirs; do
  [ -d $dir ] || continue
  echo "===> Looking for unzipped ROMs in $dir"
  for file in $dir/{exec,grom,ecs}.{rom,bin,int}*; do
    tmp_name="$( echo $file | tr A-Z a-z | sed 's,\.[^.]*$,.bin,' )"
    dest_name="$( basename $tmp_name )"
    if [ "$dest_name" = "intv_ecs.bin" ]; then
      dest_name="ecs.bin"
    fi
    size="$( stat -c %s "$file" )"
    echo "===> candidate for $dest_name: $file, size $size"
    case "$dest_name" in
      grom.bin)
        [ "$size" != 2048 ] && break ;;
      exec.bin)
        [ "$size" != 8192 ] && break ;;
      esc.bin)
        [ "$size" != 24576 ] && break ;;
    esac
    case "$dest_name" in
      grom.bin|exec.bin|ecs.bin)
        echo "===> found $dest_name as $file"
        [ -d "$destdir" ] && cp "$file" "$destdir/$dest_name"
        ;;
    esac
  done
done
