# 20241213 bkw: this is both doinst.sh and douninst.sh for quivira-font.

# Update fonts.{dir,scale,alias}
if [ -x /usr/bin/mkfontdir -a -x /usr/bin/mkfontscale ]; then
    ( cd usr/share/fonts/OTF
      /usr/bin/mkfontscale .
      /usr/bin/mkfontdir .
    )
fi

# If X is running...
if [ "$DISPLAY" != "" ] && [ -x /usr/bin/xset ]; then
  /usr/bin/xset fp rehash >/dev/null 2>&1
fi

# Update the X font indexes:
if [ -x /usr/bin/fc-cache ]; then
  /usr/bin/fc-cache -f
fi
