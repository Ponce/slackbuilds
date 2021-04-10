if [ -x /usr/bin/update-desktop-database ]; then
  /usr/bin/update-desktop-database -q usr/share/applications >/dev/null 2>&1
fi

if [ -x /usr/bin/update-mime-database ]; then
  /usr/bin/update-mime-database usr/share/mime >/dev/null 2>&1
fi

if [ -d /opt/droidcam-1.7.2 ]; then
  cd /opt/droidcam-1.7.2 && ./install-video >/dev/null 2>&1
fi

if [ -d /opt/droidcam-1.7.2 ]; then
  cd /opt/droidcam-1.7.2 && ./install-sound >/dev/null 2>&1
fi
