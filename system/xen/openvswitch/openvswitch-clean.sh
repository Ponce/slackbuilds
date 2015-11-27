#!/bin/bash

# This script applies configuration found in /etc/xen/openvswitch.conf to
# all running domains and removes orphan entries from openvswitch database.
# Written by Mario Preksavec <mario@slackware.hr>

if [ -f /etc/xen/openvswitch.conf ]; then
  declare -A rate ipv4 ipv6
  . /etc/xen/openvswitch.conf
  for domid in $(xenstore-list /local/domain); do
    # Skip dom0
    if [ $domid -eq 0 ]; then continue; fi

    # Take settings from config file
    name=$(xenstore-read /local/domain/$domid/name)
    if [ ! -z ${rate[$name]} ]; then
      rate=${rate[$name]}
    elif [ ! -z ${rate[::default]} ]; then
      rate=${rate[::default]}
    else
      rate=0
    fi

    if [ ! -z ${ipv4[$name]} ]; then
      ipv4=${ipv4[$name]}
    elif [ ! -z ${ipv4[::default]} ]; then
      ipv4=${ipv4[::default]}
    else
      ipv4=
    fi

    if [ ! -z ${ipv6[$name]} ]; then
      ipv6=${ipv6[$name]}
    elif [ ! -z ${ipv6[::default]} ]; then
      ipv6=${ipv6[::default]}
    else
      ipv6=
    fi

    # Domain can have more then one vif
    for vif in $(xenstore-list /local/domain/$domid/device/vif); do
      dev=vif$domid.$vif
      # Handle qemu device names
      if [ -e /sys/class/net/${dev}-emu ]; then dev=${dev}-emu; fi

      bridge=$(xenstore-read /local/domain/0/backend/vif/$domid/$vif/bridge)
      port=$(ovs-vsctl get interface $dev ofport)

      # Remove flows and qos
      ovs-ofctl del-flows $bridge in_port=$port
      ovs-vsctl --timeout=30 -- --if-exists clear port $dev qos

      if [ $rate -gt 0 ]; then
        echo "Domain $name -- added ${rate}MB/s rate restriction to dev $dev"
        policing_rate=$((rate * 1000))
        policing_burst=$((rate * 100))
        min_rate=$((rate * 1000000))
        max_rate=$((rate * 1000000))
        qos_id="@qos_$dev"
        que_id="@que_$dev"
        ovs-vsctl -- set interface $dev \
          ingress_policing_rate=$policing_rate \
          ingress_policing_burst=$policing_burst \
          -- set port $dev qos=$qos_id \
          -- --id=$qos_id create qos type=linux-htb \
          other-config:max-rate=$max_rate queues=0=$que_id \
          -- --id=$que_id create queue other-config:min-rate=$min_rate \
          other-config:max-rate=$max_rate >/dev/null 2>&1
      fi

      if [ ! -z "$ipv4" ] || [ ! -z "$ipv6" ]; then
        mac=$(xenstore-read /local/domain/$domid/device/vif/$vif/mac)

        if [ ! -z "$ipv4" ]; then
          echo "Domain $name -- added IPv4 $ipv4 restriction to dev $dev"
          ovs-ofctl add-flow $bridge "in_port=$port priority=39000 \
            dl_type=0x0800 nw_src=$ipv4 dl_src=$mac idle_timeout=0 \
            action=normal" >/dev/null 2>&1
        fi

        if [ ! -z "$ipv6" ]; then
          echo "Domain $name -- added IPv6 $ipv6 restriction to dev $dev"
          ovs-ofctl add-flow $bridge "in_port=$port priority=39000 \
            dl_type=0x86dd ipv6_src=$ipv6 dl_src=$mac idle_timeout=0 \
            action=normal" >/dev/null 2>&1
        fi

        echo "Domain $name -- added ARP $mac restriction to dev $dev"
        ovs-ofctl add-flow $bridge "in_port=$port priority=38500 \
          dl_type=0x0806 dl_src=$mac idle_timeout=0 action=normal" \
          >/dev/null 2>&1
        ovs-ofctl add-flow $bridge "in_port=$port priority=38000 \
          idle_timeout=0 action=drop" >/dev/null 2>&1

      fi
    done
  done

  # Behold, the garbage collector!
  for bridge in $(ovs-vsctl list-br); do
    # Remove unused ports -- unexistent devices
    for dev in $(ovs-vsctl list-ports $bridge); do
      if [ ! -e /sys/class/net/$dev ]; then
        ovs-vsctl -- del-port $bridge $dev
      fi
    done
    # Remove unused flows -- unexistent ports
    for port in $(ovs-ofctl dump-flows $bridge \
    | awk 'match($0, /in_port=([0-9]+)/, a) {print a[1]}' \
    | sort -n | uniq); do
      dev=$(ovs-vsctl --bare -- --columns=name find interface ofport=$port)
      if [ -z "$dev" ]; then
        ovs-ofctl del-flows $bridge in_port=$port
      fi
    done
  done

  # Remove unused qos
  for qos in $(ovs-vsctl list qos | awk '/^_uuid/ {print $NF}'); do
    if [ $(ovs-vsctl list port | grep -cF $qos) -eq 0 ]; then
      ovs-vsctl -- destroy qos $qos
    fi
  done

  # Remove unused queues
  for queue in $(ovs-vsctl list queue | awk '/^_uuid/ {print $NF}'); do
    if [ $(ovs-vsctl list qos | grep -cF $queue) -eq 0 ]; then
      ovs-vsctl -- destroy queue $queue
    fi
  done
fi
