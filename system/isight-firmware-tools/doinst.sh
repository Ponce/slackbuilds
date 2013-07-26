if [ -x usr/bin/install-info ]; then
  chroot . /usr/bin/install-info --info-dir=/usr/info /usr/info/ift-export.info.gz 2> /dev/null
  chroot . /usr/bin/install-info --info-dir=/usr/info /usr/info/ift-extract.info.gz 2> /dev/null
fi

