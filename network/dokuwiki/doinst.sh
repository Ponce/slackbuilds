# Remove comment and enable php
sed -i "s:#Include /etc/httpd/mod_php.conf:Include /etc/httpd/mod_php.conf:g" /etc/httpd/httpd.conf

# not exist? send...
if ! grep -q -e 'dokuwiki' /etc/httpd/httpd.conf; then
    echo "Include /etc/httpd/extra/httpd-dokuwiki.conf" >> /etc/httpd/httpd.conf
fi
