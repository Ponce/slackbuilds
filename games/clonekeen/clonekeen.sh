#!/bin/sh

set -e

GAME=clonekeen
HOMEDIR=~/.$GAME
mkdir -p $HOMEDIR
cd $HOMEDIR

ln -s /usr/share/games/$GAME/* . &>/dev/null || true

if [ ! -e keen.conf ]; then
  cat keen.conf.default > keen.conf
fi

exec $GAME-bin "$@" $ARGS
