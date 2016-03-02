#!/bin/csh
# Add path for brlcad:
setenv PATH ${PATH}:/opt/brlcad/bin
# Add brlcad's pkgconfig to PKG_CONFIG_PATH
setenv PKG_CONFIG_PATH /opt/brlcad/lib/pkgconfig:${PKG_CONFIG_PATH}
