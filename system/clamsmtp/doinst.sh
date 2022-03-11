config() {
  NEW="$1"
  OLD="$(dirname $NEW)/$(basename $NEW .new)"
  if [ ! -r $OLD ]; then
    mv $NEW $OLD
  elif [ "$(cat $OLD | md5sum)" = "$(cat $NEW | md5sum)" ]; then
    rm $NEW
  fi
}

# Keep same perms on rc.clamsmtpd:
if [ -e etc/rc.d/rc.clamsmtpd ]; then
  cp -a etc/rc.d/rc.clamsmtpd etc/rc.d/rc.clamsmtpd.new.incoming
  cat etc/rc.d/rc.clamsmtpd.new > etc/rc.d/rc.clamsmtpd.new.incoming
  mv etc/rc.d/rc.clamsmtpd.new.incoming etc/rc.d/rc.clamsmtpd.new
fi

config etc/rc.d/rc.clamsmtpd.new
config etc/clamsmtpd.conf.new
