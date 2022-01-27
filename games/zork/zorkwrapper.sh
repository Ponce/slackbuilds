#!/bin/bash

# shell script wrapper for zork games. Finds an interpreter based
# on what's installed, finds the zcode file based on $0.

# This script is only meant to work with the files installed by
# zork.SlackBuild, so it's dumber than a general-purpose script
# would be. In particular, it chokes on filenames with spaces
# in them (but there aren't any installed by the SlackBuild)

ZCODEPATH=/usr/share/zcode

# This ugly construct is needed in case zork1.z3 and zork1.z5 both
# exist (we only want the .z? glob to return one filename)
ZFILE=$( echo "$ZCODEPATH/$( echo "$0" | sed 's,.*/,,' )".z? | cut -d' ' -f1 )

# If the wrapper is called directly, default to Zork I
if [ ! -e $ZFILE ]; then
	ZFILE=$ZCODEPATH/zork1.z3
fi

if which fizmo &>/dev/null; then
	exec fizmo $ZFILE
elif which frotz &>/dev/null; then
	exec frotz $ZFILE
elif which zoom &>/dev/null; then
	if [ "$DISPLAY" = "" ]; then
		echo "$0: can't run zoom, X isn't running. Install fizmo or frotz, or else startx first"
		exit 1
	fi

	# zoom is an X app, if we were called from a .desktop file,
	# need to get rid of the terminal it started for us.
	nohup zoom $ZFILE &>/dev/null &
	sleep 1
	disown
else
	echo "$0: can't find an interpreter. Install one or more of fizmo, frotz, zoom."
	exit 1
fi
