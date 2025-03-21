if [ ! -h /usr/bin/gridtracker2 ]; then
  ln -s /opt/GridTracker2/gridtracker2 /usr/bin/gridtracker2
fi

if [ -x /usr/bin/update-desktop-database ]; then
  /usr/bin/update-desktop-database -q usr/share/applications >/dev/null 2>&1
fi

if [ -x /usr/bin/gtk-update-icon-cache ]; then
  /usr/bin/gtk-update-icon-cache -q usr/share/applications >/dev/null 2>&1
fi
