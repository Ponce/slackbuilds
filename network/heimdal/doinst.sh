# Add heimdal libs to the library search path
if ! grep -q '^/usr/heimdal/lib$' etc/ld.so.conf ; then
  echo "/usr/heimdal/lib" >> etc/ld.so.conf
  if [ -x /sbin/ldconfig ]; then /sbin/ldconfig ; fi
fi

config() {
  NEW="$1"
  OLD="`dirname $NEW`/`basename $NEW .new`"
  # If there's no config file by that name, mv it over:
  if [ ! -r $OLD ]; then
    mv $NEW $OLD
  elif [ "`cat $OLD | md5sum`" = "`cat $NEW | md5sum`" ]; then
    # toss the redundant copy
    rm $NEW
  fi
  # Otherwise, we leave the .new copy for the admin to consider...
}

config etc/krb5.conf-sample.new
config etc/profile.d/heimdal.sh.new
config etc/profile.d/heimdal.csh.new
config etc/rc.d/rc.heimdal.new
config var/heimdal/kdc.conf-sample.new

# Any user should be able to ``kinit'' at least
if [ ! -x etc/profile.d/heimdal.sh ]; then
  chmod +x etc/profile.d/heimdal.sh
  chmod +x etc/profile.d/heimdal.csh
fi

