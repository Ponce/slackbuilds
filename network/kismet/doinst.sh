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

if [ -x /sbin/setcap ]
then
  /bin/chmod -c 750 \
    usr/bin/kismet_cap_linux_wifi \
    usr/bin/kismet_cap_linux_bluetooth
  /sbin/setcap \
    cap_net_raw,cap_net_admin=eip usr/bin/kismet_cap_linux_wifi \
    cap_net_raw,cap_net_admin=eip usr/bin/kismet_cap_linux_bluetooth
fi
