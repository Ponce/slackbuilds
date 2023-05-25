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
  mkdir $USERDIR
  cd $USERDIR
  for i in $LIBDIR/*; do
    ln -s $i $( basename $i )
  done
fi

cd $USERDIR

if [ "$ARG" = "" ]; then
  exec $REALBIN
else
  exec $REALBIN "$ARG"
fi
