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

# Keep same perms on rc.asterisk.new:
if [ -e etc/rc.d/rc.asterisk ]; then
  cp -a etc/rc.d/rc.asterisk etc/rc.d/rc.asterisk.new.incoming
  cat etc/rc.d/rc.asterisk.new > etc/rc.d/rc.asterisk.new.incoming
  mv etc/rc.d/rc.asterisk.new.incoming etc/rc.d/rc.asterisk.new
fi

config etc/rc.d/rc.asterisk.new
config etc/logrotate.d/asterisk.new
config etc/asterisk/asterisk.conf.new
config etc/asterisk/codecs.conf.new
config etc/asterisk/extensions.conf.new
config etc/asterisk/iax.conf.new
config etc/asterisk/indications.conf.new
config etc/asterisk/modules.conf.new
config etc/asterisk/musiconhold.conf.new
config etc/asterisk/sip.conf.new
config etc/asterisk/zapata.conf.new

