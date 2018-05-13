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

config etc/ipsec.conf.new
config etc/ipsec.secrets.new
config etc/strongswan.conf.new
config etc/swanctl/swanctl.conf.new
config etc/strongswan.d/starter.conf.new
config etc/strongswan.d/swanctl.conf.new
config etc/strongswan.d/charon-logging.conf.new
config etc/strongswan.d/pki.conf.new
config etc/strongswan.d/scepclient.conf.new
config etc/strongswan.d/charon/attr.conf.new
config etc/strongswan.d/charon/sshkey.conf.new
config etc/strongswan.d/charon/pem.conf.new
config etc/strongswan.d/charon/mgf1.conf.new
config etc/strongswan.d/charon/pkcs8.conf.new
config etc/strongswan.d/charon/kernel-netlink.conf.new
config etc/strongswan.d/charon/nonce.conf.new
config etc/strongswan.d/charon/curve25519.conf.new
config etc/strongswan.d/charon/pkcs12.conf.new
config etc/strongswan.d/charon/x509.conf.new
config etc/strongswan.d/charon/dnskey.conf.new
config etc/strongswan.d/charon/stroke.conf.new
config etc/strongswan.d/charon/random.conf.new
config etc/strongswan.d/charon/hmac.conf.new
config etc/strongswan.d/charon/vici.conf.new
config etc/strongswan.d/charon/md5.conf.new
config etc/strongswan.d/charon/pubkey.conf.new
config etc/strongswan.d/charon/counters.conf.new
config etc/strongswan.d/charon/sha2.conf.new
config etc/strongswan.d/charon/rc2.conf.new
config etc/strongswan.d/charon/pkcs1.conf.new
config etc/strongswan.d/charon/aes.conf.new
config etc/strongswan.d/charon/xauth-generic.conf.new
config etc/strongswan.d/charon/revocation.conf.new
config etc/strongswan.d/charon/cmac.conf.new
config etc/strongswan.d/charon/sha1.conf.new
config etc/strongswan.d/charon/updown.conf.new
config etc/strongswan.d/charon/pkcs7.conf.new
config etc/strongswan.d/charon/fips-prf.conf.new
config etc/strongswan.d/charon/gmp.conf.new
config etc/strongswan.d/charon/pgp.conf.new
config etc/strongswan.d/charon/xcbc.conf.new
config etc/strongswan.d/charon/openssl.conf.new
config etc/strongswan.d/charon/des.conf.new
config etc/strongswan.d/charon/constraints.conf.new
config etc/strongswan.d/charon/resolve.conf.new
config etc/strongswan.d/charon/socket-default.conf.new
config etc/strongswan.d/charon.conf.new
