config() {
  NEW="$1"
  OLD="$(dirname $NEW)/$(basename $NEW .new)"
  # If there's no config file by that name, mv it over:
  if [ ! -r $OLD ]; then
    mv $NEW $OLD
  elif [ "$(cat $OLD | md5sum)" = "$(cat $NEW | md5sum)" ]; then
    # toss the redundant copy
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

preserve_perms etc/rc.d/rc.frr.new
config etc/logrotate.d/frr.new
config etc/frr/daemons.new
config etc/frr/vtysh.conf.new

if [ -x /usr/bin/install-info ]; then
  chroot . /usr/bin/install-info --info-dir=/usr/info /usr/info/frr-info.gz 2> /dev/null
  chroot . /usr/bin/install-info --info-dir=/usr/info /usr/info/frr-info-1.gz 2> /dev/null
  chroot . /usr/bin/install-info --info-dir=/usr/info /usr/info/frr-info-2.gz 2> /dev/null
fi
