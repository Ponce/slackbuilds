config() {
  NEW="$1"
  OLD="${NEW%*.new}"
  # If there's no config file by that name, mv it over:
  if [ ! -r $OLD ]; then
    mv $NEW $OLD
  elif [ "$(cat $OLD | md5sum)" = "$(cat $NEW | md5sum)" ]; then # toss the redundant copy
    rm $NEW
  fi
  # Otherwise, we leave the .new copy for the admin to consider...
}

# Keep same perms on rc.firewall.new:
if [ -e etc/rc.d/rc.firewall ]; then
  cp -a etc/rc.d/rc.firewall etc/rc.d/rc.firewall.new.incoming
  cat etc/rc.d/rc.firewall.new > etc/rc.d/rc.firewall.new.incoming
  mv etc/rc.d/rc.firewall.new.incoming etc/rc.d/rc.firewall.new
fi
# Keep same perms on rc.shorewall.new:
if [ -e etc/rc.d/rc.shorewall ]; then
  cp -a etc/rc.d/rc.shorewall etc/rc.d/rc.shorewall.new.incoming
  cat etc/rc.d/rc.shorewall.new > etc/rc.d/rc.shorewall.new.incoming
  mv etc/rc.d/rc.shorewall.new.incoming etc/rc.d/rc.shorewall.new
fi

config etc/rc.d/rc.firewall.new
config etc/rc.d/rc.shorewall.new

config etc/shorewall/accounting.new
config etc/shorewall/actions.new
config etc/shorewall/blacklist.new
config etc/shorewall/continue.new
config etc/shorewall/ecn.new
config etc/shorewall/hosts.new
config etc/shorewall/init.new
config etc/shorewall/initdone.new
config etc/shorewall/interfaces.new
config etc/shorewall/ipsec.new
config etc/shorewall/maclist.new
config etc/shorewall/masq.new
config etc/shorewall/nat.new
config etc/shorewall/netmap.new
config etc/shorewall/notrack.new
config etc/shorewall/params.new
config etc/shorewall/policy.new
config etc/shorewall/providers.new
config etc/shorewall/proxyarp.new
config etc/shorewall/restored.new
config etc/shorewall/route_rules.new
config etc/shorewall/routestopped.new
config etc/shorewall/rules.new
config etc/shorewall/shorewall.conf.new
config etc/shorewall/start.new
config etc/shorewall/started.new
config etc/shorewall/stop.new
config etc/shorewall/stopped.new
config etc/shorewall/tcclasses.new
config etc/shorewall/tcdevices.new
config etc/shorewall/tcfilters.new
config etc/shorewall/tcrules.new
config etc/shorewall/tos.new
config etc/shorewall/tunnels.new
config etc/shorewall/zones.new

