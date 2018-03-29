# doinst.sh for clockchimes
# focus is on making sure cron is managing clockchime script

# negative test: check if root crontab exists
if [ ! -e /var/spool/cron/crontabs/root ]; then
  # true: does not exist, create root crontab and set permissions
  touch /var/spool/cron/crontabs/root
  chmod 0600 /var/spool/cron/crontabs/root
fi

# negative test: check if root crontab previously modified
grep "# clockchimes" /var/spool/cron/crontabs/root 1> /dev/null
if [ $? -ne 0 ]; then

# true: not previously modified
cat << EOF >> /var/spool/cron/crontabs/root
# clockchimes
0,15,30,45 * * * * /usr/bin/clockchimes.sh 1> /dev/null
EOF

  # positive test: check if crond is running
  ps -C crond 1>/dev/null
  if [ $? -eq 0 ]; then
    # true: reload crond
    crontab /var/spool/cron/crontabs/root 1> /dev/null
  fi
fi
