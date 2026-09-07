#!/bin/sh
APPDIR=/opt/Signal

# gconv modules are dlopened and link against libc; the host ones are built
# against 15.0 glibc and must not enter a process running the bundled 2.42.
if [ -d "$APPDIR/usr/lib64/gconv" ]; then
  GCONV_PATH="$APPDIR/usr/lib64/gconv"
  export GCONV_PATH
fi

cd "$APPDIR" || exit 1
exec ./signal-desktop "$@"

