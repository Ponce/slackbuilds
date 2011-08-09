#!/bin/sh

# Wrapper script for reverbed. When reverbed is run, it requires its
# config file to already be present in the user's home directory. If not,
# it'll exit, printing a message on the terminal... but if the user launched
# it via an icon from a desktop environment, he won't see the error (it will
# appear to silently fail to run). To avoid confusion, this script creates
# the config file if & only if it doesn't already exist.

if [ ! -e ~/.reverbed ]; then
	cat /usr/doc/tap_plugins-@VERSION@/dot.reverbed.default > ~/.reverbed
fi

exec /usr/bin/reverbed.bin
