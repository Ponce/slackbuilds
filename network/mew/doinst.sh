if [ -x /usr/bin/install-info ]; then
  chroot . /usr/bin/install-info --info-dir=/usr/info/ /usr/info/mew.info.gz >/dev/null 2>&1
fi
