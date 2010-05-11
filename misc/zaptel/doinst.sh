#!/bin/sh

config() {
  NEW="$1"
  OLD="$(dirname $NEW)/$(basename $NEW .new)"
  # If there's no config file by that name, mv it over:
  if [ ! -r $OLD ]; then
    mv $NEW $OLD
  elif [ "$(cat $OLD | md5sum)" = "$(cat $NEW | md5sum)" ]; then # toss the redundant copy
    rm $NEW
  fi
  # Otherwise, we leave the .new copy for the admin to consider...
}

# Keep same perms on rc.zaptel.new:
if [ -e etc/rc.d/rc.zaptel ]; then
  cp -a etc/rc.d/rc.zaptel etc/rc.d/rc.zaptel.new.incoming
  cat etc/rc.d/rc.zaptel.new > etc/rc.d/rc.zaptel.new.incoming
  mv etc/rc.d/rc.zaptel.new.incoming etc/rc.d/rc.zaptel.new
fi

config etc/rc.d/rc.zaptel.new
config etc/zaptel.conf.new

# Since we're creating kernel modules, this is necessary
chroot . depmod -a 2>/dev/null

