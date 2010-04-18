config() {
  NEW="$1"
  OLD="$(dirname $NEW)/$(basename $NEW .new)"
  if [ ! -r $OLD ]; then
    mv $NEW $OLD
  elif [ "$(cat $OLD | md5sum)" = "$(cat $NEW | md5sum)" ]; then
    rm $NEW
  fi
}

if [ -e etc/rc.d/rc.corosync ]; then
  cp -a etc/rc.d/rc.corosync etc/rc.d/rc.corosync.new.incoming
  cat etc/rc.d/rc.corosync.new > etc/rc.d/rc.corosync.new.incoming
  mv etc/rc.d/rc.corosync.new.incoming etc/rc.d/rc.corosync.new
fi

config etc/rc.d/rc.corosync.new
