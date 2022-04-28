#!/bin/sh

# 20220428 bkw: wrapper script for worldofpadman SBo build. needed
# because wop and wopded expect to be called with full path (so they
# can find their data files), but we want to be able to run them from
# $PATH.

# Licensed under the WTFPL. See http://www.wtfpl.net/txt/copying/ for details.

exec /opt/worldofpadman/@EXE@.@ARCH@ "$@"
