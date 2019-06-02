# Update the desktop database:
if [ -x usr/bin/update-desktop-database ]; then
  /usr/bin/update-desktop-database usr/share/applications > /dev/null 2>&1
fi

# Update hicolor theme cache:
if [ -d usr/share/icons/hicolor ]; then
  if [ -x /usr/bin/gtk-update-icon-cache ]; then
    /usr/bin/gtk-update-icon-cache -f -t usr/share/icons/hicolor 1> /dev/null 2> /dev/null
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
