if [ -x /usr/bin/update-desktop-database ]; then
  /usr/bin/update-desktop-database -q usr/share/applications >/dev/null 2>&1
fi

if [ -x /usr/bin/update-mime-database ]; then
  /usr/bin/update-mime-database usr/share/mime >/dev/null 2>&1
fi

if [ -e usr/share/icons/hicolor/icon-theme.cache ]; then
  if [ -x /usr/bin/gtk-update-icon-cache ]; then
    /usr/bin/gtk-update-icon-cache -f usr/share/icons/hicolor >/dev/null 2>&1
  fi
fi

if [ -x /usr/bin/mktexlsr ]; then
  chroot . /usr/bin/mktexlsr >/dev/null 2>&1
else
  if [ -x /usr/share/texmf/bin/mktexlsr ]; then
    chroot . /usr/share/texmf/bin/mktexlsr >/dev/null 2>&1
  fi
fi
