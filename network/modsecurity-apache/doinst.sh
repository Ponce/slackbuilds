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

config etc/httpd/extra/modsecurity-recommended.conf.new
config etc/httpd/crs/crs-setup.conf.new
config etc/httpd/crs/rules/REQUEST-900-EXCLUSION-RULES-BEFORE-CRS.conf.new
config etc/httpd/crs/rules/RESPONSE-999-EXCLUSION-RULES-AFTER-CRS.conf.new

