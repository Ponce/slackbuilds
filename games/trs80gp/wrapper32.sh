#!/bin/sh

# dirty hack alert! use old cairo libs for trs80gp.
L=/usr/lib/trs80gp/libcairo
V=2.11400.6

LD_PRELOAD=$L.so.$V:$L-gobject.so.$V:$L-script-interpreter.so.$V \
  exec /usr/libexec/trs80gp/trs80gp "$@"
