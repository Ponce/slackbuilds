if [ -e etc/shells ]; then
  sed -i "/^\/bin\/osh$/d" etc/shells
  sed -i "/^\/bin\/ysh$/d" etc/shells
fi
