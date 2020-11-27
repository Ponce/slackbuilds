.. RST source for kfc(1) man page. Convert with:
..   rst2man.py kfc.rst > kfc.1
.. rst2man.py comes from the SBo development/docutils package.

.. |version| replace:: 0.1.2
.. |date| date::

.. converting from pod:
.. s/B<\([^>]*\)>/**\1**/g
.. s/I<\([^>]*\)>/*\1*/g

===
kfc
===

--------------------------------------
terminal-emulator color palette setter
--------------------------------------

:Manual section: 1
:Manual group: SlackBuilds.org
:Date: |date|
:Version: |version|

SYNOPSIS
========

kfc [*-L*] [*-r* | *-s palette*] [*-l* | *-p* | *-v*]

DESCRIPTION
===========

This project was inspired by Dylan Arap's POSIX shell script,
okpal, which utilizes 16 ANSI colors to control the color scheme
of existing terminal-emulator windows. This allows one to achieve
consistent colors across all terminal utilities and applications. This
application has similar functionality to okpal but is designed with
execution speed in mind. There are currently 300 light and dark color
palettes offered at this time that can be applied and quickly swapped
out for others.

OPTIONS
=======

-L          Set light themes (modifier for -s/-r)
-r          Select a random palette (dark theme by default)
-s palette  Select a palette (dark theme by default)
-l          List all palettes (dark themes by default)
-p          Print current palette
-v          Show version information

COPYRIGHT
=========

See the file /usr/doc/kfc-|version|/LICENSE for license information.

AUTHORS
=======

kfc was written by Michael Czigler.

This man page written for the SlackBuilds.org project
by B. Watson, and is licensed under the WTFPL.

SEE ALSO
========

The kfc homepage: https://github.com/mcpcpc/kfc
