if [ ! -r etc/httpd/extra/mod_perl.conf ]; then
  cat etc/httpd/extra/mod_perl.conf.example > etc/httpd/extra/mod_perl.conf
elif [ "$(cat etc/httpd/extra/mod_perl.conf 2> /dev/null)" = "" ]; then
  cat etc/httpd/extra/mod_perl.conf.example > etc/httpd/extra/mod_perl.conf
fi

