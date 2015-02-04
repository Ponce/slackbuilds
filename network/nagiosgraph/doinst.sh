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

find etc/nagiosgraph/ -type f -name *.new \
  | while read cfg ; do config $cfg ; done

# Create rrd directory and add log files
( cd var/nagios; mkdir -p rrd; chown nagios rrd;
  touch nagiosgraph-cgi.log nagiosgraph.log;
  chown apache nagiosgraph-cgi.log nagiosgraph.log )

