#!/bin/bash
#
# This is wrapper for webhook. This script required only in order to properly
# start and stop this daemon, because webhook does not set pid file and unable
# to run as specific user.

ME=$0
BINARY=/usr/sbin/webhook
CONFIG=/etc/default/webhook

source "$CONFIG"
getent passwd ${USER} >/dev/null 2>&1

if [ $? != 0 ]; then
	echo "Create user '${USER}' before running ${ME}"
	exit 1
fi

if [ -z $URLPREFIX ]; then
	URLPREFIX=""
else
	URLPREFIX="-urlprefix=${URLPREFIX}"
fi

if [ ! -z $PIDFILE ]; then
	if [ ! -d "$(dirname ${PIDFILE})" ]; then
		mkdir -p "$(dirname ${PIDFILE})"
	fi

	echo "$$" >$PIDFILE
fi

OPTIONS="-hooks ${HOOKS} -ip ${IPADDR} -port ${PORT} ${URLPREFIX} ${OPTS}"
exec sudo -u $USER "${BINARY}" $OPTIONS

# vim: ft=sh noet ai ts=4 sw=4 sts=4:
