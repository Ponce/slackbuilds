#!/bin/sh
# Update the X font indexes:
if [ -x usr/X11R6/bin/fc-cache ]; then
  usr/X11R6/bin/fc-cache -f
fi

