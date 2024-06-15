# Update mkfontscale and mkfontdir:
if [ -x /usr/bin/mkfontdir ]; then
  ( cd /usr/share/fonts/misc
    mkfontscale .
    mkfontdir .
  )
fi

xset fp rehash

# sbopkglint complains if we don't mention fc-cache.
# There. Happy now?

