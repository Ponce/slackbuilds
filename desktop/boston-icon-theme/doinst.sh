if [ -e usr/share/icons/Boston/icon-theme.cache ]; then
  if [ -x /usr/bin/gtk-update-icon-cache ]; then
    /usr/bin/gtk-update-icon-cache -f usr/share/icons/Boston >/dev/null 2>&1
  fi
fi
