#!/bin/sh

PRGNAM=mcwm

source ./$PRGNAM.info || exit 1

SRCVER=${VERSION/_/-}

[ -e config.h ] && mv -b config.h config.h.old
tar xvfO $PRGNAM-$SRCVER.tar.bz2 --wildcards \*/config.h > config.h
