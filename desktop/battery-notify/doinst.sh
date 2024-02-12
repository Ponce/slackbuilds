config() {
  NEW="$1"
  OLD="$(dirname $NEW)/$(basename $NEW .new)"
  if [ ! -r $OLD ]; then
    mv $NEW $OLD
  elif [ "$(cat $OLD | md5sum)" = "$(cat $NEW | md5sum)" ]; then
    rm $NEW
  fi
}

config etc/battery-notify/config.toml.new

cmp etc/xdg/autostart/battery-daemon.desktop etc/xdg/autostart/battery-daemon.desktop.sample 2> /dev/null && \
	rm etc/xdg/autostart/battery-daemon.desktop
