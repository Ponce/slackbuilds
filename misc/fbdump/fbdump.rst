.. RST source for fbdump(1) man page. Convert with:
..   rst2man.py fbdump.rst > fbdump.1
.. rst2man.py comes from the SBo development/docutils package.

.. |version| replace:: 0.4.2
.. |date| date::

.. converting from pod:
.. s/B<\([^>]*\)>/**\1**/g
.. s/I<\([^>]*\)>/*\1*/g

======
fbdump
======

-------------------------------------------------------------
Dumps the contents of the framebuffer to stdout as a PPM file
-------------------------------------------------------------

:Manual section: 1
:Manual group: SlackBuilds.org
:Date: |date|
:Version: |version|

SYNOPSIS
========

fbdump [*-fb <device>*] [*-vt <terminal>*] [*-delay <sec>*]

DESCRIPTION
===========

fbdump is a simple tool that captures the contents of the visible portion
of the Linux framebuffer device and writes it to the standard output as
a PPM file. In other words, it takes a screenshot of anything running on
the framebuffer. It currently has fairly complete support for packed-pixel
framebuffer types and also works with the VGA16 framebuffer driver.

OPTIONS
=======

**-fb** *device*
            Path to the framebuffer device to dump. Default: */dev/fb0*.

**-vt** *terminal*
            Bring virtual terminal number *terminal* to the foreground before dumping.
            Default: dump current foreground terminal.

**-delay** *sec*
            Wait *sec* seconds before dumping. Default: dump immediately.

--help
            Display usage and exit.

EXAMPLES
========

To dump the framebuffer as a PNG image:

  fbdump | pnmtopng > grab.png

COPYRIGHT
=========

See the file /usr/doc/fbdump-|version|/COPYING for license information.

AUTHORS
=======

fbdump was written by Richard Drummond <evilrich@rcdrummond.net>.

This man page written for the SlackBuilds.org project
by B. Watson, and is licensed under the WTFPL.

SEE ALSO
========

The fbdump homepage: http://www.rcdrummond.net/fbdump/
