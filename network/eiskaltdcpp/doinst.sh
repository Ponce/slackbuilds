if [ -x /usr/bin/update-desktop-database ]; then
  /usr/bin/update-desktop-database &> /dev/null
fi

if [ -x /usr/bin/gtk-update-icon-cache ]; then
  /usr/bin/gtk-update-icon-cache  -f -q /usr/share/icons/hicolor &> /dev/null
fi

