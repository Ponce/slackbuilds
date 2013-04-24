#!/bin/sh


wlan_int=wlan0

/sbin/ip link show dev ${wlan_int} >/dev/null 2>&1  ||  exit 1
/sbin/ip link show dev ${wlan_int} 2>&1 |fgrep -q -e"state DOWN"  &&  exit 1

LINK_QUALITY=$( /sbin/iwconfig "${wlan_int}" 2>&1 |fgrep -e'Link Quality' |tr -s ' ' |cut -d' ' -f3 |cut -d= -f2 )
echo "{${LINK_QUALITY}}"
