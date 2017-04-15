#!/bin/sh

# SBo wrapper script for asteroidsinfinity, by B. Watson.
# Licensed under the WTFPL.

SHAREDIR=/usr/share/games/asteroidsinfinity
HOMEDIR=$HOME/.asteroidsinfinity

set -e

mkdir -p $HOMEDIR
cd $HOMEDIR
for src in $SHAREDIR/*; do
  dst="$( basename $src )"
  [ -e "$dst" ] || ln -s "$src" "$dst"
done

exec python ./AsteroidsInfinity.py "$@"
