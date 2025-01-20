# if gksu and gksudo exist as broken symlinks, that means we just
# uninstalled the gnsu package, and gksu isn't installed. removepkg
# doesn't remove these symlinks, so we do it in post.

[ ! -e /usr/bin/gksu -a -h /usr/bin/gksu ] && rm -f /usr/bin/gksu
[ ! -e /usr/bin/gksudo -a -h /usr/bin/gksudo ] && rm -f /usr/bin/gksudo
