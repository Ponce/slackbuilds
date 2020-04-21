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

if [ -e etc/rc.d/rc.keepalived ]; then
  cp -a etc/rc.d/rc.keepalived etc/rc.d/rc.keepalived.new.incoming
  cat etc/rc.d/rc.keepalived.new > etc/rc.d/rc.keepalived.new.incoming
  mv etc/rc.d/rc.keepalived.new.incoming etc/rc.d/rc.keepalived.new
fi

config etc/default/keepalived.new
config etc/keepalived/keepalived.conf.new
config etc/rc.d/rc.keepalived.new

