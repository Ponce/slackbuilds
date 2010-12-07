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

# Keep same perms on rc.fail2ban.new:
if [ -e etc/rc.d/rc.fail2ban ]; then
  cp -a etc/rc.d/rc.fail2ban etc/rc.d/rc.fail2ban.new.incoming
  cat etc/rc.d/rc.fail2ban.new > etc/rc.d/rc.fail2ban.new.incoming
  mv etc/rc.d/rc.fail2ban.new.incoming etc/rc.d/rc.fail2ban.new
fi

config etc/rc.d/rc.fail2ban.new
config etc/logrotate.d/fail2ban.new
config etc/fail2ban/fail2ban.conf.new
config etc/fail2ban/jail.conf.new

for conf_file in etc/fail2ban/action.d/*.new; do
  config $conf_file
done
for conf_file in etc/fail2ban/filter.d/*.new; do
  config $conf_file
done
