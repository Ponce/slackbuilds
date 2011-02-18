#!/bin/bash

# Wrapper script for SBo o2em package, by B. Watson

# Emulator expects to find ./roms, ./bios, ./voice,
# and its config file in the current dir at runtime.

# Also, it expects the ROM it's running, to reside in
# ./roms, so we have to symlink it there :(

# All of this could have been done by hacking up the
# source, but we want to avoid massive amounts of patching.

EXE=/usr/libexec/o2em.bin
SHAREDIR=/usr/share/o2em
DIR=~/.o2em

if [ ! -d $DIR ]; then
  mkdir -p $DIR/roms
  ln -s $SHAREDIR/{bios,voice} $DIR
fi

rom="$1"
if [ ! -e "$rom" ]; then
  exec $EXE "$@"
fi

shift
shortrom="$( basename "$rom" )"
ln -sf "$( readlink -f "$rom" )" $DIR/roms/"$shortrom"

cd $DIR
exec $EXE "$shortrom" "$@"
