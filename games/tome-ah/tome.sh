#!/bin/sh
USERDIR=$(pwd)
GAMES_TOME=/usr/share/games/tome-ah/bin
cd $GAMES_TOME
exec ${GAMES_TOME}/tome "$@"
cd $USERDIR
