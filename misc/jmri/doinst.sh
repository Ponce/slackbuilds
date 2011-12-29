if [ ! -e var/log/jmri/messages.log ]; then
  mv var/log/jmri/messages.log.new var/log/jmri/messages.log
else
  rm -f var/log/jmri/messages.log.new
fi

if [ -x /usr/bin/update-desktop-database ]; then
  /usr/bin/update-desktop-database -q usr/share/applications >/dev/null 2>&1
fi
