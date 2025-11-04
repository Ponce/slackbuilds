# reload udev rules
if [ -x /sbin/udevadm ]; then
  /sbin/udevadm control --reload-rules 2> /dev/null
  /sbin/udevadm trigger --action=add --subsystem-match=usb 2> /dev/null
fi

if [ -x /usr/bin/update-desktop-database ]; then
  /usr/bin/update-desktop-database -q usr/share/applications >/dev/null 2>&1
fi
