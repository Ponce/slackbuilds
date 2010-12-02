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
  OLD="$(dirname ${NEW})/$(basename ${NEW} .new)"
  if [ -e ${OLD} ]; then
    cp -a ${OLD} ${NEW}.incoming
    cat ${NEW} > ${NEW}.incoming
    mv ${NEW}.incoming ${NEW}
  fi
  config ${NEW}
}

if [ -e etc/HOSTNAME ]; then
  sed -i "s,yourhostname,$(cat etc/HOSTNAME | cut -f1 -d .)," \
    etc/NetworkManager/NetworkManager.conf.new
fi

preserve_perms etc/rc.d/rc.networkmanager.new
config etc/NetworkManager/NetworkManager.conf.new

