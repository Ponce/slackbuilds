.. RST source for icarus(6) man page. Convert with:
..   rst2man.py icarus.rst > icarus.6
.. rst2man.py comes from the SBo development/docutils package.

.. |version| replace:: 106
.. |date| date::

======
icarus
======

------------------------------
ROM library importer for higan
------------------------------

:Manual section: 6
:Manual group: SlackBuilds.org
:Date: |date|
:Version: |version|

SYNOPSIS
========

icarus

DESCRIPTION
===========

icarus is a graphical program that takes no command-line arguments.

When launched, icarus presents a file browser that can be used to locate
ROM files. Select one or more ROMs (or use "Select All"), then click
Import to import the ROM(s) into the higan library, by default located
at $HOME/Emulation.

After importing, the games will be selectable from the "Library" menu in
the higan user interface.

AUTHORS
=======

higan was written by byuu.

This man page written for the SlackBuilds.org project
by B. Watson, and is licensed under the WTFPL.

SEE ALSO
========

higan(6)
