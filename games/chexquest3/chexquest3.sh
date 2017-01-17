#!/bin/bash

# Wrapper script for chexquest3, part of the SlackBuilds.org project.
# Finds a usable Doom engine and uses it to run the game.

# The IWAD. Actually, for some reason, its header defines it as a PWAD.
# But it really is an IWAD. Go figure.
WAD=/usr/share/games/doom/chex3.wad

# The list is restricted to engines that (a) are on SBo, and (b) can
# actually play Chex Quest 3.

# These were tested, and don't work:
# chocolate-doom crispy-doom odamex prboom prboom-plus doomretro doomsday

# These were tested, and do work... though skulltag has issues.
ENGINES="gzdoom zdoom skulltag"

# And we're off to the races...
for eng in $ENGINES; do
  if /bin/which $eng &>/dev/null; then
    exec $eng -iwad $WAD "$@"
  fi
done

echo "Can't find any of $ENGINES, can't run game." 1>&2
exit 1
