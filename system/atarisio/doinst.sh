#!/bin/sh

chroot . /sbin/depmod -a

# Ensure that udevd knows what's up with the atarisio device(s)...
# Redirect stderr to /dev/null to avoid Slack 12.2 warning:
# Older (Slack 12.0/12.1) udevadm doesn't recognize the new form
# (--reload-rules is an error). For now, I want the package to
# work on at least 12.1 and 12.2.

if [ -x sbin/udevadm ]; then
	sbin/udevadm control --reload_rules 2>/dev/null
fi
