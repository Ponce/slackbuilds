if ! grep "(flite)" usr/info/dir 1>/dev/null 2>/dev/null; then
  cat << EOF >> usr/info/dir

Miscellaneous
* FLITE:  (flite).                Flite, a small, fast speech synthesis engine.
EOF
fi
