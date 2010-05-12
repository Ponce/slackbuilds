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

config etc/rc.d/rc.shorewall6.new

config etc/shorewall6/accounting.new
config etc/shorewall6/actions.new
config etc/shorewall6/blacklist.new
config etc/shorewall6/hosts.new
config etc/shorewall6/init.new
config etc/shorewall6/interfaces.new
config etc/shorewall6/maclist.new
config etc/shorewall6/notrack.new
config etc/shorewall6/params.new
config etc/shorewall6/policy.new
config etc/shorewall6/providers.new
config etc/shorewall6/restored.new
config etc/shorewall6/route_rules.new
config etc/shorewall6/routestopped.new
config etc/shorewall6/rules.new
config etc/shorewall6/shorewall6.conf.new
config etc/shorewall6/start.new
config etc/shorewall6/started.new
config etc/shorewall6/stop.new
config etc/shorewall6/stopped.new
config etc/shorewall6/tcclasses.new
config etc/shorewall6/tcdevices.new
config etc/shorewall6/tcrules.new
config etc/shorewall6/tos.new
config etc/shorewall6/tunnels.new
config etc/shorewall6/zones.new

