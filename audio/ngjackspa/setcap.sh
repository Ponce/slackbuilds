if [ -x /sbin/setcap ]; then
	for setcapfile in gjackspa jackspa-cli njackspa qjackspa; do
		[ -e usr/bin/$setcapfile ] && /sbin/setcap cap_ipc_lock,cap_sys_nice=ep usr/bin/$setcapfile
	done
fi
