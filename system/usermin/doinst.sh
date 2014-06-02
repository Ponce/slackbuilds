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

config etc/usermin/miniserv.conf.new
config etc/usermin/miniserv.users.new
config etc/usermin/config.new
config etc/usermin/at/config.new
config etc/usermin/changepass/config.new
config etc/usermin/chfn/config.new
config etc/usermin/commands/config.new
config etc/usermin/cron/config.new
config etc/usermin/cshrc/config.new
config etc/usermin/fetchmail/config.new
config etc/usermin/file/config.new
config etc/usermin/filter/config.new
config etc/usermin/forward/config.new
config etc/usermin/gnupg/config.new
config etc/usermin/htaccess/config.new
config etc/usermin/htaccess-htpasswd/config.new
config etc/usermin/language/config.new
config etc/usermin/mailbox/config.new
config etc/usermin/mailcap/config.new
config etc/usermin/man/config.new
config etc/usermin/mysql/config.new
config etc/usermin/plan/config.new
config etc/usermin/postgresql/config.new
config etc/usermin/proc/config.new
config etc/usermin/procmail/config.new
config etc/usermin/quota/config.new
config etc/usermin/schedule/config.new
config etc/usermin/shell/config.new
config etc/usermin/spam/config.new
config etc/usermin/ssh/config.new
config etc/usermin/theme/config.new
config etc/usermin/telnet/config.new
config etc/usermin/tunnel/config.new
config etc/usermin/updown/config.new
config etc/usermin/usermount/config.new
