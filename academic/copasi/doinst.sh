if [ -x /usr/bin/update-desktop-database ]; then
  /usr/bin/update-desktop-database -q usr/share/applications
fi

if [ -x /usr/bin/xdg-mime ]; then
  /usr/bin/xdg-mime install usr/share/copasi/COPASI-mime.xml
fi

