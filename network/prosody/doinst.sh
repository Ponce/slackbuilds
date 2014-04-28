config() {
  NEW="$1"
  OLD="$(dirname $NEW)/$(basename $NEW .new)"
  if [ ! -r $OLD ]; then
    mv $NEW $OLD
  elif [ "$(cat $OLD | md5sum)" = "$(cat $NEW | md5sum)" ]; then
    rm $NEW
  fi
}

config etc/prosody/prosody.cfg.lua.new
config etc/prosody/migrator.cfg.lua.new
config etc/prosody/certs/openssl.cnf.new
config etc/prosody/certs/localhost.key.new
config etc/prosody/certs/example.com.key.new
config etc/prosody/certs/example.com.crt.new
config etc/prosody/certs/Makefile.new
config etc/prosody/certs/localhost.cnf.new
config etc/prosody/certs/example.com.cnf.new
config etc/prosody/certs/localhost.crt.new
