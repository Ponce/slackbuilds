#!/bin/sh
# Update the X font indexes:
if [ -x /usr/bin/mkfontdir -o -x /usr/X11R6/bin/mkfontdir ]; then
  mkfontscale usr/share/fonts/misc 2> /dev/null
  mkfontdir -e /usr/share/fonts/encodings -e /usr/share/fonts/encodings/large usr/share/fonts/misc 2> /dev/null
fi
if [ -x /usr/bin/fc-cache ]; then
  /usr/bin/fc-cache -f 2> /dev/null
fi
