#!/bin/bash
DRV_DIR=/lib/modules/@KERNEL@/kernel/drivers/bluetooth

if lsmod | grep "^btusb " -q; then
  rmmod btusb
fi
mv $DRV_DIR/btusb.ko $DRV_DIR/btusb_bak
if lsmod | grep "^rtk_btusb " -q; then
  rmmod rtk_btusb
fi
depmod -a @KERNEL@
echo "Driver installed, please reboot your system."
