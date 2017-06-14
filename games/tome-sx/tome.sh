#!/bin/sh
GAMES_TOME=/usr/share/games/tome-sx
cd $GAMES_TOME
exec ${GAMES_TOME}/tome "$@"
