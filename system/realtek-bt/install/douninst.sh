#!/bin/bash
DRV_DIR=/lib/modules/$(uname -r)/kernel/drivers/bluetooth

mv -n $DRV_DIR/btusb_bak $DRV_DIR/btusb.ko
if lsmod | grep "^rtk_btusb " -q; then
  rmmod rtk_btusb
fi
depmod -a $(uname -r)
echo "Driver uninstalled, please reboot your system."
