if [ -x /sbin/depmod ]; then
  chroot . /sbin/depmod -a >/dev/null 2>&1
fi
