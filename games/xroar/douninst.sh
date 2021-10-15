# 20211015 bkw: I was going to have a douninst.sh that runs
# /usr/bin/install-info --delete /usr/info/xroar.info.gz /usr/info/dir
# but this won't work because removepkg has already deleted
# /usr/info/xroar.info.gz before it runs douninst.sh. And you can't
# use install-info to remove stuff *by name* from /usr/info/dir;
# the info file must actually exist.
# So the script has to manually remove the entry from the info dir,
# and the Emulators section if it's become empty.

if [ -e usr/info/dir ]; then
  # Remove the entry first:
  sed -i '/^\* XRoar:/d' usr/info/dir
  # If the Emulators section is empty now, remove it too:
  if grep -A1 '^Emulators$' usr/info/dir | tail -1 | grep -q '^$'; then
    sed -i '/^Emulators$/,+1d' usr/info/dir
  fi
fi
