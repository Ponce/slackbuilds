# Update the fonts indexes.

if [ -x /usr/bin/mkfontdir ]; then
   cd /usr/share/fonts/TTF
   mkfontdir .
fi

if [ -x /usr/bin/mkfontscale ]; then
   cd /usr/share/fonts/TTF
   mkfontscale .
fi

if [ -x /usr/bin/fc-cache ]; then
   fc-cache -f -v
fi
