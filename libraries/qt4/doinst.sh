if [ -x sbin/ldconfig ]; then
  chroot . /sbin/ldconfig 2> /dev/null
fi

