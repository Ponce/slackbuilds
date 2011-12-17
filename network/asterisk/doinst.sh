config() {
  NEW="$1"
  OLD="$(dirname $NEW)/$(basename $NEW .new)"
  # If there's no config file by that name, mv it over:
  if [ ! -r $OLD ]; then
    mv $NEW $OLD
  elif [ "$(cat $OLD | md5sum)" = "$(cat $NEW | md5sum)" ]; then # toss the redundant copy
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

preserve_perms etc/rc.d/rc.asterisk.new
config etc/logrotate.d/asterisk.new
config etc/asterisk/asterisk.conf.new
config etc/asterisk/codecs.conf.new
config etc/asterisk/extensions.conf.new
config etc/asterisk/iax.conf.new
config etc/asterisk/indications.conf.new
config etc/asterisk/modules.conf.new
config etc/asterisk/musiconhold.conf.new
config etc/asterisk/sip.conf.new

