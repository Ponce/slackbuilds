# since our info file ends up in the 'Miscellaneous' section, we won't
# worry about removing the section if it's empty (because it won't be,
# because various Slackware packages use the same section).

if [ -e usr/info/dir ]; then
  sed -i '/^\* Liquid War 6:/d' usr/info/dir
fi
