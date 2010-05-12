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

# Keep same perms on rc.zabbix_server.new:
if [ -e etc/rc.d/rc.zabbix_server ]; then
  cp -a etc/rc.d/rc.zabbix_server etc/rc.d/rc.zabbix_server.new.incoming
  cat etc/rc.d/rc.zabbix_server.new > etc/rc.d/rc.zabbix_server.new.incoming
  mv etc/rc.d/rc.zabbix_server.new.incoming etc/rc.d/rc.zabbix_server.new
fi

config etc/rc.d/rc.zabbix_server.new
config etc/zabbix/zabbix_server.conf.new
config var/log/zabbix/zabbix_server.log.new
rm -f var/log/zabbix/zabbix_server.log.new

