if [ -x /usr/bin/xdg-mime ]; then
    /usr/bin/xdg-mime install /usr/share/mime/packages/zoom-linux.xml
fi

if [ -x /usr/bin/update-desktop-database ]; then
  /usr/bin/update-desktop-database -q usr/share/applications >/dev/null 2>&1
fi

if [ -x /usr/bin/update-mime-database ]; then
  /usr/bin/update-mime-database usr/share/mime >/dev/null 2>&1
fi
