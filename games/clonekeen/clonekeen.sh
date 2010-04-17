#!/bin/sh

set -e

GAME=clonekeen
HOMEDIR=~/.$GAME
mkdir -p $HOMEDIR
cd $HOMEDIR
if [ -e defaultargs ]; then
  ARGS="`cat defaultargs`"
fi
ln -s /usr/share/games/$GAME/* . &>/dev/null || true
exec $GAME-bin "$@" $ARGS
