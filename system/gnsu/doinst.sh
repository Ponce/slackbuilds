# based on Slackware's doinst.sh for vim.

# If gksu isn't installed, we create symlinks so gnsu acts as a
# replacement for gksu and gksudo.
if [ ! -r usr/bin/gksu ]; then
  ( cd usr/bin ; ln -sf gnsu gksu )
  ( cd usr/bin ; ln -sf gnsu gksudo )
fi

# rest is standard desktop/icon stuff.
if [ -x /usr/bin/update-desktop-database ]; then
  /usr/bin/update-desktop-database -q usr/share/applications >/dev/null 2>&1
fi

if [ -e usr/share/icons/hicolor/icon-theme.cache ]; then
  if [ -x /usr/bin/gtk-update-icon-cache ]; then
    /usr/bin/gtk-update-icon-cache -f usr/share/icons/hicolor >/dev/null 2>&1
  fi
fi
