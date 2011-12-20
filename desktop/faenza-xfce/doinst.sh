if [ -e usr/share/icons/Faenza-Xfce/icon-theme.cache ]; then
  if [ -x /usr/bin/gtk-update-icon-cache ]; then
    /usr/bin/gtk-update-icon-cache usr/share/icons/Faenza-Xfce >/dev/null 2>&1
  fi
fi
