chroot . /usr/bin/mktexlsr 1>/dev/null 2>/dev/null
chroot . /usr/bin/updmap-sys --nohash --syncwithtrees 1>/dev/null 2>/dev/null
chroot . /usr/bin/fmtutil-sys --all 1>/dev/null 2>/dev/null
