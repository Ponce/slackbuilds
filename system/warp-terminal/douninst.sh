DEST="/bin/warp-terminal"

if [ -L ${DEST} ]; then
  /usr/bin/rm -f ${DEST}
fi
