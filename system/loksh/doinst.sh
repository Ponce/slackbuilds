if [ ! -r etc/shells ]; then
  touch etc/shells
  chmod 644 etc/shells
fi

if ! grep -q /bin/loksh etc/shells ; then
  printf %s\\n /bin/loksh >> etc/shells
fi
