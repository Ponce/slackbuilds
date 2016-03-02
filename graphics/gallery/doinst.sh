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

config @GALLERY_INSTALL@/.htaccess.new
config @GALLERY_INSTALL@/index.php.new
config @GALLERY_INSTALL@/php.ini.new
config @GALLERY_INSTALL@/robots.txt.new

if [ ! -d @GALLERY_INSTALL@/var ]; then
  mkdir @GALLERY_INSTALL@/var
  chown -R @WEBUSER@:@WEBGROUP@ @GALLERY_INSTALL@/var
  chmod 0777 @GALLERY_INSTALL@/var
fi
