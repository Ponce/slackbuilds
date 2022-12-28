# we're installing a VLC plugin, avoid "error: stale plugins cache"
# when running vlc.

if [ -x ./usr/lib64/vlc/vlc-cache-gen -a -x usr/lib64/vlc/plugins/demux/libasap_plugin.so ]; then
  ./usr/lib64/vlc/vlc-cache-gen ./usr/lib64/vlc/
fi

if [ -x ./usr/lib/vlc/vlc-cache-gen -a -x usr/lib/vlc/plugins/demux/libasap_plugin.so ]; then
  ./usr/lib/vlc/vlc-cache-gen ./usr/lib/vlc/
fi
