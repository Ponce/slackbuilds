#!/bin/sh


SCROT=$(which scrot)
[ -x "${SCROT}" ]  ||  exit 1

screenshot() {
	case $1 in
	full)
		"${SCROT}" --multidisp
		;;
	window)
		sleep 0.5
		"${SCROT}" --select
		;;
	*)
		;;
	esac;
}

screenshot $1
