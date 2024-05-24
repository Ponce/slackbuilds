if [ -x /etc/rc.d/rc.cups ]; then
  /etc/rc.d/rc.cups stop
  /etc/rc.d/rc.cups start
fi
