.. RST source for asap-mplayer(1) man page. Convert with:
..   rst2man.py asap-mplayer.rst > asap-sdl.1

.. |version| replace:: 5.3.0
.. |date| date::

============
asap-mplayer
============

---------------------------------------------------
command-line player for Atari chiptunes and mplayer
---------------------------------------------------

:Manual section: 1
:Manual group: SlackBuilds.org
:Date: |date|
:Version: |version|

SYNOPSIS
========

**asap-mplayer** [*asapconv-options*] **inputfile**

DESCRIPTION
===========

**asap-mplayer** plays an Atari 8-bit chiptune file, by first
converting it to *.wav* (with **asapconv**\(1)), then running **mplayer**\(1)
on the *.wav* file. After **mplayer** exits, the file is deleted.

The supported input formats are: SAP, CMC, CM3, CMR, CMS, DMC, DLT,
MPT, MPD, RMT, TMC, TM8, TM2 or FC.

During playback, the full set of **mplayer** keyboard controls are
available, meaning you can pause, seek forwards or backwards, speed up
or slow down playback, etc.

Note that there's no way to pass **mplayer** options on the
**asap-mplayer** command line, but your **~/.mplayer/config** will be
read as usual.

OPTIONS
=======

**-h**, **--help**
  Show built-in help.

Any other options are passed to **asapconv** as-is. The most useful
option would probably be **-s song** to select which subsong to play.

COPYRIGHT
=========

**asap-mplayer** and this man page are released under the WTFPL.

AUTHORS
=======

**asap-mplayer** and this man page written for the SlackBuilds.org
project by B. Watson.

SEE ALSO
========

**asapconv**\(1), **asap-sdl**\(1), **chksap.pl**\(1), **sap2ntsc**\(1), **sap2txt**\(1)

The ASAP website: https://asap.sourceforge.net/
