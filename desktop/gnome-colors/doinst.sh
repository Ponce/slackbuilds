for theme in brave carbonite colors-common dust human illustrious noble tribute wine wise ; do
  if [ -e usr/share/icons/gnome-$theme/icon-theme.cache ]; then
    if [ -x /usr/bin/gtk-update-icon-cache ]; then
      /usr/bin/gtk-update-icon-cache usr/share/icons/gnome-$theme >/dev/null 2>&1
    fi
  fi
done
