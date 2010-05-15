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

# Keep same perms on rc.iscsi-target.new:
if [ -e etc/rc.d/rc.iscsi-target ]; then
  cp -a etc/rc.d/rc.iscsi-target etc/rc.d/rc.iscsi-target.new.incoming
  cat etc/rc.d/rc.iscsi-target.new > etc/rc.d/rc.iscsi-target.new.incoming
  mv etc/rc.d/rc.iscsi-target.new.incoming etc/rc.d/rc.iscsi-target.new
else
  # Install executable otherwise - irrelevant unless user starts in rc.local
  chmod 0755 etc/rc.d/rc.iscsi-target.new
fi

if [ -f /etc/ietd.conf ];then
echo -en "\n\n\n!! iSCSI-target has recently changed the default location for conf files !!\n"
echo -en "The new location for conf files is now at /etc/iet\n"
echo -en "Furthermore the conf file initiators.deny is obsolete. \nFor futher info read the Man page\n\n\n"
fi

config etc/rc.d/rc.iscsi-target.new
config etc/iet/ietd.conf.new
config etc/iet/targets.allow.new
config etc/iet/initiators.allow.new 

chroot . depmod -a @KERNEL@ 2>/dev/null 1>/dev/null

