if [ -x /usr/bin/update-desktop-database ]; then
  /usr/bin/update-desktop-database -q usr/share/applications >/dev/null 2>&1
fi

for i in en fr ; do
  if [ -d var/games/scrabble/$i ]; then
    if [ ! -e var/games/scrabble/$i/scrabble_scores ]; then
      mv var/games/scrabble/$i/scrabble_scores.new var/games/scrabble/$i/scrabble_scores
    else
      rm -f var/games/scrabble/$i/scrabble_scores.new
    fi
  fi
done

