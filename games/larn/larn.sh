#!/bin/sh
USERDIR=$(pwd)
cd /usr/share/games/larn
exec /usr/share/games/larn "$@"
cd $USERDIR
