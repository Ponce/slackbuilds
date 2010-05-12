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

# Keep same permissions on rc.spamd.new as an existing rc.spamd:
if [ -e etc/rc.d/rc.spamd ]; then
  cp -a etc/rc.d/rc.spamd etc/rc.d/rc.spamd.new.incoming
  cat etc/rc.d/rc.spamd.new > etc/rc.d/rc.spamd.new.incoming
  mv etc/rc.d/rc.spamd.new.incoming etc/rc.d/rc.spamd.new
else
  # If rc.spamd does not exist, make the new one executable by default, 
  # which won't matter unless it's called from rc.local anyway
  chmod 0755 etc/rc.d/rc.spamd.new
fi

config etc/mail/spamassassin/init.pre.new
config etc/mail/spamassassin/local.cf.new
config etc/mail/spamassassin/v310.pre.new
config etc/mail/spamassassin/v312.pre.new
config etc/mail/spamassassin/v320.pre.new
config etc/mail/spamassassin/v330.pre.new
config etc/rc.d/rc.spamd.new
config etc/spamassassin.conf.new
