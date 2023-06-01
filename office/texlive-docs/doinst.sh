if [ -x /usr/bin/mktexlsr ]; then
  chroot . /usr/bin/mktexlsr 1>/dev/null 2>/dev/null
fi
