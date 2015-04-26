Wireshark (aka Ethereal) is a free packet sniffer computer application.  It 
is used for network troubleshooting, analysis, software and communications
protocol development, and education.  In June 2006, the project was renamed 
from Ethereal due to trademark issues.

The functionality Wireshark provides is very similar to tcpdump, but it has
a graphical front-end and many more information sorting and filtering
options.  It allows the user to see all traffic being passed over the network
(usually an Ethernet network but support is being added for others) by
putting the network interface into promiscuous mode.

Wireshark uses the cross-platform GTK+ widget toolkit.  Its powerful features
make it the tool of choice for network troubleshooting, protocol development,
and education worldwide.

If you use a filesystem that supports posix capabilities, an easy way to 
start wireshark as a normal user, while still providing it with all of the 
access permissions it requires, is by issuing the following command:
  $ setcap cap_net_raw,cap_net_admin=eip /usr/bin/dumpcap

You will need to remove any already-installed wireshark package before 
building this one or else the new one will not work (the new build will
link libraries present in the old package, which will then be removed 
when upgrading).
