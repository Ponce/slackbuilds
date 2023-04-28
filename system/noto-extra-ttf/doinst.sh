# Update the X font indices:

if [ -x /usr/bin/mkfontdir ]; then
  ( cd usr/share/fonts/TTF
    /usr/bin/mkfontscale .
    /usr/bin/mkfontdir .
  )

  [ -x /usr/bin/fc-cache ] && /usr/bin/fc-cache -f
fi
