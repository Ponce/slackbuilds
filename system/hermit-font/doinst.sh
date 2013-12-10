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

