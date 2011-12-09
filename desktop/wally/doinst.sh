if [ -e usr/share/icons/oxygen/icon-theme.cache ]; then
  if [ -x /usr/bin/gtk-update-icon-cache ]; then
    /usr/bin/gtk-update-icon-cache usr/share/icons/oxygen >/dev/null 2>&1
  fi
fi
