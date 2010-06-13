#!/bin/sh
# Add PATH for brlcad:
export PATH="$PATH:/opt/brlcad/bin"
# Add brlcad's pkgconfig to PKG_CONFIG_PATH 
PKG_CONFIG_PATH="/opt/brlcad/lib/pkgconfig:$PKG_CONFIG_PATH"
