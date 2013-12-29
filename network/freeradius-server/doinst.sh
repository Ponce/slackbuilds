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

preserve_perms etc/rc.d/rc.radiusd.new
config etc/raddb/clients.conf.new
config etc/raddb/eap.conf.new
config etc/raddb/experimental.conf.new
config etc/raddb/policy.conf.new
config etc/raddb/proxy.conf.new
config etc/raddb/radiusd.conf.new
config etc/raddb/sql.conf.new
config etc/raddb/sqlippool.conf.new
config etc/raddb/templates.conf.new
config etc/raddb/users.new

