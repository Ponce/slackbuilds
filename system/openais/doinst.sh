config() {
  NEW="$1"
  OLD="$(dirname $NEW)/$(basename $NEW .new)"
  if [ ! -r $OLD ]; then
    mv $NEW $OLD
  elif [ "$(cat $OLD | md5sum)" = "$(cat $NEW | md5sum)" ]; then
    rm $NEW
  fi
}

if [ -e etc/rc.d/rc.openais ]; then
  cp -a etc/rc.d/rc.openais etc/rc.d/rc.openais.new.incoming
  cat etc/rc.d/rc.openais.new > etc/rc.d/rc.openais.new.incoming
  mv etc/rc.d/rc.openais.new.incoming etc/rc.d/rc.openais.new
fi

config etc/rc.d/rc.openais.new
