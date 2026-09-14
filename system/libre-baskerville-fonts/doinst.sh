# Update the X font indexes:
if [ -x /usr/bin/mkfontdir ]; then
  ( cd /usr/share/fonts/OTF || exit 0
    mkfontscale .
    mkfontdir .
  )
fi

if [ -x /usr/bin/mkfontdir ]; then
  ( cd /usr/share/fonts/TTF || exit 0
    mkfontscale .
    mkfontdir .
  )
fi


if [ -x /usr/bin/fc-cache ]; then
  /usr/bin/fc-cache -f
fi
