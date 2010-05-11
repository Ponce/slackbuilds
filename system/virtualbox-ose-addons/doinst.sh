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

# Prepare the new configuration files
for file in etc/rc.d/rc.vboxadd.new etc/rc.d/rc.vboxvfs.new etc/rc.d/rc.vboxadd-timesync.new; do
  if [ -e $(dirname $file)/$(basename $file .new) -a -x $(dirname $file)/$(basename $file .new) ]; then
    chmod 0755 $file
  else
    chmod 0644 $file
  fi
  config $file
done

