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

# Keep same perms on rc.conserver:
if [ -e etc/rc.d/rc.conserver ]; then
  cp -a etc/rc.d/rc.conserver etc/rc.d/rc.conserver.new.incoming
  cat etc/rc.d/rc.conserver.new > etc/rc.d/rc.conserver.new.incoming
  mv etc/rc.d/rc.conserver.new.incoming etc/rc.d/rc.conserver.new
fi

config etc/rc.d/rc.conserver.new
config etc/conserver.cf.new
config etc/conserver.passwd.new
config etc/console.cf.new

# Make sure there is a service mapping for conserver
if ! grep -q "^conserver" etc/services ; then
  printf "conserver\t782/tcp\tconsole\t# Console Server\n" >> etc/services
fi

