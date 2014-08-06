# If there's no lha, take over:
if [ ! -r usr/bin/lha ]; then
  ( cd usr/bin ; ln -sf lhasa lha )
  ( cd usr/man/man1 ; ln -sf lhasa.1.gz lha.1.gz )
fi
