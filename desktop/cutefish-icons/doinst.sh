
if [ -e usr/share/icons/Crule/icon-theme.cache ]; then
  if [ -x /usr/bin/gtk-update-icon-cache ]; then
    /usr/bin/gtk-update-icon-cache -f usr/share/icons/Crule >/dev/null 2>&1
  fi
fi

if [ -e usr/share/icons/Crule-dark/icon-theme.cache ]; then
  if [ -x /usr/bin/gtk-update-icon-cache ]; then
    /usr/bin/gtk-update-icon-cache -f usr/share/icons/Crule-dark >/dev/null 2>&1
  fi
fi

