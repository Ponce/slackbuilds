# Update the X font indexes:
if [ -x /usr/bin/mkfontdir ]; then
  ( cd usr/share/fonts/TTF
    mkfontscale .
    mkfontdir .
  )
  if [ -x /usr/bin/fc-cache ]; then
    /usr/bin/fc-cache -f
  fi
fi
