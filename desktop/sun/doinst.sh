config() {
  NEW="$1"
  OLD="$(dirname $NEW)/$(basename $NEW .new)"
  if [ ! -r $OLD ]; then
    mv $NEW $OLD
  elif [ "$(cat $OLD | md5sum)" = "$(cat $NEW | md5sum)" ]; then
    rm $NEW
  fi
}

config etc/sun/sun.toml.new
config etc/sun/repositories.toml.new

if [ -x /usr/bin/update-desktop-database ]; then
  /usr/bin/update-desktop-database -q usr/share/applications >/dev/null 2>&1
fi

cmp etc/xdg/autostart/sun-daemon.desktop etc/xdg/autostart/sun-daemon.desktop.sample 2> /dev/null && \
	  rm etc/xdg/autostart/sun-daemon.desktop.sample
