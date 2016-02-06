config() {
  NEW="$1"
  OLD="$(dirname $NEW)/$(basename $NEW .new)"
  # If there's no config file by that name, mv it over:
  if [ ! -r $OLD ]; then
    mv $NEW $OLD
  elif [ "$(cat $OLD|md5sum)" = "$(cat $NEW|md5sum)" ]; then
    # toss the redundant copy
    rm $NEW
  fi
  # Otherwise, we leave the .new copy for the admin to consider...
}

config etc/php.d/imagick.ini.new

/usr/bin/pecl install --nodeps --soft --force --register-only --nobuild \
  usr/libLIBDIRSUFFIX/php/.pkgxml/imagick.xml > /dev/null
