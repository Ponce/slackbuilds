## This was causing problems compiling KDE for unknown reasons.
## So, we'll symlink the libraries into /opt/kde3 again...
# Add QT library directory to /etc/ld.so.conf:
if ! grep /opt/kde3/lib etc/ld.so.conf 1> /dev/null 2> /dev/null ; then
  echo "/opt/kde3/lib" >> etc/ld.so.conf
fi
if [ -x /sbin/ldconfig ]; then
  /sbin/ldconfig 2> /dev/null
fi
