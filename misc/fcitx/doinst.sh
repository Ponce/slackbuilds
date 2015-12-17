if [ -x /usr/bin/update-desktop-database ]; then
  /usr/bin/update-desktop-database -q usr/share/applications >/dev/null 2>&1
fi

if [ -x /usr/bin/gtk-query-immodules-2.0 ]; then
  /usr/bin/gtk-query-immodules-2.0 --update-cache
fi

if [ -x /usr/bin/gtk-query-immodules-3.0 ]; then
  /usr/bin/gtk-query-immodules-3.0 --update-cache
fi

if [ -x /usr/bin/update-mime-database ]; then
  /usr/bin/update-mime-database usr/share/mime >/dev/null 2>&1
fi

if [ -e usr/share/icons/hicolor/icon-theme.cache ]; then
  if [ -x /usr/bin/gtk-update-icon-cache ]; then
    /usr/bin/gtk-update-icon-cache usr/share/icons/hicolor >/dev/null 2>&1
  fi
fi
