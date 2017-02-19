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

preserve_perms etc/rc.d/rc.kdc.new
preserve_perms etc/rc.d/rc.kadmind.new
preserve_perms etc/rc.d/rc.kpasswdd.new
preserve_perms etc/rc.d/rc.ipropd-master.new
preserve_perms etc/rc.d/rc.ipropd-slave.new
config etc/krb5.conf.new
config var/heimdal/kdc.conf.new
config var/heimdal/kadmind.acl.new
