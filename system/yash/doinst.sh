if [ ! -r etc/shells ]; then
  touch etc/shells
  chmod 644 etc/shells
fi

if ! grep -q /bin/yash etc/shells ; then
  printf %s\\n /bin/yash >> etc/shells
fi
