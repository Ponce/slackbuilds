#!/bin/sh


typeset -i USED=0
typeset -i AVAIL=0
typeset -i FREE=0
typeset -i CACHED=0
_mem() {
	case "${OS}" in
		'OpenBSD')
			TOP_OUT=$(top -b -1 -d 1 |egrep ^Memory:)
			USED=$(echo ${TOP_OUT} |cut -d' ' -f3 |cut -d/ -f1 |tr -d M)
			AVAIL=$(echo ${TOP_OUT} |cut -d' ' -f3 |cut -d/ -f2 |tr -d M)
			FREE=$(echo ${TOP_OUT} |cut -d' ' -f6 |tr -d M)
			CACHED=$(echo ${TOP_OUT} |cut -d' ' -f8 |tr -d M)
		;;
		'Linux')
			FREE_OUT=$(free -m |egrep ^Mem: |tr -s ' ')
			USED=$(echo ${FREE_OUT} |cut -d' ' -f3)
			AVAIL=$(echo ${FREE_OUT} |cut -d' ' -f2)
			FREE=$(echo ${FREE_OUT} |cut -d' ' -f4)
			CACHED=$(echo ${FREE_OUT} |cut -d' ' -f7)
		;;
	esac

	MEM_OUTPUT="U: ${USED}/${AVAIL} C: ${CACHED} - ${FREE}"
}

typeset -i USER=0
typeset -i NICE=0
typeset -i SYS=0
typeset -i IO=0
typeset -i IDLE=0
_cpu() {
	case "${OS}" in
		'OpenBSD')
			TOP_OUT=$(top -b -1 -s 1 -d 2 |egrep '^All CPUs' |tail -n1 |tr -d '[a-z %]' |cut -d: -f2-)
			NICE=$(echo ${TOP_OUT} |cut -d, -f2 |cut -d. -f1)
			SYS=$(echo ${TOP_OUT} |cut -d, -f3 |cut -d. -f1)
			IO=$(echo ${TOP_OUT} |cut -d, -f4 |cut -d. -f1)
			IDLE=$(echo ${TOP_OUT} |cut -d, -f5 |cut -d. -f1)
			USER=$(echo ${TOP_OUT} |cut -d, -f1 |cut -d. -f1)
		;;
		'Linux')
			# using top(1)
			TOP_OUT=$(top -b -d 0.1 -n 2 |egrep ^Cpu |tail -n1 |tr -d '%usynidwaht ' |cut -d: -f2-)
			NICE=$(echo ${TOP_OUT} |cut -d, -f3 |cut -d. -f1)
			SYS=$(echo ${TOP_OUT} |cut -d, -f2 |cut -d. -f1)
			IO=$(echo ${TOP_OUT} |cut -d, -f5 |cut -d. -f1)
			IDLE=$(echo ${TOP_OUT} |cut -d, -f4 |cut -d. -f1)
			USER=$(echo ${TOP_OUT} |cut -d, -f1 |cut -d. -f1)

			# using iostat(1)
			#IOSTAT_OUT=$(iostat -c 1 2 |tail -n2 |head -n1 |tr -s ' ' |tr ' ' '|')
			#NICE=$(echo ${IOSTAT_OUT} |cut -d\| -f3 |cut -d, -f1)
			#SYS=$(echo ${IOSTAT_OUT} |cut -d\| -f4 |cut -d, -f1)
			#IO=$(echo ${IOSTAT_OUT} |cut -d\| -f5 |cut -d, -f1)
			#IDLE=$(echo ${IOSTAT_OUT} |cut -d\| -f7 |cut -d, -f1)
			#USER=$(echo ${IOSTAT_OUT} |cut -d\| -f2 |cut -d, -f1)
		;;
	esac

	CPU_OUTPUT="U: ${USER} S: ${SYS} N: ${NICE} I: ${IO} - ${IDLE}"
}

_xkb_layout() {
	# this won't work with "XkbLayout" "us,hu" like setups:
	CURRENT_LAYOUT=$(setxkbmap -query |awk '/^layout:/ {print $2}')

	# ... but if you have skb(1)
	#CURRENT_LAYOUT=$(skb -1)

	XKB_LAYOUT_OUTPUT="[${CURRENT_LAYOUT}]"
}

_battery() {
	BAT_OUTPUT=$(battery_status.sh)
}

_wifi() {
	WIFI_OUTPUT=$(wifi_link_quality.sh)
}


OS=$(uname -s)
CPU_OUTPUT=''
MEM_OUTPUT=''
XKB_LAYOUT_OUTPUT=''
WIFI_OUTPUT=''
BAT_OUTPUT=''
while :;do
	_cpu; echo -n "${CPU_OUTPUT}   "
	_mem; echo -n "${MEM_OUTPUT} "
	_xkb_layout; echo -n "${XKB_LAYOUT_OUTPUT} "
	_wifi; echo -n "${WIFI_OUTPUT} "
	_battery; echo -n "${BAT_OUTPUT} "
	echo
done
