
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

openrc_base=(device-mapper dmcrypt lvm mdadm mdraid udev udev-settle udev-trigger)
openrc_desktop=(acpid alsasound xdm gpm rfcomm wpa_supplicant)
openrc_devel=(git-daemon mysqld postgresql svn)
openrc_misc=(bitlbee cpupower connman ntpd ntp-client sntp rsyslog saned metalog syslog-ng sensord lircd irexec haveged salt-master salt-minion salt-syncdic hdparm clamd boinc atd libvirtd)
openrc_net=(named dhcpd dhcrelay dhcrelay6 dnsmasq iptables ip6tables rpcbind nfs nfsclient openntpd slapd sshd openvpn quota rsyncd samba saslauthd squid transmission-daemon ufw vnstatd xinetd ypbind ypserv tor NetworkManager httpd syncthing)
openrc_slack=(dcron sendmail snmpd snmptrapd sysklogd)
openrc_video=(atieventsd vgl bumblebee)

for file in "${openrc_base[@]}" "${openrc_desktop[@]}" "${openrc_devel[@]}" "${openrc_misc[@]}" "${openrc_net[@]}" "${openrc_slack[@]}" "${openrc_video[@]}"; do
  config "etc/conf.d/${file}.new"
done

preserve_perms etc/local.d/rcM.start.new

# disable udev-postmount
[ -e etc/runlevels/sysinit/udev-postmount ] && rm etc/runlevels/sysinit/udev-postmount
