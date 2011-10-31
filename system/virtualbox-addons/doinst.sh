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

preserve_perms() {
  NEW="$1"
  OLD="$(dirname $NEW)/$(basename $NEW .new)"
  if [ -e $OLD ]; then
    cp -a $OLD ${NEW}.incoming
    cat $NEW > ${NEW}.incoming
    mv ${NEW}.incoming $NEW
  fi
  config $NEW
}

# Fix starting of kde within virtualbox
BLACKLIST="usr/share/apps/kconf_update/kwin_blacklist.upd"
VBOX_TEST=$(grep -c "Blacklist-virtualbox" $BLACKLIST)

if [ "$VBOX_TEST" = "0" ]; then
cat << EOF >> $BLACKLIST
Id=Blacklist-virtualbox
Options=overwrite
File=kwinrc
Script=kwin_blacklist_vbox.sh,sh
EOF
fi

preserve_perms etc/rc.d/rc.vboxadd.new
preserve_perms etc/rc.d/rc.vboxadd-service.new

# remove existing fdi cache to recognize newly installed fdi files
# and restart hal to regenerate the cache
rm -f var/cache/hald/fdi-cache
chroot . /etc/rc.d/rc.hald restart

