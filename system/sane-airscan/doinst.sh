#!/bin/sh
if [ -d /usr/lib64/sane ]; then
  cd /usr/lib64/sane
  ln -vsf libsane-airscan.so.1 libsane-airscan.so
else
  cd /usr/lib/sane
  ln -vsf libsane-airscan.so.1 libsane-airscan.so
fi
