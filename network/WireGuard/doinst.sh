if [ -x sbin/depmod ]; then
  chroot . /sbin/depmod -a @KERNEL@ 1> /dev/null 2> /dev/null
fi
