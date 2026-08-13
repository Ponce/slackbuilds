# There's no need to chroot and do this during initial
# install, since there is a post-install script that
# does the same thing, saving time.
# Update X font indexes and the font cache:

#!/bin/sh

# Update the X font indexes:

if [ -x /usr/bin/mkfontdir ]; then
  ( cd /usr/share/fonts/TTF
    mkfontscale .
    mkfontdir .
  )
fi

if [ -x /usr/bin/mkfontdir ]; then
  ( cd /usr/share/fonts/OTF
    mkfontscale .
    mkfontdir .
  )
fi

[ "$DISPLAY" != "" ] && xset fp rehash 2>/dev/null

if [ -x /usr/bin/fc-cache ]; then
  /usr/bin/fc-cache -f
fi
fi
