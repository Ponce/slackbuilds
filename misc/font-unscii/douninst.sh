# Update fonts.{dir,scale,alias}
if [ -x /usr/bin/mkfontdir -a -x /usr/bin/mkfontscale ]; then
  for i in misc TTF OTF; do
    ( cd usr/share/fonts/$i
      /usr/bin/mkfontscale .
      /usr/bin/mkfontdir .
    )
  done
fi

# Remove aliases.
( cd usr/share/fonts/misc
  grep -v ^unscii- fonts.alias > fonts.alias.new
  mv fonts.alias.new fonts.alias
)

# If X is running...
if [ "$DISPLAY" != "" ] && [ -x /usr/bin/xset ]; then
  /usr/bin/xset fp rehash >/dev/null 2>&1
fi

# Update the X font indexes:
if [ -x /usr/bin/fc-cache ]; then
  /usr/bin/fc-cache -f
fi
