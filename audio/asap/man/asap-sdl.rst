.. RST source for asap-sdl(1) man page. Convert with:
..   rst2man.py asap-sdl.rst > asap-sdl.1

.. |version| replace:: 6.0.3
.. |date| date::

========
asap-sdl
========

----------------------------------------------
simple command-line player for Atari chiptunes
----------------------------------------------

:Manual section: 1
:Manual group: SlackBuilds.org
:Date: |date|
:Version: |version|

SYNOPSIS
========

**asap-sdl** [*-s song*] **inputfile**

DESCRIPTION
===========

**asap-sdl** plays an Atari 8-bit chiptune file, using SDL for audio
output (in practice, this usually means PulseAudio or ALSA).

The supported input formats are: SAP, CMC, CM3, CMR, CMS, DMC, DLT,
MPT, MPD, RMT, TMC, TM8, TM2 or FC.

During playback, you can press Enter to exit. In fact, the player
doesn't exit at the end of the file (nor does it loop, unless the song
does), so you *have* to press Enter after the song is over.

There are no other controls during playback (no way to e.g. seek
forwards or backwards).

OPTIONS
=======

**-h**, **--help**
  Show built-in help.

**-v**, **--version**
  Show version number.

**-s** *song*, **--song**\=song
  Select subsong number (zero-based). The default is 0, which will be
  the only subsong in a file that contains only one song. Use
  **chksap.pl -s filename** to see how many subsongs exist in a file.

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

**asapconv**\(1), **asap-mplayer**\(1), **chksap.pl**\(1), **sap2ntsc**\(1), **sap2txt**\(1)

The ASAP website: https://asap.sourceforge.net/
