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

config etc/kazehakase/bookmarkbar.xml.new
config etc/kazehakase/bookmarks.xml.new
config etc/kazehakase/kz-ui-beginner.xml.new
config etc/kazehakase/kz-ui-medium.xml.new
config etc/kazehakase/kz-ui-expert.xml.new
config etc/kazehakase/kz-ui-bookmarks.xml.new
config etc/kazehakase/kzrc.new
config etc/kazehakase/proxyrc.new
config etc/kazehakase/smartbookmarks.xml.new
config etc/kazehakase/mozilla/encodings.xml.new

if [ -x /usr/bin/update-desktop-database ]; then
  /usr/bin/update-desktop-database -q usr/share/applications
fi
