#!/bin/sh

# shell script wrapper for quackle SBo build (WTFPL).
# the game doesn't appear to write to its current directory, all
# preferences get saved to ~/.config/Quackle.org/Quackle.conf
# so we don't need a private per-user directory here.

cd /usr/share/games/quackle
exec /usr/libexec/quackle/quackle "$@"
