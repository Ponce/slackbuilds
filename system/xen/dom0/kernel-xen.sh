#!/bin/sh

# Xem dom0 kernel installation script

# Written by Chris Abela <chris.abela@maltats.com>, 20100515
# Updated by mario <mario@slackverse.org>, 2010-2011

KERNEL=${KERNEL:-huge}
VERSION=${VERSION:-2.6.34.7}

# Rebased patches version
SVERSION=${SVERSION:-2.6.34-6}

# Xen version
XVERSION=${XVERSION:-4.1.1}

BOOTLOADER=${BOOTLOADER:-lilo}

# Automatically determine the architecture we're building on:
if [ -z "$ARCH" ]; then
  case "$( uname -m )" in
    i?86) ARCH=i486 ;;
    x86_64) ARCH=x86_64 ;;
    # Bail out on everything else:
       *) echo "Unsupported architecture detected ($ARCH)"; exit ;;
  esac
fi

CWD=$(pwd)
XEN=${XEN:-/tmp/xen}
PATCH=${PATCH:-/tmp/xen/patch-$VERSION}
MODINST=${MODINST:-/tmp/xen/modules}

set -e

rm -rf $XEN
mkdir -p $PATCH $MODINST
cd $PATCH
tar -xvf $CWD/xen-patches-$SVERSION.tar.bz2

if [ ! -d /usr/src/linux-$VERSION ]; then
  echo "Missing kernel source in /usr/src/linux-$VERSION"
  echo "Get it from kernel.org and rerun this script."
  exit
fi

# Prepare kernel source
cd /usr/src
rm -rf linux-$VERSION-xen xenlinux
cp -a linux-$VERSION linux-$VERSION-xen
ln -s linux-$VERSION-xen xenlinux

cd linux-$VERSION-xen
make clean
for i in $PATCH/* ; do
  echo Patching $i
  patch -p1 -s < $i
done

# Copy the right config
cat $CWD/config-${KERNEL}-${ARCH}-${VERSION}-xen > .config

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

make vmlinux modules
make modules_install INSTALL_MOD_PATH=$MODINST

# We already have these
rm -rf $MODINST/lib/firmware

# Strip kernel symbols
strip vmlinux -o vmlinux-stripped

# For lilo we pack kernel up with mbootpack
if [ "$BOOTLOADER" = lilo ]; then
  gzip -d -c /boot/xen-${XVERSION}.gz > xen-${XVERSION}
  mbootpack -o vmlinux-stripped-mboot -m vmlinux-stripped xen-${XVERSION}
  gzip vmlinux-stripped-mboot -c > vmlinuz
elif [ "$BOOTLOADER" = grub ]; then
  gzip vmlinux-stripped -c > vmlinuz
fi

install -D -m 644 vmlinuz /boot/vmlinuz-$KERNEL-$VERSION-xen
install -m 644 System.map /boot/System.map-$KERNEL-$VERSION-xen
install -m 644 .config /boot/config-$KERNEL-$VERSION-xen

cd /boot
ln -s vmlinuz-$KERNEL-$VERSION-xen vmlinuz-xen
ln -s System.map-$KERNEL-$VERSION-xen System.map-xen
ln -s config-$KERNEL-$VERSION-xen config-xen

cp -a $MODINST/lib/modules/$VERSION-xen /lib/modules

cd /usr/src/linux-$VERSION-xen
make clean
