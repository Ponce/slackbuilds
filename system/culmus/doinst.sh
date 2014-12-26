#!/bin/sh

if [ -x /usr/bin/fc-cache ]; then
  /usr/bin/fc-cache -f
fi

# Update the X font indexes:
if [ -x /usr/bin/mkfontdir -o -x /usr/X11R6/bin/mkfontdir ]; then
  ( cd /usr/share/fonts/TTF
    mkfontscale .
    mkfontdir .
  )
  ( cd /usr/share/fonts/Type1
    mkfontscale .
    mkfontdir .
  )
fi
