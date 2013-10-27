config() {
  NEW="$1"
  OLD="$(dirname $NEW)/$(basename $NEW .new)"
  # If there's no config file by that name, mv it over:
  if [ ! -r $OLD ]; then
    mv $NEW $OLD
  elif [ "$(cat $OLD | md5sum)" = "$(cat $NEW | md5sum)" ]; then # toss the redundant copy
    rm $NEW
  fi
  # Otherwise, we leave the .new copy for the admin to consider...
}

config etc/courier-imap/imapd.new
config etc/courier-imap/imapd-ssl.new
config etc/courier-imap/imapd.cnf.new
config etc/courier-imap/pop3d.new
config etc/courier-imap/pop3d-ssl.new
config etc/courier-imap/pop3d.cnf.new
