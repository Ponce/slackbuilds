#!/bin/sh
# Adaptation of Marcel Saegebarth's rc.psd script for slackbuilds.org.

description="Directories syncing"
extra_commands="resync"
description_resync="Manually sync the directories with running tmpfs image"

start() {
  echo "Starting Anything-Sync-Daemon"
  /usr/bin/anything-sync-daemon sync
}

stop() {
  echo "Stopping Anything-Sync-Daemon"
  /usr/bin/anything-sync-daemon unsync
}

status() {
  /usr/bin/anything-sync-daemon debug
}

resync() {
  echo "Syncing directories in tmpfs to physical disc"
  /usr/bin/anything-sync-daemon resync
}

case "$1" in
  start)
    start ;;
  stop)
    stop ;;
  resync)
    resync ;;
  status)
    status ;;
  *)
    echo $"Usage: $0 {start|stop|resync|status}"
    exit 1
esac
