if [ -x /usr/bin/mkfontdir ]; then
  ( cd usr/share/fonts/misc
    if ! grep -q ^gohu fonts.alias 2>/dev/null; then
      echo 'gohu11 -gohu-gohufont-medium-r-normal--11-80-100-100-c-60-iso10646-1' >> fonts.alias
      echo 'gohu11bold -gohu-gohufont-bold-r-normal--11-80-100-100-c-60-iso10646-1' >> fonts.alias
      echo 'gohu14 -gohu-gohufont-medium-r-normal--14-100-100-100-c-80-iso10646-1' >> fonts.alias
      echo 'gohu14bold -gohu-gohufont-bold-r-normal--14-100-100-100-c-80-iso10646-1' >> fonts.alias
    fi
    mkfontscale .
    mkfontdir .
  )
fi
if [ -x usr/bin/fc-cache ]; then
  usr/bin/fc-cache -f
fi
