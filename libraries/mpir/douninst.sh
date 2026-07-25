if [ -x /usr/bin/install-info ]; then
  /usr/bin/install-info --remove --info-dir=usr/info usr/info/mpir.info.gz 2> /dev/null
  /usr/bin/install-info --remove --info-dir=usr/info usr/info/mpir.info-1.gz 2> /dev/null
  /usr/bin/install-info --remove --info-dir=usr/info usr/info/mpir.info-2.gz 2> /dev/null
fi
