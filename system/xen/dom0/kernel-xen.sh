#!/bin/sh

# Xem dom0 kernel installation script

# Written by Chris Abela <chris.abela@maltats.com>, 20100515
# Modified by Mario Preksavec <mario@slackware.hr>

KERNEL=${KERNEL:-4.4.240}
XEN=${XEN:-4.13.1}
BOOTLOADER=${BOOTLOADER:-lilo}

ROOTMOD=${ROOTMOD:-ext4}
ROOTFS=${ROOTFS:-ext4}
ROOTDEV=${ROOTDEV:-/dev/sda2}

if [ -z "$ARCH" ]; then
  case "$( uname -m )" in
      i?86) ARCH=i686 ;;
    x86_64) ARCH=x86_64 ;;
         *) echo "Unsupported architecture detected ($ARCH)"; exit ;;
  esac
fi

if [ "$BOOTLOADER" = lilo ] && [ ! -x /usr/bin/mbootpack ]; then
  echo "LILO bootloader requires mbootpack."
  echo "Get it from slackbuilds.org and rerun this script."
  exit
fi

if [ ! -d /usr/src/linux-$KERNEL ]; then
  echo "Missing kernel source in /usr/src/linux-$KERNEL"
  echo "Get it from kernel.org and rerun this script."
  exit
fi

CWD=$(pwd)
TMP=${TMP:-/tmp/xen}

set -e

rm -rf $TMP
mkdir -p $TMP

# Prepare kernel source
cd /usr/src
cp -a linux-$KERNEL linux-$KERNEL-xen
ln -s linux-$KERNEL-xen xenlinux

cd linux-$KERNEL-xen
make clean

# Copy the right config
cat $CWD/config-$KERNEL-xen.$ARCH > .config

# If the user wants, we will run menuconfig
if [ "$MENUCONFIG" = yes ]; then
  unset junk
  make menuconfig
  while [ "$junk" != N ]; do
    echo
    echo "Do you want to run"
    echo "# make menuconfig"
    echo -n "again? (Y/N) "
    read junk
    if [ "$junk" = Y ]; then
      make menuconfig
    fi
  done
fi

make bzImage modules
make modules_install INSTALL_MOD_PATH=$TMP

# Install modules
cp -a $TMP/lib/modules/$KERNEL-xen /lib/modules

# Create initrd
mkinitrd -c -k $KERNEL-xen -m $ROOTMOD -f $ROOTFS -r $ROOTDEV \
  -o /boot/initrd-$KERNEL-xen.gz

# For lilo we use mbootpack
if [ "$BOOTLOADER" = lilo ]; then
  gzip -d -c /boot/xen-$XEN.gz > xen-$XEN
  mbootpack -m arch/x86/boot/bzImage -m /boot/initrd-$KERNEL-xen.gz xen-$XEN \
    -o /boot/vmlinuz-$KERNEL-xen
else
  cp arch/x86/boot/bzImage /boot/vmlinuz-$KERNEL-xen
fi

cp System.map /boot/System.map-$KERNEL-xen
cp .config /boot/config-$KERNEL-xen

cd /boot
ln -s vmlinuz-$KERNEL-xen vmlinuz-xen
ln -s System.map-$KERNEL-xen System.map-xen
ln -s config-$KERNEL-xen config-xen
ln -s initrd-$KERNEL-xen.gz initrd-xen.gz

# Clean up kernel sources
cd /usr/src/linux-$KERNEL-xen
make clean
rm xen-$XEN
