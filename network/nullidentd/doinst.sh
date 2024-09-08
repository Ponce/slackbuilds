if [ -x usr/bin/mandb ]; then
  chroot . /usr/bin/mandb -f /usr/man/man8/nullidentd.8.gz &> /dev/null
fi
