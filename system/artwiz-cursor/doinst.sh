#!/bin/sh
# Update the X font indexes:
if [ -x /usr/bin/mkfontdir ]; then
  /usr/bin/mkfontscale /usr/share/fonts/misc
  /usr/bin/mkfontdir /usr/share/fonts/misc
fi
if [ -x /usr/bin/fc-cache ]; then
  /usr/bin/fc-cache -f
fi
