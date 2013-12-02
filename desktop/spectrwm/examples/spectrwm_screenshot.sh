#!/bin/sh


CAPTURE_TOOL=/usr/bin/import
if [ ! -x "${CAPTURE_TOOL}" ];then
	echo "$0: couldn't run ${CAPTURE_TOOL}" >&2
	exit 1
fi

CAPTURE_PATH="${HOME}/spectrwm_capture_$(date +%FT%T).png"

case "$1" in
	'full')
		"${CAPTURE_TOOL}" -window root png:"${CAPTURE_PATH}"
	;;
	'window')
		sleep 0.5
		"${CAPTURE_TOOL}" png:"${CAPTURE_PATH}"
	;;
	*)
		echo "$0: $0 <-full | -window>" >&2
	;;
esac
