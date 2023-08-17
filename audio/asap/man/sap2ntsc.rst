.. RST source for sap2ntsc(1) man page. Convert with:
..   rst2man.py sap2ntsc.rst > sap2ntsc.1

.. |version| replace:: 5.3.0
.. |date| date::

========
sap2ntsc
========

-----------------------------------------------------
convert SAP Atari 8-bit chiptune files to NTSC timing
-----------------------------------------------------

:Manual section: 1
:Manual group: SlackBuilds.org
:Date: |date|
:Version: |version|

SYNOPSIS
========

**sap2ntsc** **inputfile** [*...*]

DESCRIPTION
===========

**sap2ntsc** converts an Atari 8-bit chiptune in SAP format from
PAL timing to NTSC. Not all SAP files can be converted: ones that
appear to already be NTSC, or ones that use the FASTPLAY option, are
unconvertible.

**Beware**: each **inputfile** is overwritten without confirmation.
If you need backups of the original files, you should make copies
*before* running **sap2ntsc**.

Non-SAP chiptune files (e.g. RMT, CMC) are not supported.

OPTIONS
=======

**-h**, **--help**
  Show built-in help.

**-v**, **--version**
  Show version number.

COPYRIGHT
=========

See the file /usr/doc/asap-|version|/COPYING for license information.

AUTHORS
=======

The ASAP suite was written by Piotr Fusik, with contributions from many
others (see the website for details).

This man page written for the SlackBuilds.org project
by B. Watson, and is licensed under the WTFPL.

SEE ALSO
========

**asapconv**\(1), **asap-sdl**\(1), **asap-mplayer**\(1), **chksap.pl**\(1), **sap2txt**\(1)

The ASAP website: https://asap.sourceforge.net/
