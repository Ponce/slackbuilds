#!/bin/sh

# Update fonts.{dir,scale,alias}
if [ -x /usr/bin/mkfontdir -a -x /usr/bin/mkfontscale ]; then
  ( cd usr/share/fonts/misc
    /usr/bin/mkfontscale .
    /usr/bin/mkfontdir .
    if ! grep -q '^univga\>' fonts.alias; then
      echo 'univga -bolkhov-vga-medium-r-normal--16-160-75-75-c-80-iso10646-1' >> fonts.alias
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
