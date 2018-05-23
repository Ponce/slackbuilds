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
config etc/cron.d/clockchimes.new

# clean root crontab from versions before v0.3
grep 'clockchimes' /var/spool/cron/crontabs/root 1>/dev/null
if [ $? -eq 0 ]; then
  grep -v 'clockchimes' > /var/spool/cron/crontabs/root
fi # END clean root crontab

# kill crond if running
ps -C crond 1>/dev/null
if [ $? -eq 0 ]; then
  # true: kill crond
  killall crond 1>/dev/null
fi # END crond running

# start crond if not running
ps -C crond 1>/dev/null
if [ $? -ne 0 ]; then
  # true: start crond
  /usr/sbin/crond -l notice
fi # END crond running
