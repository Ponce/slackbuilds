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

preserve_perms etc/rc.d/rc.bareos.new
config %sysconfdir%/bareos/bareos-dir.conf.new
config %sysconfdir%/bareos/bareos-fd.conf.new
config %sysconfdir%/bareos/bareos-sd.conf.new
config %sysconfdir%/bareos/bconsole.conf.new
config %sysconfdir%/bareos/mtx-changer.conf.new
config etc/logrotate.d/bareos.new
