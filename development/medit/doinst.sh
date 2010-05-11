if [ -x usr/bin/update-desktop-database ]; then
  usr/bin/update-desktop-database > /dev/null 2>&1
fi

if [ -x usr/bin/update-mime-database ]; then
  usr/bin/update-mime-database usr/share/mime >/dev/null 2>&1
fi

if [ -x usr/bin/gtk-update-icon-cache ]; then
  gtk-update-icon-cache -f -t usr/share/icons/hicolor > /dev/null 2>&1
fi

