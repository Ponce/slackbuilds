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

GCONF_CONFIG_SOURCE="xml::etc/gconf/gconf.xml.defaults" \
chroot . gconftool-2 --makefile-install-rule \
    /etc/gconf/schemas/ibus.schemas 1>/dev/null

if [ -x /usr/bin/update-desktop-database ]; then
  /usr/bin/update-desktop-database -q usr/share/applications >/dev/null 2>&1
fi

if [ -e usr/share/icons/hicolor/icon-theme.cache ]; then
  if [ -x /usr/bin/gtk-update-icon-cache ]; then
    /usr/bin/gtk-update-icon-cache usr/share/icons/hicolor >/dev/null 2>&1
  fi
fi

# Prepare the new configuration files
for file in etc/profile.d/ibus.sh.new etc/profile.d/ibus.csh.new ; do
  if [ -e $(dirname $file)/$(basename $file .new) -a -x $(dirname $file)/$(basename $file .new) ]; then
    chmod 0755 $file
  else
    chmod 0644 $file
  fi
  config $file
done

# Run gtk-query-immodules so that "ibus" will appear under Input Method
# when you right- click your mouse in a text box.
if [ -x usr/bin/update-gtk-immodules ]; then
  chroot . /usr/bin/update-gtk-immodules --verbose 1>/dev/null
fi

