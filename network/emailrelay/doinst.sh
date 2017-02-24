#!/bin/sh

spool="var/spool/emailrelay"
submit="usr/sbin/emailrelay-submit"

config() {
  NEW="$1"
  OLD="$(dirname $NEW)/$(basename $NEW .new)"
  if [ ! -r $OLD ]; then
    mv $NEW $OLD
  elif [ "$(cat $OLD | md5sum)" = "$(cat $NEW | md5sum)" ]; then
    rm $NEW
  fi
}

fix_permissions

config etc/rc.d/rc.emailrelay.new
config etc/emailrelay.conf.new
