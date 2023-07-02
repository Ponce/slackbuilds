for theme_dir in usr/share/icons/Tela usr/share/icons/Tela-dark; do
  if [ -e $theme_dir/icon-theme.cache ]; then
    if [ -x /usr/bin/gtk-update-icon-cache ]; then
      /usr/bin/gtk-update-icon-cache -f $theme_dir >/dev/null 2>&1
    fi
  fi
done
