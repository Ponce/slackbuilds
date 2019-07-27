#!/bin/sh
USERDIR=$(pwd)
cd /usr/share/games/larn
./larn $1
cd $USERDIR
