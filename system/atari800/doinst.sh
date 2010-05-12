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

# Keep same perms on rc.atari800_binfmt_misc.new:
if [ -e etc/rc.d/rc.atari800_binfmt_misc ]; then
  cp -a etc/rc.d/rc.atari800_binfmt_misc etc/rc.d/rc.atari800_binfmt_misc.new.incoming
  cat etc/rc.d/rc.atari800_binfmt_misc.new > etc/rc.d/rc.atari800_binfmt_misc.new.incoming
  mv etc/rc.d/rc.atari800_binfmt_misc.new.incoming etc/rc.d/rc.atari800_binfmt_misc.new
fi

config etc/rc.d/rc.atari800_binfmt_misc.new

if [ -x /usr/bin/update-desktop-database ]; then
  /usr/bin/update-desktop-database -q usr/share/applications >/dev/null 2>&1
fi

if [ -x /usr/bin/update-mime-database ]; then
  /usr/bin/update-mime-database usr/share/mime >/dev/null 2>&1
fi

