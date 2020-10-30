if VIMP=$(grep -rwl '/var/log/packages/' -e 'usr/bin/xxd' \
    | grep -o -m 1 "vim-.*"); then
  echo "WARNING: It seems that you installed xxd-standalone"
  echo "         simultaneously with ${VIMP},"
  echo "         which provides xxd. If you remove vim,"
  echo "         you may need to reinstall xxd-standalone."
  echo "    	 Conversely, if you remove xxd-standalone,"
  echo "       	 you'll need to reinstall vim."
  sleep 5
fi
