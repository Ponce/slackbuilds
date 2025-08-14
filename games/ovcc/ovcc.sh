#!/bin/bash

# wrapper script for ovcc, makes it play nicer with unixey systems.
# it expects to find loadable media (ROMs and shared libs that emulate
# peripherals) in the current dir, when it's run.

PRGNAM=ovcc
REALBIN=/usr/libexec/$PRGNAM/$PRGNAM
USERDIR=~/.$PRGNAM
LIBDIR=/usr/lib@64@/$PRGNAM

# ovcc takes one optional argument, the name of a "quickload" file,
# which must end in .rom, .ccc, or .bin. since we're changing
# directories, we have to get the absolute path of the argument,
# if present. yes, this works even with spaces in the filename.
ARG="$1"
if [ "$ARG" != "" ]; then
  ARG="$( realpath "$ARG" )"
fi

set -e

if [ ! -d $USERDIR ]; then
  mkdir $USERDIR || exit 1
fi

cd $USERDIR || exit 1

# 20250814 bkw: had to change this because I share /home between 32-bit
# and 64-bit. If the symlinks to /usr/lib64 exist, and I run the 32-bit
# ovcc, they point to the wrong dir. Now, if there are broken symlinks,
# they get recreated properly.
for i in $LIBDIR/*; do
  f="$( basename $i )"
  [ -e "$f" ] || ln -sf "$i" "$f"
done

if [ "$ARG" = "" ]; then
  exec $REALBIN
else
  exec $REALBIN "$ARG"
fi
