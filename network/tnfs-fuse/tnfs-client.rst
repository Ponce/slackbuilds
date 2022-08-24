.. RST source for tnfs-client(1) man page. Convert with:
..   rst2man.py tnfs-client.rst > tnfs-client.1
.. rst2man.py comes from the SBo development/docutils package.

.. |version| replace:: 20130127_fd46ff
.. |date| date::

===========
tnfs-client
===========

---------------------------------
trivial network filesystem client
---------------------------------

:Manual section: 1
:Manual group: SlackBuilds.org
:Date: |date|
:Version: |version|

SYNOPSIS
========

**tnfs-client** [*host* [*port*]]

DESCRIPTION
===========

TNFS is a simplified Internet file transfer protocol, designed for
simplicity and ease of implementation on small systems, such as 8-bit
computers. It's simpler than NFS, SMB, or FTP. It's similar to TFTP,
but has features TFTP lacks.

**tnfs-client** is a simple client for the TNFS protocol. It uses UDP
port 16384 by default (standard for TNFS).

**tnfs-client** doesn't mount the TNFS share as a directory (see
**tnfs-fuse**\(1) for that). It has a textmode user interface similar
to **ftp**\(1).

If **host** is omitted, the default host is *vexed4.alioth.net*. If
**port** is omitted, the default port is *16384*.

COMMANDS
========

The client supports these commands:

**ls** [*-l*]
  List contents of current directory. With *-l*, show details.

**dir** [*-l*]
  Synonym for **ls**.

**cd** *path*
  Change working directory on server to *path*.

**pwd**
  Print current working directory on server.

**get** *remote-filename* [*local-filename*]
  Download a file.

**put** *local-filename* [*remote-filename*]
  Upload a file.

**mkdir** *path*
  Create a directory.

**rmdir** *path*
  Delete a directory (which must be empty).

**quit**
  Exit the client.

Note that there's no **rm** command, or any other way to delete
a file. There's also no **lcd** command; you can't change the local
working directory, so make sure you're in the right place before you
start the client.

COPYRIGHT
=========

See the file /usr/doc/tnfs-fuse-|version|/COPYING for license information.

AUTHORS
=======

tnfs-client was written by Radu Cristescu.

This man page written for the SlackBuilds.org project
by B. Watson, and is licensed under the WTFPL.

SEE ALSO
========

**tnfs-fuse**\(1), **tnfsd**\(1), **fuse**\(8)
