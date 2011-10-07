#!/bin/sh
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

config etc/libvirt/qemu.conf.new
config etc/libvirt/qemu/networks/default.xml.new
config etc/libvirt/libvirtd.conf.new
config etc/libvirt/nwfilter/qemu-announce-self.xml.new
config etc/libvirt/nwfilter/no-arp-spoofing.xml.new
config etc/libvirt/nwfilter/no-mac-spoofing.xml.new
config etc/libvirt/nwfilter/allow-incoming-ipv4.xml.new
config etc/libvirt/nwfilter/allow-dhcp-server.xml.new
config etc/libvirt/nwfilter/allow-arp.xml.new
config etc/libvirt/nwfilter/no-other-rarp-traffic.xml.new
config etc/libvirt/nwfilter/clean-traffic.xml.new
config etc/libvirt/nwfilter/qemu-announce-self-rarp.xml.new
config etc/libvirt/nwfilter/no-mac-broadcast.xml.new
config etc/libvirt/nwfilter/no-ip-spoofing.xml.new
config etc/libvirt/nwfilter/allow-dhcp.xml.new
config etc/libvirt/nwfilter/no-other-l2-traffic.xml.new
config etc/libvirt/nwfilter/allow-ipv4.xml.new
config etc/libvirt/nwfilter/no-ip-multicast.xml.new
config etc/libvirt/lxc.conf.new
config etc/logrotate.d/libvirtd.new
config etc/logrotate.d/libvirtd.lxc.new
config etc/logrotate.d/libvirtd.qemu.new
config etc/logrotate.d/libvirtd.uml.new
config etc/sasl2/libvirt.conf.new
