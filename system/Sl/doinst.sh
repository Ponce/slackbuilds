# If there's no sl link, take over:
if [ ! -r usr/games/sl ]; then
  ( cd usr/bin ; rm -rf sl )
  ( cd usr/bin ; ln -sf Sl sl )
  ( cd usr/man/man1 ; rm -rf sl.1.gz )
  ( cd usr/man/man1 ; ln -sf Sl.1.gz sl.1.gz )
fi

