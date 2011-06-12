if [ -x /usr/bin/gtk-update-icon-cache ]; then
  /usr/bin/gtk-update-icon-cache -f -t usr/share/icons/hicolor >/dev/null 2>&1
fi

if [ -x /usr/bin/update-desktop-database ]; then
  /usr/bin/update-desktop-database usr/share/applications >/dev/null 2>&1
fi
