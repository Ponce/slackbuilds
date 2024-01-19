#!/bin/sh


config() {
  NEW="$1"
  OLD="`dirname $NEW`/`basename $NEW .new`"
  # If there's no config file by that name, mv it over:
  if [ ! -r $OLD ]; then
    mv $NEW $OLD
  elif [ "`cat $OLD | md5sum`" = "`cat $NEW | md5sum`" ]; then # toss the redundant copy
    rm $NEW
  fi
  # Otherwise, we leave the .new copy for the admin to consider...
}

preserve_perms() {
  NEW="$1"
  OLD="$(dirname $NEW)/$(basename $NEW .new)"
  if [ -e $OLD ]; then
    cp -a $OLD ${NEW}.incoming
    cat $NEW > ${NEW}.incoming
    mv ${NEW}.incoming $NEW
  fi
  config $NEW
}

if [ -e /etc/rc.d/rc.nessusd ]; then
  chroot . sh /etc/rc.d/rc.nessusd status > /dev/null 2>&1
  RETVAL=$?
  if [ "$RETVAL" == "0" ]; then
    chroot . sh /etc/rc.d/rc.nessusd stop > /dev/null 2>&1
  fi
fi

preserve_perms etc/rc.d/rc.nessusd.new

echo ""
echo "Unpacking Nessus Core Components..."
chroot . /opt/nessus/sbin/nessuscli install /opt/nessus/var/nessus/plugins-core.tar.gz

echo " - You can start Nessus by typing sh /etc/rc.d/rc.nessusd start"
echo " - Then go to https://"`hostname`":8834/ to configure your scanner"
echo ""
