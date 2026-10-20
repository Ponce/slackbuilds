rm -f usr/bin/makepasswd usr/man/man1/makepasswd.1.gz
if [ -e usr/bin/makepasswd-khorben ]; then
  ln -sf makepasswd-khorben usr/bin/makepasswd
  ln -sf makepasswd-khorben.1.gz usr/man/man1/makepasswd.1.gz
fi
