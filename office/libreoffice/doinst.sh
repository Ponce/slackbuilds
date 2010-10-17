if [ -x /usr/bin/update-desktop-database ]; then
  /usr/bin/update-desktop-database -q usr/share/applications
fi

if [ -x /usr/bin/update-mime-database ]; then
  /usr/bin/update-mime-database usr/share/mime >/dev/null 2>&1
fi

if [ -x /usr/bin/gtk-update-icon-cache ]; then 
  for theme in gnome locolor hicolor ; do
    if [ -e usr/share/icons/$theme/icon-theme.cache ]; then 
      /usr/bin/gtk-update-icon-cache usr/share/icons/$theme >/dev/null 2>&1
    fi
  done
fi

