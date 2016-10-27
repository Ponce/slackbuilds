#!/bin/sh

# wrapper script for domination, part of the SlackBuilds.org
# project. Written by B. Watson, licensed under the WTFPL.

# script is installed as domination and domination-swing, checks how
# it was called to know what java class to invoke.

PRGNAM=domination
USERDIR="$HOME/.$PRGNAM"
SHAREDIR="/usr/share/games/$PRGNAM"

# program expects to read this stuff from the current directory.
LINKS="Domination.jar help lib maps resources"

[ ! -e "$USERDIR" ] && mkdir -p "$USERDIR"
if ! cd "$USERDIR"; then
  echo "$0: failed to create/change to $USERDIR" 1>&2
  exit 1
fi

for dir in $LINKS; do
  [ ! -e $dir ] && ln -s $SHAREDIR/$dir $dir
done

# program expects to write to this stuff in the current dir.
mkdir -p saves
[ ! -e game.ini ] && cat $SHAREDIR/game.ini > game.ini

if [ "$( basename "$0" )" = "$PRGNAM-swing" ]; then
  exec java -cp Domination.jar net.yura.domination.ui.swinggui.SwingGUIFrame "$@"
else
  exec java -jar Domination.jar "$@"
fi
