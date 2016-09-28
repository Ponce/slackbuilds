if [ -d /etc/r2e ]; then
  cat << EOF > /etc/r2e/README.config
Starting version 2.71 to customize r2e please edit config.py in your
user directory ~/.rss2email

File /etc/r2e/config.py is not used anymore.  The directory /etc/r2e
can safely be removed.

See /usr/doc/config.py.example for a full list of available
configuration variables.
EOF
fi
