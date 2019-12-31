if [ ! -r etc/shells ]; then
  touch etc/shells
  chmod 644 etc/shells
fi

if ! grep -q /bin/oksh etc/shells ; then
  printf %s\\n /bin/oksh >> etc/shells
fi
