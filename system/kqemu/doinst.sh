#!/bin/sh

if [ -x sbin/depmod ]; then
  chroot . /sbin/depmod -a 1> /dev/null 2> /dev/null
fi

# Create the kqemu device. No special priviledge is needed to use kqemu.
device="dev/kqemu"
rm -f $device
mknod $device c 250 0
chmod 666 $device
