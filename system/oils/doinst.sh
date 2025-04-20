if [ ! -r etc/shells ]; then
  touch etc/shells
  chmod 644 etc/shells
fi

if ! grep -q /bin/osh etc/shells ; then
  printf %s\\n /bin/osh >> etc/shells
fi

if ! grep -q /bin/ysh etc/shells ; then
  printf %s\\n /bin/ysh >> etc/shells
fi
