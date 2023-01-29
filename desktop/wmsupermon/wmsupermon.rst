.. RST source for wmsupermon(1) man page. Convert with:
..   rst2man.py wmsupermon.rst > wmsupermon.1

.. |version| replace:: 1.2.2
.. |date| date::

==========
wmsupermon
==========

--------------------------------------------
universal monitoring dockapp for WindowMaker
--------------------------------------------

:Manual section: 1
:Manual group: SlackBuilds.org
:Date: |date|
:Version: |version|

SYNOPSIS
========

wmsupermon [**-d|display** *display*] [**-c|--config** *file*]

wmsupermon [**-h|--help**]

wmsupermon [**-v|--version**]

DESCRIPTION
===========

**wmsupermon** is a WindowMaker dockapp that can be used to monitor
CPU usage, frequency, and temperature; disk I/O; memory, swap, and
filesystem usage; network traffic (local or to/from your router);
wireless link quality; battery status; and anything else you can think
of that has a numeric value.

The dockapp is configured via the config file (*~/.wmsupermonrc*
by default), which specifies what to monitor and how to present the
results.

See /usr/doc/wmsupermon-|version|/README for the syntax of the config
file. In the same directory are some example configs.

OPTIONS
=======

-d, --display *display*
  Display to use (default: *DISPLAY* in environment).

-c, --config *file*
  Path to config file (default: *~/.wmsupermonrc*). Useful if you want
  to run multiple instances that show different data.

-h, --help
  Shows help text and exits.

-v, --version
  Shows program version and exits.


COPYRIGHT
=========

See the file /usr/doc/wmsupermon-|version|/COPYING for license information.

AUTHORS
=======

wmsupermon was written by Sergei Golubchik.

This man page written for the SlackBuilds.org project
by B. Watson, and is licensed under the WTFPL.

SEE ALSO
========

**WindowMaker**\(1), **wmmon**\(1), **wmnet**\(1)

http://dockapps.net, for a large collection of other dockapps.
