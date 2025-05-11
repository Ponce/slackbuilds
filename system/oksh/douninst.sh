if [ -e etc/shells ]; then
  sed -i "/^\/bin\/oksh$/d" etc/shells
fi
