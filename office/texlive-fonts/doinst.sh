chroot . /usr/bin/mktexlsr 1>/dev/null 2>/dev/null
printf "y\n" | chroot . /usr/bin/updmap-sys --syncwithtrees 1>/dev/null 2>/dev/null
