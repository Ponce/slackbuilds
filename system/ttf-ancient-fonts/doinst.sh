if [ -x /usr/bin/mkfontdir ]; then
  ( cd usr/share/fonts/TTF
    mkfontscale .
    mkfontdir .
  )
  ( cd usr/share/fonts/OTF
    mkfontscale .
    mkfontdir .
  )
fi
if [ -x /usr/bin/fc-cache ]; then
  /usr/bin/fc-cache -f
fi
