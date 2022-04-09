config() {
  NEW="$1"
  OLD="$(dirname $NEW)/$(basename $NEW .new)"
  if [ ! -r $OLD ]; then
    mv $NEW $OLD
  elif [ "$(cat $OLD | md5sum)" = "$(cat $NEW | md5sum)" ]; then
    rm $NEW
  fi
}

config etc/csh.login.new

# If there's no csh link, take over:
if [ -d bin -a ! -r bin/csh ]; then
  ( cd bin ; ln -sf ../usr/bin/csh csh )
fi
