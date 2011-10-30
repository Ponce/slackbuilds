#!/bin/sh

# Wrapper script for pentagram, creates initial ~/.pentagram/pentagram.ini
# file, which pentagram won't create for itself.

set -e

if [ ! -e ~/.pentagram/pentagram.ini ]; then
	mkdir -p ~/.pentagram
	cat /usr/share/pentagram/pentagram.ini.default > ~/.pentagram/pentagram.ini
fi

exec /usr/bin/pentagram-bin "$@"
