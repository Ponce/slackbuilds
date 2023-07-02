for theme_dir in usr/share/icons/Tela usr/share/icons/Tela-dark; do
  if [ -e $theme_dir/icon-theme.cache ]; then
    rm $theme_dir/icon-theme.cache
    rmdir $theme_dir
  fi
done
