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

# Keep same perms on rc.gmond.new:
if [ -e etc/rc.d/rc.gmond ]; then
  cp -a etc/rc.d/rc.gmond etc/rc.d/rc.gmond.new.incoming
  cat etc/rc.d/rc.gmond.new > etc/rc.d/rc.gmond.new.incoming
  mv etc/rc.d/rc.gmond.new.incoming etc/rc.d/rc.gmond.new
fi
config etc/rc.d/rc.gmond.new
config etc/gmond.conf.new

if [ -e etc/gmetad.conf.new ]; then
  config etc/gmetad.conf.new
fi

if [ -e etc/rc.d/rc.gmetad.new ]; then
  # Keep same perms on rc.gmetad.new:
  if [ -e etc/rc.d/rc.gmetad ]; then
    cp -a etc/rc.d/rc.gmetad etc/rc.d/rc.gmetad.new.incoming
    cat etc/rc.d/rc.gmetad.new > etc/rc.d/rc.gmetad.new.incoming
    mv etc/rc.d/rc.gmetad.new.incoming etc/rc.d/rc.gmetad.new
  fi
  config etc/rc.d/rc.gmetad.new
fi

