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

config etc/monitorix/monitorix.conf.new
config etc/rc.d/rc.monitorix.new
config etc/logrotate.d/monitorix.new
config etc/httpd/extra/httpd-monitorix.conf.new
