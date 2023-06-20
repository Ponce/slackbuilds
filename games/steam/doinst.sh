# Update the desktop database:
if [ -x usr/bin/update-desktop-database ]; then
  /usr/bin/update-desktop-database usr/share/applications > /dev/null 2>&1
fi

# Update hicolor theme cache:
if [ -e usr/share/icons/hicolor/icon-theme.cache ]; then
  if [ -x /usr/bin/gtk-update-icon-cache ]; then
    /usr/bin/gtk-update-icon-cache -f usr/share/icons/hicolor >/dev/null 2>&1
  fi
fi

# Update the mime database:
if [ -x usr/bin/update-mime-database ]; then
  /usr/bin/update-mime-database usr/share/mime >/dev/null 2>&1
fi

# Reload the udev rules to include our newly installed steam rules
if [ -x /sbin/udevadm ]; then
  /sbin/udevadm control --reload
fi
