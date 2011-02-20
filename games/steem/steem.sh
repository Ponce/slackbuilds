#!/bin/sh

# Wrapper script for steem. It's a windows app ported to linux, which
# *insists* on being able to write to the directory where the binary
# lives (even just running "steem --help" segfaults if there's no write
# permission!)
# This script makes it behave in a more unix-friendly way.

# TODO: find a better way to do this.
# Currently, the script at least handles spaces and punctuation
# in the filenames... but it's kinda ugly the way it works.
# ...especially the "echo exec ... | exec sh"

ARGS=

if [ ! -d ~/.steem ]; then
	mkdir -p ~/.steem
	ln -s /usr/share/steem/patches ~/.steem/patches
	ln -s /usr/share/steem/tos ~/.steem/tos
	ln -s /usr/libexec/steem.bin ~/.steem
	cat <<EOF > ~/.steem/steem.ini
[Machine]
ROM_File=$HOME/.steem/tos/tos102.img

[Main]
DebugBuild=0

[Update]
CurrentVersion=3.2
EOF
fi

while [ -n "$1" ]; do
	if [ -e "$1" ]; then
		ARG="$( readlink -f "$1" )"
	else
		ARG="$1"
	fi
	echo $ARG
	ARGS="$ARGS '$( echo "$ARG" | sed "s/'/'\\\\''/g" )'"
	shift
done

cd ~/.steem
echo exec ./steem.bin $ARGS | exec sh
