#!/bin/bash

# Generate udev rules files 
usr/bin/print-camera-list udev-rules mode 0660 group plugdev \
  >> etc/udev/rules.d/90-libgphoto2.rules

# Install hal device information files
usr/bin/print-camera-list hal-fdi \
  > usr/share/hal/fdi/information/20thirdparty/10-camera-libgphoto2.fdi
usr/bin/print-camera-list hal-fdi-device \
  > usr/share/hal/fdi/information/20thirdparty/10-camera-libgphoto2-device.fdi

