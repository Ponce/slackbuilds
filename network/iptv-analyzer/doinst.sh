if [ -x sbin/depmod ]; then
  chroot . /sbin/depmod -a @@KERNEL@@ >/dev/null 2>&1
fi
