if [ -x /usr/bin/update-desktop-database ]; then
  /usr/bin/update-desktop-database usr/share/applications >/dev/null 2>&1
fi

