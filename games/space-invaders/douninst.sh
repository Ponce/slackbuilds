# We remove the binaries, but leave the TopScore and the game fptions in each user
for user in $(ls -1 /home)
do
    rm -rf /home/$user/.local/bin/space-invaders/Content
    rm -rf /home/$user/.local/bin/space-invaders/SpaceInvaders
    rm -rf /home/$user/.local/bin/space-invaders/SpaceInvaders.pdb
    rm -rf /home/$user/.local/bin/space-invaders/libSDL2-2.0.so.0
    rm -rf /home/$user/.local/bin/space-invaders/libopenal.so.1
done
