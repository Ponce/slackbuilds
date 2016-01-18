sed -i "s:#Include /etc/httpd/mod_php.conf:Include /etc/httpd/mod_php.conf:g" etc/httpd/httpd.conf 
grep -q -e 'Dokuwiki' etc/httpd/httpd.conf || cat >> etc/httpd/httpd.conf <<'EOF'
# Dokuwiki
Include /etc/httpd/extra/httpd-dokuwiki.conf
EOF
