#!/bin/sh

DEST="$HOME/qb64-2.1"
if [ ! -d $DEST ]
then
    mkdir -p $DEST
    cp -axu /opt/qb64-2.1/internal $DEST/
    cp -axu /opt/qb64-2.1/qb64 $DEST/
    fi
cd $DEST
./qb64 &
