if [ -e etc/shells ]; then
  sed -i "/^\/usr\/bin\/fish$/d" etc/shells
fi
