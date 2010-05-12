#!/bin/sh

if [ -x sbin/depmod ]; then
	chroot . /sbin/depmod -a
fi

# Ensure that udevd knows what's up with the atarisio device(s)...
# If you're on Slack 12.1 or older, the --reload-rules needs to be
# replaced with --reload_rules below.

if [ -x sbin/udevadm ]; then
	sbin/udevadm control --reload-rules 2>/dev/null
fi
