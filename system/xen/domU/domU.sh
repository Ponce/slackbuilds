#!/bin/sh
# This Script builds a Slackware domU Xen Guest on a Slackware host,
# Although it might work correctly, this script is intended as a template, so
# simplicity is the priority here.
# Written by Chris Abela <chris.abela@maltats.com>, 20100308
# Modified by Mario Preksavec <mario@slackware.hr>

set -e

KERNEL=${KERNEL:-4.4.240}

# Build an image for the root file system and another for the swap
# Default values : 8GB and 500MB resepectively.
ROOT_MB=${ROOT_MB:-8000}
SWAP_MB=${SWAP_MB:-500}
dd if=/dev/zero of=slackware.img bs=1M count=0 seek=$ROOT_MB
mkfs.ext4 -F slackware.img
dd if=/dev/zero of=swap_file bs=1M count=0 seek=$SWAP_MB
mkswap swap_file

# Make a mountpoint for the root file system and mount it
mkdir -p mnt
mount -o loop slackware.img mnt

# Make a mountpoint for proc and mount it
mkdir -p mnt/proc
mount --bind /proc mnt/proc

##############################################################################
#									     #
# IMPORTANT : This assumes that you have mounted your Slackware DVD on	     #
#		/media/SlackDVD						     #
#									     #
##############################################################################

# This will install a domU with the listed packages
for i in a ap d e f k l n t tcl; do
  installpkg --root mnt/ /media/SlackDVD/slackware*/$i/*.t?z
done
chroot mnt /sbin/ldconfig

# create fstab
cat >mnt/etc/fstab <<EOF
/dev/xvda2       swap             swap        defaults         0   0
/dev/xvda1       /                ext4        defaults         1   1
#/dev/cdrom      /mnt/cdrom       auto        noauto,owner,ro  0   0
/dev/fd0         /mnt/floppy      auto        noauto,owner     0   0
devpts           /dev/pts         devpts      gid=5,mode=620   0   0
proc             /proc            proc        defaults         0   0
tmpfs            /dev/shm         tmpfs       defaults         0   0
EOF

chroot mnt /usr/sbin/timeconfig		# Set the time
chroot mnt /sbin/netconfig		# Set the network
chroot mnt /usr/bin/passwd		# Set root's password

# Before we could use xencons=tty and leave inittab and securetty files intact,
# but that stopped working as of Xen-4.x, so this has to be fixed by adding hvc0.
sed -i 's/^\(c[1-6]:123\)/#\1/' /etc/inittab
echo -e '\nc1:12345:respawn:/sbin/agetty 38400 hvc0 linux' >> /etc/inittab
echo -e '\nhvc0' >> /etc/securetty

# This will save us an alarming (yet harmless) warning
(cd mnt/lib/modules
  if [ -d $KERNEL-smp ]; then
    # for Slack32
    ln -s $KERNEL-smp $KERNEL-xen
    else
    # for Slack64
    ln -s $KERNEL $KERNEL-xen
  fi
)

# unmount proc and the filesystem
umount mnt/proc
umount mnt
