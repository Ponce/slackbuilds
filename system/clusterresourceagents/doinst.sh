config() {
  NEW="$1"
  OLD="$(dirname $NEW)/$(basename $NEW .new)"
  if [ ! -r $OLD ]; then
    mv $NEW $OLD
  elif [ "$(cat $OLD | md5sum)" = "$(cat $NEW | md5sum)" ]; then
    rm $NEW
  fi
}

if [ -e etc/rc.d/rc.ldirectord ]; then
  cp -a etc/rc.d/rc.ldirectord etc/rc.d/rc.ldirectord.new.incoming
  cat etc/rc.d/rc.ldirectord.new > etc/rc.d/rc.ldirectord.new.incoming
  mv etc/rc.d/rc.ldirectord.new.incoming etc/rc.d/rc.ldirectord.new
fi

if [ -e etc/logrotate.d/ldirectord ]; then
  cp -a etc/logrotate.d/ldirectord etc/logrotate.d/ldirectord.new.incoming
  cat etc/logrotate.d/ldirectord.new > etc/logrotate.d/ldirectord.new.incoming
  mv etc/logrotate.d/ldirectord.new.incoming etc/logrotate.d/ldirectord.new
fi

if [ -e etc/ha.d/shellfuncs ]; then
  cp -a etc/ha.d/shellfuncs etc/ha.d/shellfuncs.new.incoming
  cat etc/ha.d/shellfuncs.new > etc/ha.d/shellfuncs.new.incoming
  mv etc/ha.d/shellfuncs.new.incoming etc/ha.d/shellfuncs.new
fi

config etc/rc.d/rc.ldirectord.new
config etc/logrotate.d/ldirectord.new
config etc/ha.d/shellfuncs.new

