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

# Keep same perms on rc.zabbix_proxy.new:
if [ -e etc/rc.d/rc.zabbix_proxy ]; then
  cp -a etc/rc.d/rc.zabbix_proxy etc/rc.d/rc.zabbix_proxy.new.incoming
  cat etc/rc.d/rc.zabbix_proxy.new > etc/rc.d/rc.zabbix_proxy.new.incoming
  mv etc/rc.d/rc.zabbix_proxy.new.incoming etc/rc.d/rc.zabbix_proxy.new
fi

config etc/rc.d/rc.zabbix_proxy.new
config etc/zabbix/zabbix_proxy.conf.new
config var/log/zabbix/zabbix_proxy.log.new
rm -f var/log/zabbix/zabbix_proxy.log.new

