.. RST source for sntpc(8) man page. Convert with:
..   rst2man.py sntpc.rst > sntpc.8
.. rst2man.py comes from the SBo development/docutils package.

.. |version| replace:: 20181113_1ca1d00
.. |date| date::

=====
sntpc
=====

----------------------------
Network Time Protocol client
----------------------------

:Manual section: 1
:Manual group: SlackBuilds.org
:Date: |date|
:Version: |version|

SYNOPSIS
========

sntpc [**-bhnv**] [**-p** *port*] [**-s** *server*] [**-t** *threshold*]

DESCRIPTION
===========

**sntpc** queries an NTP server for the current time, and sets the
local clock to the time reported by the server. It's a standalone
binary, with no config file and no dependency on the *ntp* package.

**sntpc** does not run as a daemon like **ntpd** does. To keep
the time in sync, you can run **sntpc** from root's **crontab**\(1)
every 30 minutes (or however often it's necessary).

**sntpc** requires root access to actually set the local clock,
although it can be run with **-n** by non-privileged users (e.g. with
**-v** to simply check the local time against the server's time).

OPTIONS
=======

-b
  Allow time shift backwards (default: forward only).

-h
  Show built-in help message.

-n
  No set time (dry run).

-p
  Set server port number (default: 123).

-s
  Set server name or IPv4 address (default: pool.ntp.org).

-t
  Set maximum time offset threshold (default: 300 seconds). This can
  be set to a ludicrously high value such as 40000000000 (over 1,000 years)
  to effectively disable the threshold.

-v
  Verbose (default: silent)

COPYRIGHT
=========

See the file /usr/doc/sntpc-|version|/LICENSE.txt for license information.

AUTHORS
=======

sntpc was written by Greg Hewgill.

This man page written for the SlackBuilds.org project
by B. Watson, and is licensed under the WTFPL.

SEE ALSO
========

**ntpd**\(1)

https://www.ntp.org

The sntpc homepage: https://github.com/ghewgill/sntpc
