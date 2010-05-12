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

config etc/icecast.xml.new

# Create log files if they don't exist already
[ ! -e var/log/icecast/access.log ] && touch var/log/icecast/access.log
[ ! -e var/log/icecast/error.log ] && touch var/log/icecast/error.log

