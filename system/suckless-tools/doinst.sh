if [ ! -r usr/bin/lsx ]; then
  ( cd usr/man/man1 ; rm -rf lsx.1.gz )
  ( cd usr/man/man1 ; ln -sf lsX.1.gz lsx.1.gz )
  ( cd usr/bin ; rm -rf lsx )
  ( cd usr/bin ; ln -sf lsX lsx )
fi
