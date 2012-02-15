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

config etc/nagiosgraph/servdb.conf.new
config etc/nagiosgraph/rrdopts.conf.new
config etc/nagiosgraph/ngshared.pm.new
config etc/nagiosgraph/nagiosgraph_fr.conf.new
config etc/nagiosgraph/nagiosgraph_es.conf.new
config etc/nagiosgraph/nagiosgraph_de.conf.new
config etc/nagiosgraph/nagiosgraph.conf.new
config etc/nagiosgraph/nagiosgraph-nagios.cfg.new
config etc/nagiosgraph/nagiosgraph-commands.cfg.new
config etc/nagiosgraph/nagiosgraph-apache.conf.new
config etc/nagiosgraph/map.new
config etc/nagiosgraph/labels.conf.new
config etc/nagiosgraph/hostdb.conf.new
config etc/nagiosgraph/groupdb.conf.new
config etc/nagiosgraph/datasetdb.conf.new
config etc/nagiosgraph/access.conf.new

# Create rrd directory and add log files
( cd var/nagios; mkdir -p rrd; chown nagios rrd;
  touch nagiosgraph-cgi.log nagiosgraph.log;
  chown apache nagiosgraph-cgi.log nagiosgraph.log )

