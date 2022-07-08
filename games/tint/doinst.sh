touch /var/games/tint.scores
chown root:games /var/games/tint.scores
chmod 0664 /var/games/tint.scores

if [ -x /usr/bin/update-desktop-database ]; then
  /usr/bin/update-desktop-database -q usr/share/applications >/dev/null 2>&1
fi
