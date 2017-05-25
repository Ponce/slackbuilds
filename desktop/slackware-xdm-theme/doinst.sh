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

config etc/X11/xdm/Xresources.new
config etc/X11/xdm/Xstartup.new
config etc/X11/xdm/xdm-config.new
config etc/X11/xdm/Xsetup.new
config etc/X11/xdm/buttons.new
