#!/bin/bash

# Move to the QCAD directory
cd /opt/qcad

# Set the library path safely and export it
export LD_LIBRARY_PATH="${LD_LIBRARY_PATH:+$LD_LIBRARY_PATH:}/opt/qcad:/opt/qcad/plugins:/usr/share/qcad"

# Launch the application and replace the shell process
exec /opt/qcad/qcad-bin "$@"