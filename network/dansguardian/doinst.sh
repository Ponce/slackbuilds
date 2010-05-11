config() {
  NEW="$1"
  OLD="$(dirname $NEW)/$(basename $NEW .new)"
  if [ ! -r $OLD ]; then
    mv $NEW $OLD
  elif [ "$(cat $OLD | md5sum)" = "$(cat $NEW | md5sum)" ]; then
    rm $NEW
  fi
}

# Keep same perms on rc.dansguardian.new:
if [ -e etc/rc.d/rc.dansguardian ]; then
  cp -a etc/rc.d/rc.dansguardian etc/rc.d/rc.dansguardian.new.incoming
  cat etc/rc.d/rc.dansguardian.new > etc/rc.d/rc.dansguardian.new.incoming
  mv etc/rc.d/rc.dansguardian.new.incoming etc/rc.d/rc.dansguardian.new
fi

