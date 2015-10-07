# `mount -t extfs` looks in /sbin
( cd sbin ; rm -rf mount.exfat )
( cd sbin ; ln -sf /usr/sbin/mount.exfat mount.exfat )
