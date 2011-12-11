config() {
  NEW="$1"
  OLD="$(dirname $NEW)/$(basename $NEW .new)"
  if [ ! -r $OLD ]; then
    mv $NEW $OLD
  elif [ "$(cat $OLD | md5sum)" = "$(cat $NEW | md5sum)" ]; then
    rm $NEW
  fi
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

preserve_perms etc/rc.d/rc.rsyslogd.new
config etc/rsyslog.conf.new
config etc/logrotate.d/rsyslog.new
config var/log/messages.new ; rm -f var/log/messages.new
config var/log/syslog.new ; rm -f var/log/syslog.new
config var/log/debug.new ; rm -f var/log/debug.new
config var/log/secure.new ; rm -f var/log/secure.new
config var/log/cron.new ; rm -f var/log/cron.new
config var/log/maillog.new ; rm -f var/log/maillog.new
config var/log/spooler.new ; rm -f var/log/spooler.new

