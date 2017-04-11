#!/bin/sh

# shell script wrapper for cosmic_assault, written by B. Watson
# for SlackBuilds.org, licensed under the WTFPL.

# this script is necessary because the game only looks in the current
# directory for its data/ directory, which must also be writable due to
# it writing the high score save file there (with no error checking!)

PRGNAM=cosmic_assault
SHAREDIR=/usr/share/games/$PRGNAM
HOMEDIR=$HOME/.$PRGNAM

set -e
mkdir -p $HOMEDIR
cd $HOMEDIR
[ ! -e data ] && ln -s $SHAREDIR/data data
exec $SHAREDIR/$PRGNAM.py
