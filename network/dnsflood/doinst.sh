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

# Keep same perms on rc.dnsflood:
if [ -e etc/rc.d/rc.dnsflood ]; then
  cp -a etc/rc.d/rc.dnsflood etc/rc.d/rc.dnsflood.new.incoming
  cat etc/rc.d/rc.dnsflood.new > etc/rc.d/rc.dnsflood.new.incoming
  mv etc/rc.d/rc.dnsflood.new.incoming etc/rc.d/rc.dnsflood.new
fi

config etc/rc.d/rc.dnsflood.new

