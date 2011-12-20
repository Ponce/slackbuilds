# Add kerberos libs to the library search path
if ! grep -q '^/usr/kerberos/lib$' etc/ld.so.conf ; then
  echo "/usr/kerberos/lib" >> etc/ld.so.conf
fi
