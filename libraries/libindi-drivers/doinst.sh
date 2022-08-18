if [ -x /sbin/udevadm ]; then
  /sbin/udevadm control --reload-rules >/dev/null 2>&1 && /sbin/udevadm trigger >/dev/null 2>&1
fi
