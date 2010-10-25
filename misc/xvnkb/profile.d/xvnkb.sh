#!/bin/sh
# xvnkb.so need to be preloaded for xvnkb to work
if [ ! "$LD_PRELOAD" = "" ]; then
  LD_PRELOAD=$LD_PRELOAD:/usr/lib/xvnkb.so
else
  LD_PRELOAD=/usr/lib/xvnkb.so
fi
export LD_PRELOAD
