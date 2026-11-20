#!/bin/sh
# Launcher for ZX Basic Studio.
#
# The program finds Resources/ and libportaudio.so relative to the current
# directory, so it has to be started from its install directory. It also
# crashes when ~/.config does not exist, so make sure it does.

APPDIR=/opt/zxbasicstudio

mkdir -p "${XDG_CONFIG_HOME:-$HOME/.config}"
cd "$APPDIR" || exit 1
exec "$APPDIR/ZXBasicStudio" "$@"
