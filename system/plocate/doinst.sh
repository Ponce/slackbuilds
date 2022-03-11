config() {
  NEW="$1"
  OLD="$(dirname $NEW)/$(basename $NEW .new)"
  if [ ! -r $OLD ]; then
    mv $NEW $OLD
  elif [ "$(cat $OLD | md5sum)" = "$(cat $NEW | md5sum)" ]; then
    rm $NEW
  fi
}

config etc/updatedb.conf.new

# If there's no locate link, take over:
if [ ! -r usr/bin/locate ]; then
  ( cd usr/bin ; ln -sf plocate locate )
fi

# same for these man pages
if [ ! -r usr/man/man5/updatedb.conf.5.gz ]; then
  ( cd usr/man/man5 ; ln -sf plocate-updatedb.conf.5.gz updatedb.conf.5.gz )
fi

if [ ! -r usr/man/man1/locate.1.gz ]; then
  ( cd usr/man/man1 ; ln -sf plocate.1.gz locate.1.gz )
fi
