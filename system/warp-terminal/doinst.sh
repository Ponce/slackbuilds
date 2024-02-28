if [ -x /usr/bin/update-desktop-database ]; then
  /usr/bin/update-desktop-database -q usr/share/applications >/dev/null 2>&1
fi

if [ -e usr/share/icons/hicolor/icon-theme.cache ]; then
  if [ -x /usr/bin/gtk-update-icon-cache ]; then
    /usr/bin/gtk-update-icon-cache -f usr/share/icons/hicolor >/dev/null 2>&1
  fi
fi

DEST="/bin/warp-terminal"

if [ ! -L ${DEST} -a ! -e ${DEST} ]; then
  /usr/bin/ln -s /opt/warpdotdev/warp-terminal/warp ${DEST}
fi
