if [ -x /usr/bin/install-info -a -d usr/info ]; then
   ( 
      cd usr/info
      rm -f dir
      for i in *.info*; do
         /usr/bin/install-info $i dir 1>/dev/null 2>&1
      done
   )
fi
