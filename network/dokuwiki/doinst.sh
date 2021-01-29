# Remove comment
sed -i "s:#Include /etc/httpd/mod_php.conf:Include /etc/httpd/mod_php.conf:g" etc/httpd/httpd.conf

# If not exist line, send...
grep -q -e 'Dokuwiki' etc/httpd/httpd.conf || cat >> etc/httpd/httpd.conf <<'EOF'
Include /etc/httpd/extra/httpd-dokuwiki.conf
EOF
