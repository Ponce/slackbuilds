# Use the magic mime file from Apache as the mime database
if [ -a /etc/httpd/magic ]; then
   ln -s /etc/httpd/magic /etc/magic.mime
else
   cat << EOF

   This extension requires a MIME database /etc/magic.mime.  You can
   symlink to the one included with Apache with the following command

   # ln -s /etc/httpd/magic /etc/magic.mime
EOF
fi

if ! grep ^extension=fileinfo.so /etc/httpd/php.ini 2>&1 > /dev/null; then
   cat << EOF

   Add the following line to the /etc/httpd/php.ini configuration
   file in order to enable this extension

   extension=fileinfo.so
EOF
fi
