if [ -x usr/bin/gtk-update-icon-cache ]; then
  find usr/share/icons -maxdepth 1 -type d -exec \
    ./usr/bin/gtk-update-icon-cache -f -q {} \; &> /dev/null
fi
