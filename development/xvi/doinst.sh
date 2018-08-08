# based on Slackware's doinst.sh for vim.

# If there's no vi link, take over:
if [ ! -r usr/bin/vi ]; then
  ( cd usr/bin ; ln -sf xvi vi )
fi
