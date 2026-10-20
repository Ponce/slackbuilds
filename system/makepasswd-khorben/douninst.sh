rm -f usr/bin/makepasswd usr/man/man1/makepasswd.1.gz
if [ -e usr/bin/makepasswd-debian ]; then
  ln -sf makepasswd-debian usr/bin/makepasswd
  ln -sf makepasswd-debian.1.gz usr/man/man1/makepasswd.1.gz
fi
