if [ -x /usr/bin/mkfontdir -a -x /usr/bin/mkfontscale ]; then
  ( cd usr/share/fonts/TTF
    /usr/bin/mkfontscale .
    /usr/bin/mkfontdir .
  )
fi

[ -x /usr/bin/fc-cache ] && /usr/bin/fc-cache -f
