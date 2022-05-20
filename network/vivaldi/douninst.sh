# Remove any lib fetched by '/opt/vivaldi/update-ffmpeg' that was
# installed system-wide into '/var/opt'
rm -f /var/opt/vivaldi/media-codecs-*/libffmpeg.so
if [ -d /var/opt/vivaldi ]; then
  # This removes directory trees that are empty or only populated by other
  # empty directories.
  find /var/opt/vivaldi -depth -type d -empty -exec rmdir {} \;
  # '/var/opt' is not part of the default Slackware install, so we will
  # remove it, if it is now empty (following the above).
  rmdir --ignore-fail-on-non-empty /var/opt
fi
