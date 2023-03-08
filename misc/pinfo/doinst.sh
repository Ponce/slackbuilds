config() {
  NEW="$1"
  OLD="$(dirname $NEW)/$(basename $NEW .new)"
  if [ ! -r $OLD ]; then
    mv $NEW $OLD
  elif [ "$(cat $OLD | md5sum)" = "$(cat $NEW | md5sum)" ]; then
    rm $NEW
  fi
}

config etc/pinforc.new

if [ -x /usr/bin/install-info ]; then
  /usr/bin/install-info usr/info/pinfo.info.gz usr/info/dir
fi
