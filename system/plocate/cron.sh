#!/bin/sh

nodevs=$(< /proc/filesystems awk '$1 == "nodev" && $2 != "rootfs" && $2 != "zfs" { print $2 }')
ionice -c3 nice -n 19 /usr/sbin/plocate-updatedb -f "$nodevs"
