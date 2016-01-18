config() {
  for infile in $1; do
    NEW="$infile"
    OLD="$(dirname $NEW)/$(basename $NEW .new)"
    # If there's no config file by that name, mv it over:
    if [ ! -r $OLD ]; then
      mv $NEW $OLD
    elif [ "$(cat $OLD | md5sum)" = "$(cat $NEW | md5sum)" ]; then
      # toss the redundant copy
      rm $NEW
    fi
    # Otherwise, we leave the .new copy for the admin to consider...
  done
}

preserve_perms() {
  NEW="$1"
  OLD="$(dirname $NEW)/$(basename $NEW .new)"
  if [ -e $OLD ]; then
    cp -a $OLD ${NEW}.incoming
    cat $NEW > ${NEW}.incoming
    mv ${NEW}.incoming $NEW
  fi
  config $NEW
}

preserve_perms etc/rc.d/rc.clamav.new
config etc/freshclam.conf.new
config etc/clamd.conf.new
[ -f etc/clamav-milter.conf.new ] && config etc/clamav-milter.conf.new
config etc/logrotate.d/clamav.new
# Remove new log if one is already present
config var/log/clamav/clamd.log.new ; rm -f var/log/clamav/clamd.log.new
config var/log/clamav/freshclam.log.new ; rm -f var/log/clamav/freshclam.log.new

