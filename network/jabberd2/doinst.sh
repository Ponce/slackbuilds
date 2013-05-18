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

config etc/jabberd2/c2s.xml.new
config etc/jabberd2/jabberd-c2s.conf.new
config etc/jabberd2/jabberd-router.conf.new
config etc/jabberd2/jabberd-s2s.conf.new
config etc/jabberd2/jabberd-sm.conf.new
config etc/jabberd2/jabberd.cfg.new
config etc/jabberd2/router-filter.xml.new
config etc/jabberd2/router-users.xml.new
config etc/jabberd2/router.xml.new
config etc/jabberd2/s2s.xml.new
config etc/jabberd2/sm.xml.new
config etc/jabberd2/templates/roster.xml.new

preserve_perms etc/rc.d/rc.jabberd2.new
