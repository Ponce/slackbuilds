if [ ! -e var/log/jmri/messages.log ]; then
  mv var/log/jmri/messages.log.new var/log/jmri/messages.log
else
  rm -f var/log/jmri/messages.log.new
fi

