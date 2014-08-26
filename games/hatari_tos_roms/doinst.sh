# If there's no tos.img symlink, take over with "rainbow TOS"
if [ ! -r usr/share/hatari/tos.img ]; then
  ( cd usr/share/hatari ; ln -sf tos-1.04-uk.img tos.img )
fi
