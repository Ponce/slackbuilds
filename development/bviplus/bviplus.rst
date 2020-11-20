.. RST source for bviplus(1) man page. Convert with:
..   rst2man.py bviplus.rst > bviplus.1
.. rst2man.py comes from the SBo development/docutils package.

.. |version| replace:: 1.0
.. |date| date::

=======
bviplus
=======

---------------------------------------
hex editor with vi-style user interface
---------------------------------------

:Manual section: 1
:Manual group: SlackBuilds.org
:Date: |date|
:Version: |version|

SYNOPSIS
========

bviplus [ [*file*] ... ]

DESCRIPTION
===========

Bviplus is an ncurses based hex editor with a vim-like interface. It
was originally a fork of Binary VIsual editor (bvi) by Gerhard
Burgmann, but has now been completely rewritten (since version 0.3).

There are no command-line options. For usage instructions, enter
":help" from within **bviplus**.

FILES
=====

**~/.bviplusrc**
  Startup script for **bviplus**, as described in the help.

BUGS
====

Running **bviplus** with a nonexistant filename will always create the
file, even if the :w (write) command is never used. This, combined
with the fact that there are no options, may result in empty files
named things like *--help* or *-h*.

COPYRIGHT
=========

See the file /usr/doc/bviplus-|version|/COPYING for license information.

AUTHORS
=======

bviplus was written by David Kelley.

This man page written for the SlackBuilds.org project
by B. Watson, and is licensed under the WTFPL.

SEE ALSO
========

bvi(1), hexer(1), vim(1), xxd(1), vi(1)

The bviplus homepage: http://bviplus.sourceforge.net/
