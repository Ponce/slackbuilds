config() {
  for infile in \$1; do
    NEW="\$infile"
    OLD="\`dirname \$NEW\`/\`basename \$NEW .new\`"
    # If there's no config file by that name, mv it over:
    if [ ! -r \$OLD ]; then
      mv \$NEW \$OLD
    elif [ "\`cat \$OLD | md5sum\`" = "\`cat \$NEW | md5sum\`" ]; then
      # toss the redundant copy
      rm \$NEW
    fi
    # Otherwise, we leave the .new copy for the admin to consider...
  done
}

config etc/xdg/lxsession/LXDE/autostart.new
config etc/xdg/lxsession/LXDE/desktop.conf.new
config etc/xdg/pcmanfm/main.lxde.new
config etc/xdg/pcmanfm/pcmanfm.conf.new

if [ -x /usr/bin/update-desktop-database ]; then
  /usr/bin/update-desktop-database -q usr/share/applications &> /dev/null
fi
