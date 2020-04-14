#!/bin/sh

# doomretro.sh by B. Watson. Part of the SlackBuilds.org doomretro build.
# Licensed under the WTFPL.

# 20200414 bkw: doomretro on Linux doesn't open any IWAD file by default,
# and doesn't offer a file-chooser dialog. So this wrapper script tries
# to pick a suitable IWAD to use, if it can find one. Notice that this
# only happens if we're run with no arguments.

# Can't use an absolute path for this, or else the engine expects to
# read doomretro.wad and write doomretro.cfg to the same directory as
# the binary.
realbin=doomretro.bin

if [ "$1" ]; then
  # we got arguments, just use them as-is
  exec $realbin "$@"
fi

# no args, so try to find an IWAD and pass it as an arg to the real exe.
wadpath="$DOOMWADDIR:\
$DOOMWADPATH:\
.:\
/usr/share/games/doom:\
/usr/local/share/games/doom:\
/usr/share/doomretro:\
/usr/share/doom:\
/usr/local/doom:\
$HOME:\
$HOME/doom:\
$HOME/.doom:\
$HOME/.doomwads"

iwads="doom2.wad:doom.wad:doom1.wad"

IFS=:
for dir in $wadpath; do
  if [ -d "$dir" ]; then
    for wad in $iwads; do
      wad="$dir/$wad"
      if [ -e "$wad" ]; then
        echo "$( basename $0 ): Using $wad" 1>&2
        exec $realbin "$wad"
      fi
    done
  fi
done

# if we get, no wads found, let the real binary complain about it
exec $realbin
