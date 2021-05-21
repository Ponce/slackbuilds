if [ -x /usr/bin/update-desktop-database ]; then
  /usr/bin/update-desktop-database -q usr/share/applications >/dev/null 2>&1
fi

if [ -x /usr/bin/update-mime-database ]; then
  /usr/bin/update-mime-database usr/share/mime >/dev/null 2>&1
fi

if [ -e usr/share/icons/hicolor/icon-theme.cache ]; then
  if [ -x /usr/bin/gtk-update-icon-cache ]; then
    /usr/bin/gtk-update-icon-cache -f usr/share/icons/hicolor >/dev/null 2>&1
  fi
fi

if [ -e /usr/bin/tauonmb ]; then
    chmod +x /usr/bin/tauonmb
fi

if [ -e /opt/tauon-music-box/tauonmb.sh ]; then
    chmod +x /opt/tauon-music-box/tauonmb.sh
fi

if [ -e /opt/tauon-music-box/compile-phazor.sh ]; then
    (
    cd /opt/tauon-music-box/
    chmod +x compile-phazor.sh
    ./compile-phazor.sh
    )
fi
