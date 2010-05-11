#!/bin/sh

config() {
  NEW="$1"
  OLD="$(dirname $NEW)/$(basename $NEW .new)"
  # If there's no config file by that name, mv it over:
  if [ ! -r $OLD ]; then
    mv $NEW $OLD
  elif [ "$(cat $OLD|md5sum)" = "$(cat $NEW|md5sum)" ]; then
    # toss the redundant copy
    rm $NEW
  fi
  # Otherwise, we leave the .new copy for the admin to consider...
}

config opt/netbeans/etc/netbeans.conf.new
config opt/netbeans/etc/netbeans.clusters.new

if [ -x /usr/bin/update-desktop-database ]; then
  /usr/bin/update-desktop-database -q usr/share/applications 2>/dev/null
fi

if [ -x /usr/bin/update-mime-database ]; then
  /usr/bin/update-mime-database usr/share/mime >/dev/null 2>&1
fi

