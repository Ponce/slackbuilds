if ! grep "(nchexedit)" usr/info/dir 1>/dev/null 2>/dev/null; then
  cat << EOF >> usr/info/dir

Miscellaneous
* NCurses Hexedit:  (nchexedit).  Full screen curses Hex editor
EOF
fi
