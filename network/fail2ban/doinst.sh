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

preserve_perms etc/rc.d/rc.fail2ban.new
config etc/logrotate.d/fail2ban.new
config etc/fail2ban/fail2ban.conf.new
config etc/fail2ban/jail.conf.new
config etc/fail2ban/paths-common.conf.new
config etc/fail2ban/paths-slackware.conf.new
config etc/bash_completion.d/fail2ban.new

for conf_file in etc/fail2ban/action.d/*.new; do
  config $conf_file
done
for conf_file in etc/fail2ban/filter.d/*.new; do
  config $conf_file
done
