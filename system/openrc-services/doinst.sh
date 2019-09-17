
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

for file in etc/openrc/conf.d/*.new; do
  config "${file}"
done

for file in etc/openrc/local.d/*.new; do
  preserve_perms "${file}"
done

# disable udev-postmount
[ -e "etc/openrc/runlevels/sysinit/udev-postmount" ] && rm -v "etc/openrc/runlevels/sysinit/udev-postmount"

# disable kmod-static-nodes (openrc-0.26.1, 2017-05-14)
[ -e "etc/openrc/runlevels/sysinit/kmod-static-nodes" ] && rm -v "etc/openrc/runlevels/sysinit/kmod-static-nodes"
