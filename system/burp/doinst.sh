config() {
  NEW="$1"
  OLD="$(dirname $NEW)/$(basename $NEW .new)"
  if [ ! -r $OLD ]; then
    mv $NEW $OLD
  elif [ "$(cat $OLD | md5sum)" = "$(cat $NEW | md5sum)" ]; then
    rm $NEW
  fi
}
preserve_perms() {
  NEW="$1"
  OLD="$(dirname $NEW)/$(basename $NEW .new)"
  if [ -e $OLD ]; then
    cp -a $OLD ${NEW}.incoming
    cat $NEW > ${NEW}.incoming
    mv ${NEW}.incoming $NEW
  fi
  config $NEW
}
config etc/burp/ssl_cert-client.pem.new
config etc/burp/clientconfdir/testclient.new
config etc/burp/dhfile.pem.new
config etc/burp/ssl_cert_ca.pem.new
config etc/burp/ssl_cert-server.pem.new
config etc/burp/burp.conf.new
config etc/burp/burp-server.conf.new
preserve_perms etc/rc.d/rc.burp.new
preserve_perms etc/burp/notify_script.new
preserve_perms etc/burp/summary_script.new
preserve_perms etc/burp/timer_script.new
