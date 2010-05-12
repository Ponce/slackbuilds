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

# Keep same perms on nikto.conf:
if [ -e etc/nikto.conf ]; then
  cp -a etc/nikto.conf etc/nikto.conf.new.incoming
  cat etc/nikto.conf.new > etc/nikto.conf.new.incoming
  mv etc/nikto.conf.new.incoming etc/nikto.conf.new
fi

config etc/nikto.conf.new

