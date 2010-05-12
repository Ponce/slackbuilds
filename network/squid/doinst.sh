config() {
  NEW="$1"
  OLD="$(dirname $NEW)/$(basename $NEW .new)"
  # If there's no config file by that name, mv it over:
  if [ ! -r $OLD ]; then
    mv $NEW $OLD
  elif [ "$(cat $OLD | md5sum)" = "$(cat $NEW | md5sum)" ]; then
    rm $NEW # toss the redundant copy
  fi
  # Otherwise, we leave the .new copy for the admin to consider...
}

# Keep same perms on rc.squid.new:
if [ -e etc/rc.d/rc.squid ]; then
  cp -a etc/rc.d/rc.squid etc/rc.d/rc.squid.new.incoming
  cat etc/rc.d/rc.squid.new > etc/rc.d/rc.squid.new.incoming
  mv etc/rc.d/rc.squid.new.incoming etc/rc.d/rc.squid.new
else
  # Install executable otherwise - irrelevant unless user starts in rc.local
  chmod 0755 etc/rc.d/rc.squid.new
fi

config etc/rc.d/rc.squid.new
config etc/squid/mime.conf.new
config etc/squid/squid.conf.new
config etc/squid/cachemgr.conf.new
config etc/logrotate.d/squid.new

