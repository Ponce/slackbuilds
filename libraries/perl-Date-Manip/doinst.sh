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

if [ -L etc/localtime-copied-from ]; then
  localTime="$(readlink etc/localtime-copied-from)"
  echo $localTime | cut -d/ -f5- > etc/timezone.new
fi

config etc/timezone.new

