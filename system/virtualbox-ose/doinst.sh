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

if [ -x /usr/bin/update-desktop-database ]; then
  /usr/bin/update-desktop-database usr/share/applications >/dev/null 2>&1
fi

# Prepare the new configuration files
config etc/vbox/vbox.cfg.new
for file in etc/rc.d/rc.vboxdrv.new etc/rc.d/rc.vboxnet.new ; do
  if [ -e $(dirname $file)/$(basename $file .new) -a -x $(dirname $file)/$(basename $file .new) ]; then
    chmod 0755 $file
  else
    chmod 0644 $file
  fi
  config $file
done

