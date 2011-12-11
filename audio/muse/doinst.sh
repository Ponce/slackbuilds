setcap cap_ipc_lock,cap_sys_nice=ep /usr/bin/muse

if grep GROUP\=\"audio\" /lib/udev/rules.d/65-permissions.rules > /dev/null; then
  echo > /dev/null
else
  sed '/^KERNEL=="rtc\|rtc0"/s!$! , GROUP="audio"!' -i /lib/udev/rules.d/65-permissions.rules
fi

if [ -x /usr/bin/update-desktop-database ]; then
  /usr/bin/update-desktop-database -q usr/share/applications >/dev/null 2>&1
fi

if [ -x /usr/bin/update-mime-database ]; then
  /usr/bin/update-mime-database usr/share/mime >/dev/null 2>&1
fi

if [ -e usr/share/icons/hicolor/icon-theme.cache ]; then
  if [ -x /usr/bin/gtk-update-icon-cache ]; then
    /usr/bin/gtk-update-icon-cache usr/share/icons/hicolor >/dev/null 2>&1
  fi
fi
