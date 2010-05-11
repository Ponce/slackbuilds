#!/bin/sh

LIGHTTPD_USER=lighttpd
LIGHTTPD_GROUP=lighttpd
LIGHTTPD_HOME=/var/www

config() {
  NEW="$1"
  OLD="`dirname $NEW`/`basename $NEW .new`"
  # If there's no config file by that name, mv it over:
  if [ ! -r $OLD ]; then
    mv $NEW $OLD
  elif [ "`cat $OLD | md5sum`" = "`cat $NEW | md5sum`" ]; then # toss the redundant copy
    rm $NEW
  fi
  # Otherwise, we leave the .new copy for the admin to consider...
}

config etc/lighttpd/lighttpd.conf.new
config etc/logrotate.d/lighttpd.new
config etc/rc.d/rc.lighttpd.new
