# Since we're creating kernel modules, this is necessary
chroot . /sbin/depmod -a @KERNEL@ 2>/dev/null

