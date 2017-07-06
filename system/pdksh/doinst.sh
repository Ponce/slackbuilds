# Add entries to /etc/shells if we need them
if [ ! -r etc/shells ] ; then
   touch etc/shells
   chmod 644 etc/shells
fi
 
if ! grep -Fqs "/bin/pdksh" etc/shells ; then
   echo "/bin/pdksh" >> etc/shells
fi

