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

# Keep same perms on rc.miniupnpd.new:
if [ -e etc/rc.d/rc.miniupnpd ]; then
  cp -a etc/rc.d/rc.miniupnpd etc/rc.d/rc.miniupnpd.new.incoming
  cat etc/rc.d/rc.miniupnpd.new > etc/rc.d/rc.miniupnpd.new.incoming
  mv etc/rc.d/rc.miniupnpd.new.incoming etc/rc.d/rc.miniupnpd.new
fi

config etc/rc.d/rc.miniupnpd.new
config etc/miniupnpd/miniupnpd.conf.new
config etc/miniupnpd/iptables_init.sh.new
config etc/miniupnpd/iptables_removeall.sh.new

