.. RST source for tnfsd(1) man page. Convert with:
..   rst2man.py tnfsd.rst > tnfsd.1
.. rst2man.py comes from the SBo development/docutils package.

.. |version| replace:: 20201019
.. |date| date::

=====
tnfsd
=====

---------------------------------
trivial network filesystem daemon
---------------------------------

:Manual section: 1
:Manual group: SlackBuilds.org
:Date: |date|
:Version: |version|

SYNOPSIS
========

tnfsd **directory** [**-c** *username*]

DESCRIPTION
===========

TNFS is a simplified Internet file transfer protocol, designed for
simplicity and ease of implementation on small systems, such as 8-bit
computers. It's simpler than NFS, SMB, or FTP. It's similar to TFTP,
but has features TFTP lacks.

**tnfsd** is the server for the TNFS protocol. It listens for clients
on UDP and TCP port 16384. Most 8-bit clients use UDP, and the Linux
client **tnfs-fuse** uses TCP.

The mandatory **directory** option is the root of the TNFS filesystem
tree.

The **-c** *username* option requires **tnfsd** to be run as
*root*. If given, **tnfsd** will **chroot**\(2) to the *directory*,
then drop its root privileges and run as the *username* user instead.

Even without **chroot**, **tnfsd** will not deliberately allow access
to files outside the *directory*. The **-c** option is a safety net,
in case there's a bug in **tnfsd** that allows such access (currently,
no such bug is known of).

Note that **tnfsd** can be started by a normal user, since it uses an
unprivileged UDP port. The **-c** option won't work in this case.

**tnfsd** logs various information to standard error. If compiled with
*-DUSAGE_LOG*, the log includes all mount, umount, and file transfer
requests including the client IP addresses.

LIMITATIONS
===========

**tnfsd** is designed to be simple, so the following list of
limitations should not be read as complaints or feature requests.

There is no way to run multiple **tnfsd** instances on the same
host, not even on a multi-homed host. The default UDP port cannot
be changed; neither can the IP address used for binding (which is
*0.0.0.0*, aka *INADDR_ANY*). Also, there's no concept of virtual
hosts. If you *really* want to run multiple instances, use containers
or virtual machines.

There's no way to limit which hosts may access **tnfsd** using any
mechanism such as **tcpd**\(8). Firewall rules may be used instead,
e.g. **iptables**\(8).

There isn't a way to share a directory read-only with the current
**tnfsd** implementation. However, filesystem permissions can be used
to prevent the daemon from writing to the shared directory.

COPYRIGHT
=========

See the file /usr/doc/tnfsd-|version|/COPYING for license information.

AUTHORS
=======

tnfsd was written by Dylan Smith.

This man page written for the SlackBuilds.org project
by B. Watson, and is licensed under the WTFPL.

SEE ALSO
========

**tnfs-fuse**\(1), **fujinet-pc**\(1)

/usr/doc/tnfsd-|version|/tnfs-protocol.md
