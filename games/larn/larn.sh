#!/bin/sh

# perform steps from larn_first_time_init.sh
if [ ! -d ~/.larn ]
then
    mkdir ~/.larn
    cp /usr/share/games/larn/data/larnforts     \
        /usr/share/games/larn/data/larnmazefile \
        ~/.larn/
fi

cd /usr/share/games/larn
exec /usr/share/games/larn/larn "$@"
