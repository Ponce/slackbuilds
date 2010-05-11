#!/bin/sh

# Check to see if udev package is installed
if [ -e var/log/packages/udev-* ]; then
  # Get udev version
  UDEV_VERSION=$(basename var/log/packages/udev-* | cut -d- -f2)
  # Generate udev rules files 
  if [ "$UDEV_VERSION" -lt "098" ]; then
    usr/bin/print-camera-list udev-rules mode 0660 owner root group plugdev \
      >> etc/udev/rules.d/90-libgphoto2.rules
  elif [ "$UDEV_VERSION" -ge "098" ]; then
    usr/bin/print-camera-list udev-rules-0.98 mode 0660 owner root group plugdev \
      >> etc/udev/rules.d/90-libgphoto2.rules
  fi
fi

# Generate files for old hotplug support
if [ -e etc/hotplug/usb.usermap ]; then
  cat etc/hotplug/usb.usermap > etc/hotplug/usb.usermap.bak
  rm -rf tmp/.usermap
  grep -v usbcam etc/hotplug/usb.usermap > tmp/.usermap
  usr/bin/print-camera-list usb-usermap usbcam >> tmp/.usermap 
  cat tmp/.usermap > etc/hotplug/usb.usermap
  rm -f tmp/.usermap
else
  usr/bin/print-camera-list usb-usermap usbcam > etc/hotplug/usb.usermap
fi

# Check to see if hal is installed and generate fdi files
if [ -e var/log/packages/hal-[0-9]* ]; then
  usr/bin/print-camera-list hal-fdi \
    >> usr/share/hal/fdi/information/20thirdparty/10-camera-libgphoto2.fdi
  usr/bin/print-camera-list hal-fdi-device \
    >> usr/share/hal/fdi/information/20thirdparty/10-camera-libgphoto2-device.fdi
fi

