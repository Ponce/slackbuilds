/var/log/mythbackend.log /var/log/mythfrontend.log {
rotate 4
weekly
notifempty
sharedscripts
missingok
postrotate
[ -f "/var/run/mythbackend.pid" ] && /bin/kill -HUP `cat /var/run/mythbackend.pid`
endscript
}
