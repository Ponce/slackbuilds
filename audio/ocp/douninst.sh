if [ -x /usr/bin/install-info ]; then
  chroot . /usr/bin/install-info --remove --info-dir=/usr/info /usr/info/ocp.info.gz 2> /dev/null
fi
