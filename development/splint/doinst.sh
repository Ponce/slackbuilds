# If we do not have a lint already:
if ! command -v lint 1> /dev/null 2> /dev/null ; then
  # Make this the default
  ( cd /usr/bin ; ln -sf splint lint )
  ( cd /usr/man/man1 ; ln -sf splint.1.gz lint.1.gz )
fi

