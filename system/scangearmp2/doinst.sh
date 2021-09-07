# reload udev rules
if [ -x /sbin/udevadm ]; then
	/sbin/udevadm control --reload-rules 2> /dev/null
	/sbin/udevadm trigger --action=add --subsystem-match=usb 2> /dev/null
fi
