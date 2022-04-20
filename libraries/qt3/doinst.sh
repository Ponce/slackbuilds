# Add QT library directory to /etc/ld.so.conf:
if [ -e etc/ld.so.conf ]; then
  if ! grep /opt/kde3/lib etc/ld.so.conf 1> /dev/null 2> /dev/null ; then
    echo "/opt/kde3/lib" >> etc/ld.so.conf
  fi
fi
