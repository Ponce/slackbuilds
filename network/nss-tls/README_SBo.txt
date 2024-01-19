Slackware-specific nss-tls HOWTO
--------------------------------

1. Make sure /etc/nss-tls.conf has at least one DNS-over-HTTPS server URL
   listed. The default config file has 3, so you shouldn't need to
   change it unless you don't trust the default servers (one of which
   belongs to Google). Although it's possible to use hostnames in the
   config file, I highly recommend using IP addresses.

2. Add this code to your /etc/rc.d/rc.local:

   [ -x /etc/rc.d/rc.nss-tlsd ] && /etc/rc.d/rc.nss-tlsd start

3. Make sure /etc/rc.d/rc.nss-tlsd is executable (it is, by default).

4. Manually start the daemon with the command: /etc/rc.d/rc.nss-tlsd start
   Or, you could reboot instead.

   At this point, you should be able to use the tlslookup(1) tool to
   do some test lookups. Try "tlslookup www.slackware.com". You should
   get output similar to:

   $ tlslookup www.slackware.com
   23.218.93.137
   23.218.93.171
   2600:1402:9800:d::b833:2ac7
   2600:1402:9800:d::b833:2acd

5. Edit /etc/nsswitch.conf and find the line that reads "hosts: files dns".
   Replace the "dns" with "tls", so the line looks like:

   hosts: files tls

   Now, try "ping www.slackware.com". If this works, you should be
   able to use normal clients (web browsers, mail, etc). nss-tls
   transparently replaces the DNS resolver... but not everything
   will work. In particular, git, curl, and alpine (the mail client)
   are known not to work in this configuration. To support these
   applications, see the next step.

6. To keep regular DNS as a fallback option, change the line in
   /etc/nss-tls.conf again, so it looks like:

   hosts: files tls dns

   This allows applications that don't work with nss-tls to use regular
   DNS instead. Notably, git won't work without fallback DNS.

7. Optional: users can run their own instances of the daemon, with
   caching support. Run the command /usr/bin/nss-tlsd-user from
   your startup scripts (~/.bash_profile for console logins, or
   whatever your desktop environment uses if you use GUI login).

   This isn't really required, though it can provide some extra
   security on multi-user systems. If you're the only person who uses
   your Slackware box, you probably don't need this.

Running a server
----------------

nss-tls is just the client side of DNS-over-HTTPS. If you want to run
a server, look into unbound (on SBo). In future Slackware versions,
you may be able to use Slackware's bind for this (the version in 15.0
doesn't support it, but the one in -current should).
