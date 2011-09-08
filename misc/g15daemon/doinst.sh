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

perms(){

  # Keep same perms on $1.new:
  if [ -e "$1" ]; then
    cp -a "$1" "$1".new.incoming
    cat "$1".new > "$1".new.incoming
    mv "$1".new.incoming "$1".new
  fi

  config "$1".new
}

perms etc/rc.d/rc.g15daemon
perms etc/rc.d/rc.g15daemon.conf
