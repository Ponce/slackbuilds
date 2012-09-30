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

# Keep same perms on rc.apcupsd.new:
if [ -e etc/rc.d/rc.apcupsd ]; then
  cp -a etc/rc.d/rc.apcupsd etc/rc.d/rc.apcupsd.new.incoming
  cat etc/rc.d/rc.apcupsd.new > etc/rc.d/rc.apcupsd.new.incoming
  mv etc/rc.d/rc.apcupsd.new.incoming etc/rc.d/rc.apcupsd.new
fi

config etc/rc.d/rc.apcupsd.new
config etc/apcupsd/apccontrol.new
config etc/apcupsd/apcupsd.conf.new
config etc/apcupsd/apcupsd.css.new
config etc/apcupsd/changeme.new
config etc/apcupsd/commfailure.new
config etc/apcupsd/commok.new
config etc/apcupsd/hosts.conf.new
config etc/apcupsd/multimon.conf.new
config etc/apcupsd/offbattery.new
config etc/apcupsd/onbattery.new
config etc/logrotate.d/apcupsd.new

if [ -x /usr/bin/update-desktop-database ]; then
  /usr/bin/update-desktop-database -q usr/share/applications >/dev/null 2>&1
fi
