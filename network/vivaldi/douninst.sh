# Remove any lib fetched by update-ffmpeg, when doinst.sh was first run
if ls /var/opt/vivaldi/media-codecs-*/libffmpeg.so >/dev/null 2>&1; then
  rm /var/opt/vivaldi/media-codecs-*/libffmpeg.so
fi
if [ -d /var/opt/vivaldi ]; then
  # This removes directory trees that are empty or only populated by other
  # empty directories.
  find /var/opt/vivaldi -depth -type d -empty -exec rmdir {} \;
fi
