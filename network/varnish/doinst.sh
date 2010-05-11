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

# Keep same perms on rc.varnishd.new:
if [ -e etc/rc.d/rc.varnishd ]; then
  cp -a etc/rc.d/rc.varnishd etc/rc.d/rc.varnishd.new.incoming
  cat etc/rc.d/rc.varnishd.new > etc/rc.d/rc.varnishd.new.incoming
  mv etc/rc.d/rc.varnishd.new.incoming etc/rc.d/rc.varnishd.new
fi

config etc/rc.d/rc.varnishd.new
config etc/varnish/default.vcl.new
config etc/varnish/zope-plone.vcl.new

