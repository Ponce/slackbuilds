#!/bin/bash

# Wrapper script for chexquest, part of the SlackBuilds.org project.
# Decides which game to run, finds a usable Doom engine, and uses it
# to run the game.

# Author: B. Watson (urchlay@slackware.uk). License: WTFPL.

# The IWAD for Chex Quest 1... its header calls it a PWAD but it's
# really an IWAD. *shrug*
IWAD=/usr/share/games/doom/chex.wad

# The PWAD for Chex Quest 2 (which requires chex.wad):
PWAD=/usr/share/games/doom/chex2.wad

# If we're called as chexquest2, add the PWAD.
case "$0" in
  *2) PWADARG="-file $PWAD" ;;
esac

# The list is restricted to engines that (a) are on SBo, and (b) can
# actually play Chex Quest 1 and 2.

# These were tested, and don't work: chocolate-doom doomsday prboom

# Chocolate Doom supposedly supports it, if the Dehacked patch is
# present, but it segfaults when I try to start the game. If you
# want to play with this, the dehacked patch lives here:
# http://mirrors.syringanetworks.net/idgames/themes/chex/chexdeh.zip

# These were tested, and do work... though skulltag has issues, and
# only gzdoom, zdoom, and crispy-doom show the correct "are you sure
# you want to quit?" messages.
ENGINES="gzdoom zdoom crispy-doom odamex prboom-plus doomretro skulltag"

# And we're off to the races...
for eng in $ENGINES; do
  if /bin/which $eng &>/dev/null; then
    exec $eng -iwad $IWAD $PWADARG "$@"
  fi
done

echo "Can't find any of $ENGINES, can't run game." 1>&2
exit 1
