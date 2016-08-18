#!/bin/bash

mkdir -p ~/.wmquake
if ! cd ~/.wmquake; then
	echo "Can't create ~/.wmquake" 2>&1
	exit 1
fi
if [ ! -e id1 ]; then
	mkdir -p id1
	ln -s /usr/share/games/quake/id1/* id1/
fi
exec /usr/libexec/wmquake/wmquake "$@"
