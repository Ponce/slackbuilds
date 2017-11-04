if [ -x /usr/bin/install-info ]; then
  chroot . /usr/bin/install-info --info-dir=/usr/info /usr/info/sbcl.info.gz 2> /dev/null
  chroot . /usr/bin/install-info --info-dir=/usr/info /usr/info/asdf.info.gz 2> /dev/null
fi
