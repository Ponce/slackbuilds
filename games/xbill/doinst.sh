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

# Keep old hi-scores if any
config var/games/xbill/scores.new

# Allow group games write and dissallow write access to others
chgrp -R games var/games/xbill
chmod -R g+w,o-w var/games/xbill

# Change privs on our little wrapper
chgrp video usr/bin/xbill
chmod 4750 usr/bin/xbill

