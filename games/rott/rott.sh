#!/bin/sh

# Wrapper script for Rise of the Triad, by B. Watson

# Figures out which rott binary to execute, based on which
# game data files are installed.

DATADIR=/usr/share/games/rott
CDROMFILE=$DATADIR/ROTTCD.RTC
REGFILE=$DATADIR/DARKWAR.WAD
DEMOFILE=$DATADIR/HUNTBGIN.WAD
BINDIR=/usr/games

if [ -r $CDROMFILE ]; then
	exec $BINDIR/rott-cdrom "$@"
elif [ -r $REGFILE ]; then
	exec $BINDIR/rott-reg "$@"
elif [ -r $DEMOFILE ]; then
	exec $BINDIR/rott-demo "$@"
else
	cat 1>&2 <<EOF
$0: Can't find any usable game data files.

Copy the game data files from either the shareware or full version
of ROTT to /usr/share/games/rott, and if necessary, rename the files
to ALL UPPERCASE names (e.g. DARKWAR.WAD).
EOF
	exit 1
fi
