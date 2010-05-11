# Add heimdal libs to the library search path
if ! grep -q '^/usr/heimdal/lib$' etc/ld.so.conf ; then
  echo "/usr/heimdal/lib" >> etc/ld.so.conf
fi

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

# Keep same perms on rc.heimdal:
if [ -e etc/rc.d/rc.heimdal ]; then
  cp -a etc/rc.d/rc.heimdal etc/rc.d/rc.heimdal.new.incoming
  cat etc/rc.d/rc.heimdal.new > etc/rc.d/rc.heimdal.new.incoming
  mv etc/rc.d/rc.heimdal.new.incoming etc/rc.d/rc.heimdal.new
fi

# Prepare the new configuration files
for file in \
  etc/rc.d/rc.heimdal.new \
  etc/profile.d/heimdal.sh.new \
  etc/profile.d/heimdal.csh.new ; 
 do
  if [ -e $(dirname $file)/$(basename $file .new) -a -x $(dirname $file)/$(basename $file .new) ]; then
    chmod 0755 $file
  else
    chmod 0644 $file
  fi
  config $file
done

config etc/krb5.conf-sample.new
config var/heimdal/kdc.conf-sample.new

