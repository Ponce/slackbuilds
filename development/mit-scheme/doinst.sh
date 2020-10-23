info_install() {
  INFO="$1"
  if [ -x /usr/bin/install-info ]; then
    chroot . /usr/bin/install-info --info-dir=/usr/info $INFO 2> /dev/null
  fi
}

