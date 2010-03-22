# remove existing fdi cache to recognize newly installed fdi files
# and restart hal to regenerate the cache
rm -f var/cache/hald/fdi-cache
chroot . /etc/rc.d/rc.hald restart
