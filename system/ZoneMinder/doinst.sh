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

config etc/zm/zm.conf.new
config etc/zm/zm_apache.conf.new
config etc/logrotate.d/zm.new
config etc/rc.d/rc.zm.new

echo ""
echo "   If this is a new installation, you will need to create a MySQL database"
echo "   for ZoneMinder to use. See /usr/doc/ZoneMinder-<version>/README.SLACKWARE"
echo ""
echo "   If you are upgrading, you will need to run the zmupdate.pl script:"
echo "   /usr/bin/zmupdate.pl version=<from version> [--user=<my_database_user> --pass=<my_database_pass>]"
echo ""
