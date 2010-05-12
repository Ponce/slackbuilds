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

# Keep same perms on pcp.new:
if [ -e etc/rc.d/pcp ]; then
  cp -a etc/rc.d/pcp etc/rc.d/pcp.new.incoming
  cat etc/rc.d/pcp.new > etc/rc.d/pcp.new.incoming
  mv etc/rc.d/pcp.new.incoming etc/rc.d/pcp.new
fi
# Keep same perms on pmie.new:
if [ -e etc/rc.d/pmie ]; then
  cp -a etc/rc.d/pmie etc/rc.d/pmie.new.incoming
  cat etc/rc.d/pmie.new > etc/rc.d/pmie.new.incoming
  mv etc/rc.d/pmie.new.incoming etc/rc.d/pmie.new
fi
# Keep same perms on pmproxy.new:
if [ -e etc/rc.d/pmproxy ]; then
  cp -a etc/rc.d/pmproxy etc/rc.d/rc.pmproxy.new.incoming
  cat etc/rc.d/pmproxy.new > etc/rc.d/pmproxy.new.incoming
  mv etc/rc.d/pmproxy.new.incoming etc/rc.d/pmproxy.new
fi

config etc/rc.d/pcp.new
config etc/rc.d/pmie.new
config etc/rc.d/pmproxy.new
config etc/pcp.conf.new

