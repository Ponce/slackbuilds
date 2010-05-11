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

# Keep same perms on rc.ddclient.new:
if [ -e etc/rc.d/rc.ddclient ]; then
  cp -a etc/rc.d/rc.ddclient etc/rc.d/rc.ddclient.new.incoming
  cat etc/rc.d/rc.ddclient.new > etc/rc.d/rc.ddclient.new.incoming
  mv etc/rc.d/rc.ddclient.new.incoming etc/rc.d/rc.ddclient.new
fi
config etc/rc.d/rc.ddclient.new

# Keep same perms on ddclient.conf.new:
#   Normally, we don't bother with this for config files, but this one
#   should usually be readable only by root, so that's how we'll install
#   it.  However, if the admin changes it, we don't want to undo that.
if [ -e etc/ddclient/ddclient.conf ]; then
  cp -a etc/ddclient/ddclient.conf etc/ddclient/ddclient.conf.new.incoming
  cat etc/ddclient/ddclient.conf.new > etc/ddclient/ddclient.conf.new.incoming
  mv etc/ddclient/ddclient.conf.new.incoming etc/ddclient/ddclient.conf.new
 else
  chmod 0600 etc/ddclient/ddclient.conf.new
fi
config etc/ddclient/ddclient.conf.new

