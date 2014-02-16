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

config etc/gdm/Xsession.new
config etc/gdm/Init/Default.new
config etc/gdm/PreSession/Default.new
config etc/gdm/PostSession/Default.new
config etc/gdm/XKeepsCrashing.new
config etc/gdm/custom.conf.new
config etc/gdm/locale.alias.new
config etc/gdm/modules/factory-AccessDwellMouseEvents.new
config etc/gdm/modules/AccessDwellMouseEvents.new
config etc/gdm/modules/factory-AccessKeyMouseEvents.new
config etc/gdm/modules/AccessKeyMouseEvents.new

if [ -x /usr/bin/update-desktop-database ]; then
  /usr/bin/update-desktop-database -q usr/share/applications >/dev/null 2>&1
fi

if [ -e usr/share/icons/hicolor/icon-theme.cache ]; then
  if [ -x /usr/bin/gtk-update-icon-cache ]; then
    /usr/bin/gtk-update-icon-cache usr/share/icons/hicolor >/dev/null 2>&1
  fi
fi

