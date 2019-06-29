chroot . /usr/bin/mktexlsr 1>/dev/null 2>/dev/null
printf "y\n" | chroot . /usr/bin/updmap-sys --syncwithtrees 1>/dev/null 2>/dev/null
cp usr/share/texmf-dist/web2c/updmap.cfg.extra usr/share/texmf-dist/web2c/updmap.cfg.extra.tmp
chroot . /usr/bin/updmap-sys --cnffile /usr/share/texmf-dist/web2c/updmap.cfg --cnffile /usr/share/texmf-dist/web2c/updmap.cfg.extra 1>/dev/null 2>/dev/null
mv usr/share/texmf-dist/web2c/updmap.cfg.extra.tmp usr/share/texmf-dist/web2c/updmap.cfg.extra
