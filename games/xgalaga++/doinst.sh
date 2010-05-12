if [ ! -e var/games/xgalaga++/xgalaga++.scores ]; then
  mv var/games/xgalaga++/xgalaga++.scores.new var/games/xgalaga++/xgalaga++.scores
fi
rm -f var/games/xgalaga++/xgalaga++.scores.new

