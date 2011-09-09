if [ -x sbin/depmod ]; then
  /sbin/depmod -a @KERNEL@ 1> /dev/null 2> /dev/null
fi

