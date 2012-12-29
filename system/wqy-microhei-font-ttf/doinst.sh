# There's no need to chroot and do this during initial
# install, since there is a post-install script that
# does the same thing, saving time.
# Update X font indexes and the font cache:
if [ -x /usr/bin/mkfontdir ]; then
  /usr/bin/mkfontscale /usr/share/fonts/TTF
  /usr/bin/mkfontdir /usr/share/fonts/TTF
fi
if [ -x /usr/bin/fc-cache ]; then
  /usr/bin/fc-cache /usr/share/fonts/TTF
fi
