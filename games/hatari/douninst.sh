if [ -x /usr/bin/update-mime-database ]; then
  /usr/bin/update-mime-database usr/share/mime >/dev/null 2>&1
fi

if [ -x /usr/bin/update-desktop-database ]; then
  /usr/bin/update-desktop-database -q usr/share/applications >/dev/null 2>&1
fi

if [ -e usr/share/icons/hicolor/icon-theme.cache ]; then
  if [ -x /usr/bin/gtk-update-icon-cache ]; then
    /usr/bin/gtk-update-icon-cache -f usr/share/icons/hicolor >/dev/null 2>&1
  fi
fi

# if the symlink is no longer valid, get rid of it. the user may have
# changed it, so it's possible that he wants to keep it. if the dir
# is empty, it gets removed, too (removepkg doesn't do it for us).
[ -f usr/share/hatari/tos.img ] || rm -f usr/share/hatari/tos.img
rmdir usr/share/hatari 2>/dev/null
