#!/bin/sh
if [ ! "$XDG_CONFIG_DIRS" = "" ]; then
  XDG_CONFIG_DIRS=$XDG_CONFIG_DIRS:@RCONFDIR@
else
  XDG_CONFIG_DIRS=/etc/xdg:@RCONFDIR@
fi
export XDG_CONFIG_DIRS
