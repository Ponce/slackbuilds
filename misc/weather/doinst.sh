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

if [ -L usr/bin/weather ]; then
  break # Assume that this package is already installed and do nothing
elif [ ! -e usr/bin/weather.expect -a -e usr/bin/weather ]; then
  # otherwise if /usr/bin/weather is present (and not a symlink) and
  # /usr/bin/weather.expect is not present, then we need to back up 
  # the existing /usr/bin/weather, which is assumed to come from the
  # stock expect package
  cp -a usr/bin/weather usr/bin/weather.expect
fi  

config etc/weatherrc.new

if [ -x /usr/bin/update-desktop-database ]; then
  /usr/bin/update-desktop-database -q usr/share/applications >/dev/null 2>&1
fi

if [ -x /usr/bin/update-mime-database ]; then
  /usr/bin/update-mime-database usr/share/mime >/dev/null 2>&1
fi

