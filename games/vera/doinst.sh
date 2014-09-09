# the README says to use '* V.E.R.A.' at the start, but that causes
# the command 'info vera' to fail. Using '* VERA' works as expected.

if ! grep "(vera)" usr/info/dir 1>/dev/null 2>/dev/null; then
  cat << EOF >> usr/info/dir

Miscellaneous
* VERA:  (vera).                Virtual Entity of Relevant Acronyms
EOF
fi
