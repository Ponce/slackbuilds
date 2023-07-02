if [ -x /usr/bin/fc-cache ]; then
  /usr/bin/fc-cache -f &> /dev/null
fi

if [ -x /usr/bin/mkfontdir ]; then
  ( cd usr/share/fonts/misc ; /usr/bin/mkfontdir )
fi

if [ -x /usr/bin/mkfontscale ]; then
  ( cd usr/share/fonts/misc ; /usr/bin/mkfontscale )
fi

# This may or may not work, but will do no harm:
DISPLAY=:0 /usr/bin/xset fp rehash &>/dev/null
