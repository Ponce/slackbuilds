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
  OLD="$(dirname ${NEW})/$(basename ${NEW} .new)"
  if [ -e ${OLD} ]; then
    cp -a ${OLD} ${NEW}.incoming
    cat ${NEW} > ${NEW}.incoming
    mv ${NEW}.incoming ${NEW}
  fi
  config ${NEW}
}

preserve_perms etc/rc.d/rc.monkey.new
config etc/logrotate.d/monkey.new
config etc/monkey/monkey.conf.new
config etc/monkey/plugins.load.new
config etc/monkey/sites/default.new
config etc/monkey/plugins/cheetah/cheetah.conf.new
config etc/monkey/plugins/dirlisting/dirhtml.conf.new
config etc/monkey/plugins/fastcgi/fastcgi.conf.new
config etc/monkey/plugins/logger/logger.conf.new
config etc/monkey/plugins/mandril/mandril.conf.new
config var/www/monkey/favicon.ico.new
config var/www/monkey/index.html.new
