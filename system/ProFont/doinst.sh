if [ -x /usr/bin/mkfontdir -o -x /usr/X11R6/bin/mkfontdir ]; then
  ( cd /usr/share/fonts/misc
    mkfontdir .
  )
fi
if [ -x /usr/bin/fc-cache ]; then
  /usr/bin/fc-cache -f
fi
