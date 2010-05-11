#!/bin/sh
if [ ! "$XDG_CONFIG_DIRS" = "" ]; then
  XDG_CONFIG_DIRS=$XDG_CONFIG_DIRS:/etc/rox/xdg
else
  XDG_CONFIG_DIRS=/etc/xdg:/etc/rox/xdg
fi
export XDG_CONFIG_DIRS
