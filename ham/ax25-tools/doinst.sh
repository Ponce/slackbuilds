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

config etc/ax25/ax25.profile.new
config etc/ax25/rxecho.conf.new
config etc/ax25/nrbroadcast.new
config etc/ax25/ttylinkd.conf.new
config etc/ax25/ax25d.conf.new
config etc/ax25/rip98d.conf.new
config etc/ax25/axspawn.conf.new
