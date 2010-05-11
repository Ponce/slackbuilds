#!/bin/sh
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

# Keep same perms on rc.iscsi-target.new:
if [ -e etc/rc.d/rc.iscsi-target ]; then
  cp -a etc/rc.d/rc.iscsi-target etc/rc.d/rc.iscsi-target.new.incoming
  cat etc/rc.d/rc.iscsi-target.new > etc/rc.d/rc.iscsi-target.new.incoming
  mv etc/rc.d/rc.iscsi-target.new.incoming etc/rc.d/rc.iscsi-target.new
else
  # Install executable otherwise - irrelevant unless user starts in rc.local
  chmod 0755 etc/rc.d/rc.iscsi-target.new
fi

config etc/rc.d/rc.iscsi-target.new

if [ -x /sbin/depmod ]; then
echo -e "Updating modules..."
depmod -a
fi
