if [ -x usr/bin/update-desktop-database ]; then
  ./usr/bin/update-desktop-database ./opt/kde/share/applications >/dev/null 2>&1
fi
