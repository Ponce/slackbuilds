# doinst.sh for clockchimes

config() {
  NEW="$1"
  OLD="$(dirname $NEW)/$(basename $NEW .new)"
  # If there's no config file by that name, mv it over:
  if [ ! -r $OLD ]; then
    mv $NEW $OLD
  elif [ "$(cat $OLD | md5sum)" = "$(cat $NEW | md5sum)" ]; then
    # toss the redundant copy
    rm $NEW
  fi
  # Otherwise, we leave the .new copy for the admin to consider...
}

config etc/clockchimes.conf.new

# root crontab missing?
if [ ! -e /var/spool/cron/crontabs/root ]; then
  # true: crontab missing, create crontab and set permissions
  touch /var/spool/cron/crontabs/root
  chmod 0600 /var/spool/cron/crontabs/root
fi # END crontab missing

# root crontab not updated?
grep "# clockchimes" /var/spool/cron/crontabs/root 1> /dev/null
if [ $? -ne 0 ]; then
  # true: crontab not updated, update with clockchimes
  cat << EOF >> /var/spool/cron/crontabs/root
# clockchimes
0,15,30,45 * * * * /usr/bin/clockchimes 1> /dev/null
EOF

  # crond running?
  ps -C crond 1>/dev/null
  if [ $? -eq 0 ]; then
    # true: crond running, reload crond
    crontab /var/spool/cron/crontabs/root 1> /dev/null
  else
    # false: crond not running, start crond
    /usr/sbin/crond -l notice
  fi # END crond running
fi # END crontab not updated
