#!/bin/sh

nodevs=$(< /proc/filesystems awk '$1 == "nodev" && $2 != "rootfs" && $2 != "zfs" { print $2 }')
/usr/bin/updatedb -f "$nodevs"
