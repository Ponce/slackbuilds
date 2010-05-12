config() {
  NEW="$1"
  OLD="$(dirname $NEW)/$(basename $NEW .new)"
  if [ ! -r $OLD ]; then
    mv $NEW $OLD
  elif [ "$(cat $OLD | md5sum)" = "$(cat $NEW | md5sum)" ]; then
    rm $NEW
  fi
}

if [ -e etc/rc.d/rc.cherokee ]; then
  cp -a etc/rc.d/rc.cherokee etc/rc.d/rc.cherokee.new.incoming
  cat etc/rc.d/rc.cherokee.new > etc/rc.d/rc.cherokee.new.incoming
  mv etc/rc.d/rc.cherokee.new.incoming etc/rc.d/rc.cherokee.new
fi

config etc/rc.d/rc.cherokee.new
config etc/cherokee/cherokee.conf.new
