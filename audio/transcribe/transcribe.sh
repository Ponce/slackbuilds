#!/bin/sh

# wrapper script for Transcribe! binary
# by B. Watson
# part of the slackbuilds.org project

set -e

# This lets us call the script with relative pathnames:
if [ -n "$1" ]; then
	arg="`readlink -f "$1"`"
fi

cd /usr/lib/transcribe
exec ./transcribe "$arg"
