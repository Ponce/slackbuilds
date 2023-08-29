if [ -x /usr/bin/install-info ]; then
  /usr/bin/install-info --info-dir=usr/info usr/info/mu4e.info.gz
  /usr/bin/install-info --info-dir=usr/info usr/info/mu-guile.info.gz
fi
