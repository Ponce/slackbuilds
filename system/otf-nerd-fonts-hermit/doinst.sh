# Update the X font indexes:
if [ -d usr/share/fonts/OTF ]; then
  if [ -x /usr/bin/mkfontscale ]; then
    ( cd usr/share/fonts/OTF
      /usr/bin/mkfontscale .
    )
  fi
  if [ -x /usr/bin/mkfontdir ]; then
    ( cd usr/share/fonts/OTF
      /usr/bin/mkfontdir .
    )
  fi
fi
if [ -x /usr/bin/fc-cache ]; then
  /usr/bin/fc-cache -f
fi
