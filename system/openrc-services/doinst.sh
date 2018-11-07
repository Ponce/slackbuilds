
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

openrc_accessibility=(espeakup)
openrc_base=(device-mapper dmcrypt lvm mdadm mdraid udev udev-settle udev-trigger)
openrc_desktop=(acpid alsasound xdm gpm wpa_supplicant)
openrc_devel=(git-daemon influxdb mysqld postgresql svn distccd jenkins redis)
openrc_misc=(bitlbee cpupower connman ntpd ntp-client sntp rsyslog saned metalog pulseaudio syslog-ng sensord fancontrol lm_sensors lircd irexec haveged salt-master salt-minion salt-syncdic hdparm clamd boinc atd libvirtd docker)
openrc_net=(named dhcpd dhcrelay dhcrelay6 hostapd dnsmasq iptables ip6tables rpcbind nfs nfsclient nginx openntpd slapd sshd openvpn quota rsyncd samba saslauthd squid transmission-daemon ufw vnstatd xinetd tor NetworkManager httpd syncthing)
openrc_slack=(dcron sendmail snmpd snmptrapd sysklogd fail2ban)
openrc_video=(vgl bumblebee nvidia-persistenced)

for file in "${openrc_accessibility[@]}" "${openrc_base[@]}" "${openrc_desktop[@]}" "${openrc_devel[@]}" "${openrc_misc[@]}" "${openrc_net[@]}" "${openrc_slack[@]}" "${openrc_video[@]}"; do
  config "etc/openrc/conf.d/${file}.new"
done

BACKUP_FILE=(logrotate.d/jenkins)
for file in "${BACKUP_FILE[@]}"; do
  config "etc/${file}.new"
done

BACKUP_LOCAL=(rcM.start rcd_net.start)
for file in "${BACKUP_LOCAL[@]}"; do
  preserve_perms "etc/openrc/local.d/${file}.new"
done

# disable udev-postmount
[ -e "etc/openrc/runlevels/sysinit/udev-postmount" ] && rm -v "etc/openrc/runlevels/sysinit/udev-postmount"

# disable kmod-static-nodes (openrc-0.26.1, 2017-05-14)
[ -e "etc/openrc/runlevels/sysinit/kmod-static-nodes" ] && rm -v "etc/openrc/runlevels/sysinit/kmod-static-nodes"
