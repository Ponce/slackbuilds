chroot . /sbin/depmod -a @KERNEL@

if [ -x /sbin/udevadm ]; then
  /sbin/udevadm control --reload
fi
