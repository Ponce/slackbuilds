# we're (possibly) removing a VLC plugin, avoid "error: stale plugins
# cache" when running vlc.

if [ -x ./usr/lib64/vlc/vlc-cache-gen ]; then
  ./usr/lib64/vlc/vlc-cache-gen ./usr/lib64/vlc/
fi

if [ -x ./usr/lib/vlc/vlc-cache-gen ]; then
  ./usr/lib/vlc/vlc-cache-gen ./usr/lib/vlc/
fi
