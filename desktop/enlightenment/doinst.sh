config() {
  NEW="$1"
  OLD="$(dirname $NEW)/$(basename $NEW .new)"
  if [ ! -r $OLD ]; then
    mv $NEW $OLD
  elif [ "$(cat $OLD | md5sum)" = "$(cat $NEW | md5sum)" ]; then
    rm $NEW
  fi
}

config etc/enlightenment/sysactions.conf.new
config etc/xdg/menus/enlightenment.menu.new
config etc/X11/xinit/xinitrc.enlightenment17.new
