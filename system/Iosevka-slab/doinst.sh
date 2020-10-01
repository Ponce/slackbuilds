# Update the X font indexes:

if [ -x /usr/bin/mkfontdir ]; then
  ( cd /usr/share/fonts/TTF
    mkfontscale .
    mkfontdir .
  )

  [ -x /usr/bin/fc-cache ] && /usr/bin/fc-cache -f
fi
