if [ -x /usr/bin/update-desktop-database ]; then
  ./usr/bin/update-desktop-database -q usr/share/applications
fi

/usr/sbin/nvidia-switch --install
