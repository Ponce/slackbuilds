#!/bin/sh

# Update fonts.{dir,scale,alias}
if [ -x /usr/bin/mkfontdir -a -x /usr/bin/mkfontscale ]; then
  ( cd usr/share/fonts/misc
    /usr/bin/mkfontscale .
    /usr/bin/mkfontdir .
    if [ -e fonts.alias ]; then
      grep -v '^univga\>' fonts.alias > fonts.alias.new
      mv fonts.alias.new fonts.alias
    fi
  )
fi

# If X is running...
if [ "$DISPLAY" != "" ] && [ -x /usr/bin/xset ]; then
  /usr/bin/xset fp rehash >/dev/null 2>&1
fi

# Update the X font indexes:
if [ -x /usr/bin/fc-cache ]; then
  /usr/bin/fc-cache -f
fi
