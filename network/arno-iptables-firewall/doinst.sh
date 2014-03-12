config() {
  NEW="$1"
  OLD="$(dirname $NEW)/$(basename $NEW .new)"
  if [ ! -r $OLD ]; then
    mv $NEW $OLD
  elif [ "$(cat $OLD | md5sum)" = "$(cat $NEW | md5sum)" ]; then
    rm $NEW
  fi
}

CONFIG=${CONFIG:-/etc/arno-iptables-firewall}
for conf in $( find $CONFIG -name *.new ) ; do
  config ${conf}
done
