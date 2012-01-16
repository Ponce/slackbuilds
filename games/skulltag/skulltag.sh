#!/bin/sh

# First time user runs the game, make sure they get an .ini file
# that knows where to find skulltag.pk3 and friends.
if [ ! -e ~/.skulltag/skulltag.ini ]; then
  mkdir -p ~/.skulltag
  cat /usr/share/skulltag/skulltag.ini.default > ~/.skulltag/skulltag.ini
fi

DIR=/usr/@LIB@/skulltag
export LD_LIBRARY_PATH=$DIR
exec $DIR/`basename $0` "$@"
