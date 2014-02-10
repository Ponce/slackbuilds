config() {
  NEW="$1"
  OLD="$(dirname $NEW)/$(basename $NEW .new)"
  # If there's no config file by that name, mv it over:
  if [ ! -r $OLD ]; then
    mv $NEW $OLD
  elif [ "$(cat $OLD | md5sum)" = "$(cat $NEW | md5sum)" ]; then
    # toss the redundant copy
    rm $NEW
  else
  # Otherwise, we leave the .new copy for the admin to consider...
  echo -e "New configuration file /etc/asbt/asbt.conf.new created.\nYou may need to merge changes."
  fi
}

config etc/asbt/asbt.conf.new
