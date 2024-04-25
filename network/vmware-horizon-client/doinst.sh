if [ -x /usr/bin/update-desktop-database ]; then
  /usr/bin/update-desktop-database -q usr/share/applications >/dev/null 2>&1
fi

if ! /etc/init.d/ftscanhv start > /dev/null 2>&1; then
    echo "Warning: The daemon for Scanner redirection fails to start!"
fi
if ! /etc/init.d/ftsprhv start > /dev/null 2>&1; then
    echo "Warning: The daemon for SerialPort redirection fails to start!"
fi

if [ -x /usr/lib64/vmware/view/integratedPrinting/integrated-printing-setup.sh ]; then
	/usr/lib64/vmware/view/integratedPrinting/integrated-printing-setup.sh -i || true
fi

if ! /etc/init.d/vmware-USBArbitrator start; then
    echo "Warning: The daemon for USB redirection fails to start!"
fi

python3 /usr/lib64/vmware/view/urlRedirection/install-url-redirection.py -i || true

sed -i '1i127.0.0.1 view-localhost' /etc/hosts

if ! udevadm control --reload-rules || ! udevadm trigger; then
    echo "Warning: Error reloading udev HID rules, failed to configure HID devices!"
fi
