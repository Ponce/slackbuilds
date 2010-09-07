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

# Keep same perms on rc.cassandra.new:
if [ -e etc/rc.d/rc.cassandra ]; then
  cp -a etc/rc.d/rc.cassandra etc/rc.d/rc.cassandra.new.incoming
  cat etc/rc.d/rc.cassandra.new > etc/rc.d/rc.cassandra.new.incoming
  mv etc/rc.d/rc.cassandra.new.incoming etc/rc.d/rc.cassandra.new
fi

config etc/rc.d/rc.cassandra.new

# Keep same perms on storage-conf.xml.new:
if [ -e etc/apache-cassandra/storage-conf.xml ]; then
  cp -a etc/apache-cassandra/storage-conf.xml etc/apache-cassandra/storage-conf.xml.new.incoming
  cat etc/apache-cassandra/storage-conf.xml.new > etc/apache-cassandra/storage-conf.xml.new.incoming
  mv etc/apache-cassandra/storage-conf.xml.new.incoming etc/apache-cassandra/storage-conf.xml.new
fi

config etc/apache-cassandra/storage-conf.xml.new

# Keep same perms on cassandra.in.sh.new:
if [ -e etc/apache-cassandra/cassandra.in.sh ]; then
  cp -a etc/apache-cassandra/cassandra.in.sh etc/apache-cassandra/cassandra.in.sh.new.incoming
  cat etc/apache-cassandra/cassandra.in.sh.new > etc/apache-cassandra/cassandra.in.sh.new.incoming
  mv etc/apache-cassandra/cassandra.in.sh.new.incoming etc/apache-cassandra/cassandra.in.sh.new
fi

config etc/apache-cassandra/cassandra.in.sh.new