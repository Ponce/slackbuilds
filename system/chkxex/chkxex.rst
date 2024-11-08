.. RST source for chkxex(1) man page. Convert with:
..   rst2man.py chkxex.rst > chkxex.1

.. |version| replace:: 20230607_e5c1564
.. |date| date::

======
chkxex
======

---------------------------------------------
print info about Atari 8-bit executable files
---------------------------------------------

:Manual section: 1
:Manual group: SlackBuilds.org
:Date: |date|
:Version: |version|

SYNOPSIS
========

chkxex [*-det*] [*-std*] **filename** [**filename** ...]

DESCRIPTION
===========

chkxex reads an Atari 8-bit segmented executable ("xex" file) and
prints the start address, end address, and length of each segment. Any
run or init addresses are also displayed. Output is in hexadecimal.

Input files can be standard (Atari DOS 2.0S compatible), or
DOS-specific formats for SpartaDOS X and XBIOS.

**chkxex** will exit if any file can't be read, or is not a valid
Atari 8-bit executable; if there are more filenames on the command
line, they will not be processed.

Run **chkxex** with no arguments to see the built-in help message.

OPTIONS
=======

**-std**
  Always treat the input file as a standard Atari DOS executable; do
  not attempt to autodetect the type.

**-det**
  Show extra details ((only applies to SpartaDOS X executables).

EXIT STATUS
===========

Zero for success; non-zero for failure.

AUTHORS
=======

chkxex was written by the Mad Team: https://madteam.atari8.info/

This man page written for the SlackBuilds.org project
by B. Watson, and is licensed under the WTFPL.

SEE ALSO
========

The chkxex homepage: https://github.com/tebe6502/chkXEX/
