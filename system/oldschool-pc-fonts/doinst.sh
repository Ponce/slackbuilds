# Update the X font indexes:
if [ -x /usr/bin/mkfontdir  -a -x /usr/bin/mkfontscale ]; then
  ( cd usr/share/fonts/TTF
    /usr/bin/mkfontscale .
    /usr/bin/mkfontdir .
  )
  ( cd usr/share/fonts/misc
    /usr/bin/mkfontscale .
    /usr/bin/mkfontdir .
  )
fi

[ "$DISPLAY" != "" ] && xset fp rehash 2>/dev/null

if [ -x /usr/bin/fc-cache ]; then
  /usr/bin/fc-cache -f
fi
