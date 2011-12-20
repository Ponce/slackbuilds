#!/bin/sh
if [ ! "$XDG_CONFIG_DIRS" = "" ]; then
  XDG_CONFIG_DIRS=$XDG_CONFIG_DIRS:/etc/razorqt/xdg
else
  XDG_CONFIG_DIRS=/etc/xdg:/etc/razorqt/xdg
fi
export XDG_CONFIG_DIRS
