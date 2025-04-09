#!/bin/bash
cd /opt/balena-etcher || exit 1
LD_LIBRARY_PATH=/opt/balena-etcher:$LD_LIBRARY_PATH ./balena-etcher "$@"
