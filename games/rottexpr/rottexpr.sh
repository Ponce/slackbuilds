#!/bin/sh

# Wrapper script for Rise of the Triad, by B. Watson
# Modified for rottexpr by Brent Spillner

# Figures out which rott binary to execute, based on which
# game data files are installed.

DATADIR=/usr/share/games/rottexpr
CDROMFILE=$DATADIR/ROTTCD.RTC
REGFILE=$DATADIR/DARKWAR.WAD
DEMOFILE=$DATADIR/HUNTBGIN.WAD
BINDIR=/usr/games

if [ -r $CDROMFILE ]; then
	exec $BINDIR/rottexpr-cdrom "$@"
elif [ -r $REGFILE ]; then
	exec $BINDIR/rottexpr-reg "$@"
elif [ -r $DEMOFILE ]; then
	exec $BINDIR/rottexpr-demo "$@"
else
	cat 1>&2 <<EOF
$0: Can't find any usable game data files.

Copy the game data files from either the shareware or full version
of ROTT to /usr/share/games/rottexpr, and if necessary, rename the files
to ALL UPPERCASE names (e.g. DARKWAR.WAD).
EOF
	exit 1
fi
