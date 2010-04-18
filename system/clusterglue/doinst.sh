config() {
  NEW="$1"
  OLD="$(dirname $NEW)/$(basename $NEW .new)"
  if [ ! -r $OLD ]; then
    mv $NEW $OLD
  elif [ "$(cat $OLD | md5sum)" = "$(cat $NEW | md5sum)" ]; then
    rm $NEW
  fi
}

if [ -e etc/rc.d/rc.logd ]; then
  cp -a etc/rc.d/rc.logd etc/rc.d/rc.logd.new.incoming
  cat etc/rc.d/rc.logd.new > etc/rc.d/rc.logd.new.incoming
  mv etc/rc.d/rc.logd.new.incoming etc/rc.d/rc.logd.new
fi

config etc/rc.d/rc.logd.new
