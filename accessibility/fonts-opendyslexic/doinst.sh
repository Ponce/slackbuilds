if [ -x /usr/bin/mkfontdir -a -x /usr/bin/mkfontscale ]; then
  for FMT in @MKFDIRS@; do
    ( cd usr/share/fonts/$FMT
      /usr/bin/mkfontscale .
      /usr/bin/mkfontdir .
    )
  done
fi

[ -x /usr/bin/fc-cache ] && /usr/bin/fc-cache -f
