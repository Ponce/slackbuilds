# Don't clobber an existing /var/games/phalanx/learn.phalanx
if [ ! -r var/games/phalanx/learn.phalanx ]; then
  mv var/games/phalanx/learn.phalanx.new var/games/phalanx/learn.phalanx
else
  rm -f var/games/phalanx/learn.phalanx.new
fi

