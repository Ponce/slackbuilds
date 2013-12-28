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

config etc/hostsblock/rc.conf.new

# backup existing /etc/hosts to /etc/hostsblock/hosts.head if it doesn't already exist
if [ ! -r /etc/hostsblock/hosts.head ] ; then
  cp /etc/hosts /etc/hostsblock/hosts.head
fi
