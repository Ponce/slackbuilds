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

# Keep same perms on rc.zabbix_agentd.new:
if [ -e etc/rc.d/rc.zabbix_agentd ]; then
  cp -a etc/rc.d/rc.zabbix_agentd etc/rc.d/rc.zabbix_agentd.new.incoming
  cat etc/rc.d/rc.zabbix_agentd.new > etc/rc.d/rc.zabbix_agentd.new.incoming
  mv etc/rc.d/rc.zabbix_agentd.new.incoming etc/rc.d/rc.zabbix_agentd.new
fi

config etc/rc.d/rc.zabbix_agentd.new
config etc/zabbix/zabbix_agentd.conf.new
config var/log/zabbix/zabbix_agentd.log.new
rm -f var/log/zabbix/zabbix_agentd.log.new

