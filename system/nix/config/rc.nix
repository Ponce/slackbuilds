#!/bin/sh

# Short-Description:  Create lightweight, portable, self-sufficient containers.
# Description:
#  Docker is an open-source project to easily create lightweight, portable,
#  self-sufficient containers from any application. The same container that a
#  developer builds and tests on a laptop can run at scale, in production, on
#  VMs, bare metal, OpenStack clusters, public clouds and more.


PATH=/sbin:/bin:/usr/sbin:/usr/bin:/usr/local/sbin:/usr/local/bin

BASE=nix-daemon

UNSHARE=/usr/bin/unshare
NIX=/usr/bin/$BASE
NIX_PIDFILE=/var/run/$BASE.pid
NIX_LOG=/var/log/nix.log
NIX_OPTS=

if [ -f /etc/default/$BASE ]; then
	. /etc/default/$BASE
fi

# Check nix is present
if [ ! -x $NIX ]; then
	echo "$NIX not present or not executable"
	exit 1
fi

nix_start() {
  echo "starting $BASE ..."
  if [ -x ${NIX} ]; then
    # If there is an old PID file (no nix-daemon running), clean it up:
    if [ -r ${NIX_PIDFILE} ]; then
      if ! ps axc | grep nix-daemon 1> /dev/null 2> /dev/null ; then
        echo "Cleaning up old ${NIX_PIDFILE}."
        rm -f ${NIX_PIDFILE}
      fi
    fi
    nohup "${UNSHARE}" -m -- ${NIX} >> ${NIX_LOG} 2>&1 &
    echo $! > ${NIX_PIDFILE}
  fi
}

# Stop nix:
nix_stop() {
  echo "stopping $BASE ..."
  # If there is no PID file, ignore this request...
  if [ -r ${NIX_PIDFILE} ]; then
    kill $(cat ${NIX_PIDFILE})
  fi
  rm -f ${NIX_PIDFILE}
}

# Restart docker:
nix_restart() {
	nix_stop
	nix_start
}

case "$1" in
'start')
  nix_start
  ;;
'stop')
  nix_stop
  ;;
'restart')
  nix_restart
  ;;
'status')
  if [ -f ${NIX_PIDFILE} ] && ps -o cmd $(cat ${NIX_PIDFILE}) | grep -q $BASE ; then
	  echo "status of $BASE: running"
  else
	  echo "status of $BASE: stopped"
  fi
  ;;
*)
  echo "usage $0 start|stop|restart|status"
esac

exit 0
