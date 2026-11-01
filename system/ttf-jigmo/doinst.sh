# Update the X font indexes:
if [ -x /usr/bin/mkfontdir ]; then
  /usr/bin/mkfontscale usr/share/fonts/TTF
  /usr/bin/mkfontdir usr/share/fonts/TTF
fi
if [ -x /usr/bin/fc-cache ]; then
  /usr/bin/fc-cache -f
fi

