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

# Keep same perms on rc.nagios.new:
if [ -e etc/rc.d/rc.nagios ]; then
  cp -a etc/rc.d/rc.nagios etc/rc.d/rc.nagios.new.incoming
  cat etc/rc.d/rc.nagios.new > etc/rc.d/rc.nagios.new.incoming
  mv etc/rc.d/rc.nagios.new.incoming etc/rc.d/rc.nagios.new
fi

find etc/nagios/ -name *.cfg.new | while read cfg ; do config $cfg ; done
config etc/httpd/extra/nagios.conf.new
config etc/rc.d/rc.nagios.new

