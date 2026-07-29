if [ -x /sbin/udevadm ]; then
  /sbin/udevadm control --reload-rules
  /sbin/udevadm trigger
fi
