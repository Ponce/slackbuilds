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

config etc/glxosd.new

# Update the X font indexes:
if [ -x /usr/bin/mkfontdir ]; then
  ( cd /usr/share/fonts/TTF
    mkfontscale .
    mkfontdir .
  )
fi

if [ -x /usr/bin/fc-cache ]; then
  /usr/bin/fc-cache -f
fi
