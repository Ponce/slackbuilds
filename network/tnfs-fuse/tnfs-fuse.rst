.. RST source for tnfs-fuse(1) man page. Convert with:
..   rst2man.py tnfs-fuse.rst > tnfs-fuse.1
.. rst2man.py comes from the SBo development/docutils package.

.. |version| replace:: 20130127_fd46ff
.. |date| date::

=========
tnfs-fuse
=========

---------------------------------
trivial network filesystem client
---------------------------------

:Manual section: 1
:Manual group: SlackBuilds.org
:Date: |date|
:Version: |version|

SYNOPSIS
========

tnfs-fuse **directory** **-o address=host**\[:*port*]

DESCRIPTION
===========

TNFS is a simplified Internet file transfer protocol, designed for
simplicity and ease of implementation on small systems, such as 8-bit
computers. It's simpler than NFS, SMB, or FTP. It's similar to TFTP,
but has features TFTP lacks.

**tnfs-fuse** is a client for the TNFS protocol. It uses UDP port
16384 by default (standard for TNFS).

When working with mounted TNFS directories, some error messages will
be wrong, e.g. instead of "Permission denied", you may get "Bad file
descriptor".

OPTIONS
=======

**-o address=host**\[:*port*]
  The hostname or IP address of the TNFS server to mount. If *:port* is
  not given, the default TNFS port (16384) is used.

**-o ro**
  Mount read-only.

**tnfs-fuse** supports the full set of **fuse** options. See
**fuse**\(8) or **tnfs-fuse --help** for the list.

EXAMPLE
=======

To mount the TNFS server at **fujinet.online**::

  mkdir fujinet
  tnfs-fuse fujinet -o address=fujinet.online

Now the contents of the TNFS server are visible under fujinet/ (or
whatever name you chose). You might also want to add **-o ro** to mount
read-only.

COPYRIGHT
=========

See the file /usr/doc/tnfs-fuse-|version|/COPYING for license information.

AUTHORS
=======

tnfs-fuse was written by Radu Cristescu.

This man page written for the SlackBuilds.org project
by B. Watson, and is licensed under the WTFPL.

SEE ALSO
========

**tnfs-client**\(1), **tnfsd**\(1), **fuse**\(8)
