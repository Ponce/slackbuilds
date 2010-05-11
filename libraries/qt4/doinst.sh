if ! grep -q /usr/lib/qt4/lib etc/ld.so.conf ; then
    echo "/usr/lib/qt4/lib" >> etc/ld.so.conf
fi

chroot . /sbin/ldconfig 2> /dev/null
