#this sets the correct permisions for the chrome-sandbox
chown root:root /opt/firestorm-opensim/bin/chrome-sandbox
chmod 4755  /opt/firestorm-opensim/bin/chrome-sandbox

if [ -x /usr/bin/update-desktop-database ]; then
  /usr/bin/update-desktop-database 1> /dev/null &> /dev/null
fi
