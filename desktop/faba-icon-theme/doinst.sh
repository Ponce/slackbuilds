if [ -e usr/share/icons/Faba/icon-theme.cache ]; then
  if [ -x /usr/bin/gtk-update-icon-cache ]; then
    /usr/bin/gtk-update-icon-cache -f usr/share/icons/Faba >/dev/null 2>&1
  fi
fi
