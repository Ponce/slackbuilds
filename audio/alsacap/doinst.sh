if [ -x usr/bin/mandb ]; then
  chroot . /usr/bin/mandb -f /usr/man/man1/alsacap.1.gz &> /dev/null
fi
