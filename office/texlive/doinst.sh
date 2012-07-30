# This one shouldn't be needed, but just in case...
chroot . /usr/bin/mktexlsr 1>/dev/null 2>/dev/null

# This is to generate /usr/share/texmf-var/ stuff
chroot . /usr/bin/updmap-sys --nohash --syncwithtrees 1>/dev/null 2>/dev/null
chroot . /usr/bin/mktexlsr 1>/dev/null 2>/dev/null
chroot . /usr/bin/fmtutil-sys --all 1>/dev/null 2>/dev/null

