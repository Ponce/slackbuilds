config() {
  NEW="$1"
  OLD="$(dirname $NEW)/$(basename $NEW .new)"
  if [ ! -r $OLD ]; then
    mv $NEW $OLD
  elif [ "$(cat $OLD | md5sum)" = "$(cat $NEW | md5sum)" ]; then
    rm $NEW
  fi
}

config etc/ssmtp/revaliases.new
config etc/ssmtp/ssmtp.conf.new

# If there's no sendmail link, take over:
if [ ! -r usr/sbin/sendmail ]; then
  ( cd usr/sbin ; ln -sf ssmtp sendmail )
fi
