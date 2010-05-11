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

if [ -x usr/bin/update-desktop-database ]; then
  usr/bin/update-desktop-database usr/share/applications >/dev/null 2>&1
fi

# Keep same perms on rc.wifi-radar.new:
if [ -e etc/rc.d/rc.wifi-radar ]; then
  cp -a etc/rc.d/rc.wifi-radar etc/rc.d/rc.wifi-radar.new.incoming
  cat etc/rc.d/rc.wifi-radar.new > etc/rc.d/rc.wifi-radar.new.incoming
  mv etc/rc.d/rc.wifi-radar.new.incoming etc/rc.d/rc.wifi-radar.new
fi

config etc/wifi-radar/wifi-radar.conf.new
config etc/rc.d/rc.wifi-radar.new

echo "Remember to edit /etc/wifi-radar/wifi-radar.conf to suit your needs..."
echo 
echo "To use wifi-radar with a normal user (with sudo) add:"
echo "%users   ALL = NOPASSWD: /usr/sbin/wifi-radar"
echo "to /etc/sudoers, then launch wifi-radar.sh"
echo
