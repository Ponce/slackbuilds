# Update fonts.{dir,scale,alias}
if [ -x /usr/bin/mkfontdir -a -x /usr/bin/mkfontscale ]; then
  for i in misc TTF OTF; do
    ( cd usr/share/fonts/$i
      /usr/bin/mkfontscale .
      /usr/bin/mkfontdir .
    )
  done
fi

# Only include aliases for the bitmap fonts (e.g. xterm -fn unscii-16)
( cd usr/share/fonts/misc
  if ! grep -q ^unscii- fonts.alias; then
    cat <<EOF >> fonts.alias
unscii-16-full -unscii-unscii-medium-r-normal-full-16-160-75-75-c-80-iso10646-1
unscii-16 -unscii-unscii-medium-r-normal-16-16-160-75-75-c-80-iso10646-1
unscii-8-alt -unscii-unscii-medium-r-normal-alt-8-80-75-75-c-80-iso10646-1
unscii-8-fantasy -unscii-unscii-medium-r-normal-fantasy-8-80-75-75-c-80-iso10646-1
unscii-8-mcr -unscii-unscii-medium-r-normal-mcr-8-80-75-75-c-80-iso10646-1
unscii-8-tall -unscii-unscii-medium-r-normal-tall-16-160-75-75-c-80-iso10646-1
unscii-8-thin -unscii-unscii-medium-r-normal-thin-8-80-75-75-c-80-iso10646-1
unscii-8 -unscii-unscii-medium-r-normal-8-8-80-75-75-c-80-iso10646-1
EOF
  fi
)

# If X is running...
if [ "$DISPLAY" != "" ] && [ -x /usr/bin/xset ]; then
  /usr/bin/xset fp rehash >/dev/null 2>&1
fi

# Update the X font indexes:
if [ -x /usr/bin/fc-cache ]; then
  /usr/bin/fc-cache -f
fi
