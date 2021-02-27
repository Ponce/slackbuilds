#!/bin/sh

# Wrapper script for xkegs, part of SlackBuilds.org kegs package
# By B. Watson

# xkegs is smart enough to read its conf file from ~/.config.kegs, but
# it will choke if the file's not found. Also, it's smart enough to
# read it from /usr/share/kegs/config.kegs, but it'll freeze if
# it doesn't have write permission!

# Update for v1.05: kegs will now start without ~/.config.kegs,
# but if you do that, it'll save its config in the current dir as
# "config.kegs" (no leading dot). So this wrapper's still necessary.
# Added the missing "$@" so options actually get passed to kegs.

if [ ! -e ~/.config.kegs ]; then
	cat /usr/share/kegs/config.kegs.default > ~/.config.kegs
fi

exec /usr/libexec/xkegs "$@"
