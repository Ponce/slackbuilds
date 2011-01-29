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

preserve_perms() {
  NEW="$1"
  OLD="$(dirname $NEW)/$(basename $NEW .new)"
  if [ -e $OLD ]; then
    cp -a $OLD ${NEW}.incoming
    cat $NEW > ${NEW}.incoming
    mv ${NEW}.incoming $NEW
  fi
  config $NEW
}

if [ -x /usr/bin/update-desktop-database ]; then
  /usr/bin/update-desktop-database -q usr/share/applications >/dev/null 2>&1
fi

if [ -x /usr/bin/update-mime-database ]; then
  /usr/bin/update-mime-database usr/share/mime >/dev/null 2>&1
fi

config etc/rox/xdg/rox.sourceforge.net/MIME-types/application_postscript.new
config etc/rox/xdg/rox.sourceforge.net/MIME-types/text.new
config etc/rox/xdg/rox.sourceforge.net/MIME-types/text_html.new
config etc/profile.d/rox-filer.sh.new
config etc/profile.d/rox-filer.csh.new

preserve_perms etc/profile.d/rox-filer.sh.new
preserve_perms etc/profile.d/rox-filer.csh.new
