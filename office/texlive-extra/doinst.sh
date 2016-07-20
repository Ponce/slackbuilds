rm -f usr/share/texmf-config/web2c/updmap.cfg
chroot . /usr/bin/mktexlsr 1>/dev/null 2>/dev/null
printf "y\n" | chroot . /usr/bin/updmap-sys --nohash --syncwithtrees 1>/dev/null 2>/dev/null
chroot . /usr/bin/updmap-sys 1>/dev/null 2>/dev/null
chroot . /usr/bin/fmtutil-sys --all 1>/dev/null 2>/dev/null
