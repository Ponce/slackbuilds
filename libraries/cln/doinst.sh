if [ -x /usr/bin/install-info ] ; then
  chroot . /usr/bin/install-info --info-dir=/usr/info /usr/info/cln.info.gz 2>/dev/null
fi

