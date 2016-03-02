#!/bin/sh
cd /usr/share/qcad
LD_LIBRARY_PATH=${LD_LIBRARY_PATH:+$LD_LIBRARY_PATH:}"/usr/share/qcad" exec /usr/share/qcad/qcad-bin "$@"
