if [ -x /sbin/depmod ]; then
  /sbin/depmod -a 1> /dev/null 2> /dev/null
fi
