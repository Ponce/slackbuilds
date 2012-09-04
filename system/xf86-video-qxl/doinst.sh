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

if [ -f etc/X11/spiceqxl.xorg.conf.new ]; then
  config etc/X11/spiceqxl.xorg.conf.new
fi
config usr/share/X11/xorg.conf.d/05-qxl.conf.new
