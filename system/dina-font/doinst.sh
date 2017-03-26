if [ -x /usr/bin/mkfontdir ]; then
  ( cd usr/share/fonts/misc
    if ! grep -q ^Dina_ fonts.alias 2>/dev/null; then
      echo 'Dina_6 -windows-dina-medium-r-normal--8-60-96-96-c-60-microsoft-cp1252' >> fonts.alias
      echo 'Dina_8 -windows-dina-medium-r-normal--10-80-96-96-c-70-microsoft-cp1252' >> fonts.alias
      echo 'Dina_9 -windows-dina-medium-r-normal--12-90-96-96-c-70-microsoft-cp1252' >> fonts.alias
      echo 'Dina_10 -windows-dina-medium-r-normal--13-100-96-96-c-80-microsoft-cp1252' >> fonts.alias
    fi
    mkfontscale .
    mkfontdir .
  )
fi
if [ -x usr/bin/fc-cache ]; then
  usr/bin/fc-cache -f
fi
