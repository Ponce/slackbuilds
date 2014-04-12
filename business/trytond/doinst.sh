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

# Keep same perms on rc.openerp-server.new:
if [ -e etc/rc.d/rc.trytond ]; then
  cp -a etc/rc.d/rc.trytond etc/rc.d/rc.trytond.new.incoming
  cat etc/rc.d/rc.trytond.new > etc/rc.d/rc.trytond.new.incoming
  mv etc/rc.d/rc.trytond.new.incoming etc/rc.d/rc.trytond.new
fi

config etc/rc.d/rc.trytond.new
config etc/trytond/trytond.conf.new
