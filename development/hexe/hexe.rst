.. RST source for hexe(1) man page. Convert with:
..   rst2man.py hexe.rst > hexe.1
.. rst2man.py comes from the SBo development/docutils package.

.. |version| replace:: 20120305
.. |date| date::

====
hexe
====

-------------------------
hex editor with curses UI
-------------------------

:Manual section: 1
:Manual group: SlackBuilds.org
:Date: |date|
:Version: |version|

SYNOPSIS
========

hexe [*-options*] [**file**]

DESCRIPTION
===========

hexe is a hex editor with emacs-like key bindings. It runs in a
terminal and allows viewing, editing, and searching in hex or ASCII.

OPTIONS
=======

-b,--byte-groups=<count>
   Set the width of byte groups. Valid counts are 1, 2, 4 (default), 8, 16.

-c,--no-cols=<count>
   Set the number of columns. Default is 4. No checking is done on the
   size of the terminal, so setting this too high means the rightmost
   columns (and ASCII display) will not be visible.

**+ADDRESS**
   Start at ADDRESS (hexadecimal). If the address is greater than the file size,
   starts at the end of the file.

-v,--view
   View mode (read-only).

-h,-?,--help
   Show help message and exit.

AUTHORS
=======

hexe was written by spinout.

This man page written for the SlackBuilds.org project
by B. Watson, and is licensed under the WTFPL.

SEE ALSO
========

The author's homepage: http://spinout182.com
