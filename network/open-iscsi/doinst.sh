
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

config etc/iscsi/initiatorname.iscsi.new
config etc/iscsi/iscsid.conf.new
config etc/udev/rules.d/50-iscsi-firmware-login.rules.new
config etc/logrotate.d/iscsiuiolog.new
config etc/rc.d/rc.open-iscsi.new
