config() {
  NEW="$1"
  OLD="$(dirname $NEW)/$(basename $NEW .new)"
  # If there's no config file by that name, mv it over:
  if [ ! -r $OLD ]; then
    mv $NEW $OLD
  elif [ "$(cat $OLD | md5sum)" = "$(cat $NEW | md5sum)" ]; then
    # toss the redundant copy
    rm $NEW
  fi
  # Otherwise, we leave the .new copy for the admin to consider...
}

config etc/nftables/bridge-filter.new
config etc/nftables/ipv4-filter.new
config etc/nftables/ipv4-mangle.new
config etc/nftables/ipv6-nat.new
config etc/nftables/ipv6-mangle.new
config etc/nftables/ipv4-nat.new
config etc/nftables/ipv6-filter.new
config etc/nftables/inet-filter.new
