if [ -x /usr/bin/install-info ]; then
  chroot . /usr/bin/install-info --info-dir=/usr/info /usr/info/mpir.info.gz 2> /dev/null
  chroot . /usr/bin/install-info --info-dir=/usr/info /usr/info/mpir.info-1.gz 2> /dev/null
  chroot . /usr/bin/install-info --info-dir=/usr/info /usr/info/mpir.info-2.gz 2> /dev/null
fi
