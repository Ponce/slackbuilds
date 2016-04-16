if [ ! "$(grep @PREFIX@/lib@LIBDIRSUFFIX@ etc/ld.so.conf)" ]; then
  echo "@PREFIX@/lib@LIBDIRSUFFIX@" >> etc/ld.so.conf
fi
