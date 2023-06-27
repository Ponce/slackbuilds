config() {
  NEW="$1"
  OLD="$(dirname $NEW)/$(basename $NEW .new)"
  if [ ! -r $OLD ]; then
    mv $NEW $OLD
  elif [ "$(cat $OLD | md5sum)" = "$(cat $NEW | md5sum)" ]; then
    rm $NEW
  fi
}

config etc/allegro.cfg.new

if [ -x /usr/bin/install-info -a -d usr/info ]; then
  ( cd usr/info
    rm -f dir
    for i in *.info*; do /usr/bin/install-info $i dir 2>/dev/null; done
  )
fi
