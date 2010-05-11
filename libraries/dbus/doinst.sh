#!/bin/bash

config() {
  NEW="$1"
  OLD="`dirname $NEW`/`basename $NEW .new`"
  # If there's no config file by that name, mv it over:
  if [ ! -r $OLD ]; then
    mv $NEW $OLD
  elif [ "`cat $OLD | md5sum`" = "`cat $NEW | md5sum`" ]; then
    # toss the redundant copy
    rm $NEW
  fi
  # Otherwise, we leave the .new copy for the admin to consider...
}

# Keep same perms on rc.messagebus.new:
if [ -e etc/rc.d/rc.messagebus ]; then
  cp -a etc/rc.d/rc.messagebus etc/rc.d/rc.messagebus.new.incoming
  cat etc/rc.d/rc.messagebus.new > etc/rc.d/rc.messagebus.new.incoming
  mv etc/rc.d/rc.messagebus.new.incoming etc/rc.d/rc.messagebus.new
fi

config etc/dbus-1/session.conf.new
config etc/dbus-1/system.conf.new
config etc/rc.d/rc.messagebus.new

if grep -q messagebus etc/passwd ; then
  chown -R messagebus var/lib/dbus
else
  echo Error: the \'messagebus\' user does not exist.
  echo You need to create the \'messagebus\' user then do
  echo "  chown -R messagebus /var/lib/dbus "
  echo
  echo Press Enter to continue
  read _JUNK
fi

