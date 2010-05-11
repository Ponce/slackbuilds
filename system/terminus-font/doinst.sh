#!/bin/sh
# Update mkfontscale and mkfontdir:
if [ -x /usr/bin/mkfontdir ]; then
  ( cd /usr/share/fonts/misc
    mkfontscale .
    mkfontdir .
  )
fi

# Update the X font indexes:
if [ -x /usr/bin/fc-cache ]; then
  /usr/bin/fc-cache -f
fi

# For some versions before Slackware 12.0
if [ -x /usr/X11R6/bin/mkfontdir ]; then
  ( cd /usr/X11R6/lib/X11/fonts/misc
    mkfontscale .
    mkfontdir .
  )
fi

if [ -x /usr/X11R6/bin/fc-cache ]; then
  /usr/X11R6/bin/fc-cache -f
fi
