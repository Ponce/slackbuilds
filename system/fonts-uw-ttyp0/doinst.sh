#!/bin/sh

if [ -x /usr/bin/mkfontscale ]; then
  for dir in \
    /usr/share/fonts/X11/misc \
    /usr/share/fonts/misc/uw-ttyp0; do
    if [ -d "$dir" ]; then
      ( cd "$dir" || exit 1
        /usr/bin/mkfontscale .
        /usr/bin/mkfontdir .
      )
    fi
  done
fi

if [ -x /usr/bin/fc-cache ]; then
  /usr/bin/fc-cache -f
fi
