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

preserve_perms etc/rc.d/rc.spamd.new
config etc/mail/spamassassin/init.pre.new
config etc/mail/spamassassin/local.cf.new
config etc/mail/spamassassin/v310.pre.new
config etc/mail/spamassassin/v312.pre.new
config etc/mail/spamassassin/v320.pre.new
config etc/mail/spamassassin/v330.pre.new
config etc/spamassassin.conf.new
