config() {
  NEW="$1"
  OLD="$(dirname $NEW)/$(basename $NEW .new)"
  if [ ! -r $OLD ]; then
    mv $NEW $OLD
  elif [ "$(cat $OLD | md5sum)" = "$(cat $NEW | md5sum)" ]; then
    rm $NEW
  fi
}

CONF=/usr/libLIBDIRSUFFIX/pythonPY3VER/site-packages/ffgo/data/config

for conf in $CONF/*.new ; do
  config ${conf}
done
