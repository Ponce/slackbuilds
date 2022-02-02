#!/bin/sh
# Starts the CDEmu daemon instance on D-Bus *session* bus. Optional
# configuration (number of devices, audio driver, log file) are read
# from ~/.cdemu-daemon

# Default settings
NUM_DEVICES=1
AUDIO_DRIVER=default
LOG_FILE=~/.cdemu-daemon.log

# Read the settings
CONFIG_FILE=~/.cdemu-daemon

if [ -f ${CONFIG_FILE} ]; then
    . ${CONFIG_FILE};
fi

# Start the daemon
exec cdemu-daemon --ctl-device=/dev/vhba_ctl --bus=session --num-devices=${NUM_DEVICES} --audio-driver=${AUDIO_DRIVER} --logfile=${LOG_FILE}
