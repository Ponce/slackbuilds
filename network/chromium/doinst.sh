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

config etc/chromium/00-default.conf.new

# Update the desktop database:
if [ -x usr/bin/update-desktop-database ]; then
  /usr/bin/update-desktop-database usr/share/applications > /dev/null 2>&1
fi

# Update hicolor theme cache:
if [ -d usr/share/icons/hicolor ]; then
  if [ -x /usr/bin/gtk-update-icon-cache ]; then
    /usr/bin/gtk-update-icon-cache -f -t usr/share/icons/hicolor 1> /dev/null 2> /dev/null
  fi
fi

# Update the mime database:
if [ -x usr/bin/update-mime-database ]; then
  /usr/bin/update-mime-database usr/share/mime >/dev/null 2>&1
fi
