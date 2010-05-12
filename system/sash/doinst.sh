# Add sash to the shells if not there
if ! grep -q "/sash$" etc/shells ; then
  echo "/bin/sash" >> etc/shells
fi

