if ! grep "(gnulib)" usr/info/dir 1>/dev/null 2>/dev/null; then
  cat << EOF >> usr/info/dir

Miscellaneous
* Gnulib:  (gnulib).            The GNU Portability Library.
EOF
fi
