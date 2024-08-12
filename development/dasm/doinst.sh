if [ -x usr/bin/mandb ]; then
  usr/bin/mandb -f /usr/man/man1/dasm.1.gz &> /dev/null
  usr/bin/mandb -f /usr/man/man1/ftohex.1.gz &> /dev/null
fi
