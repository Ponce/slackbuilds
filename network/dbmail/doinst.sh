config() {
  NEW="$1"
  OLD="$(dirname $NEW)/$(basename $NEW .new)"
  if [ ! -r $OLD ]; then
    mv $NEW $OLD
  elif [ "$(cat $OLD | md5sum)" = "$(cat $NEW | md5sum)" ]; then # toss the redundant copy
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

preserve_perms etc/rc.d/rc.dbmail-httpd.new
preserve_perms etc/rc.d/rc.dbmail-imapd.new
preserve_perms etc/rc.d/rc.dbmail-lmtpd.new
preserve_perms etc/rc.d/rc.dbmail-pop3d.new
preserve_perms etc/cron.daily/dbmail.new
config etc/dbmail/dbmail.conf.new
config etc/logrotate.d/dbmail.new

