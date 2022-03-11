.. RST source for sonic-visualiser(1) man page. Convert with:
..   rst2man.py sonic-visualiser.rst > sonic-visualiser.1
.. rst2man.py comes from the SBo development/docutils package.

.. |version| replace:: 4.4
.. |date| date::

================
sonic-visualiser
================

--------------------------------------------
view and analyze the contents of music files
--------------------------------------------

:Manual section: 1
:Manual group: SlackBuilds.org
:Date: |date|
:Version: |version|

SYNOPSIS
========

sonic-visualiser [*-options*] [*file*] ...

DESCRIPTION
===========

Sonic Visualiser is an application for viewing and analysing the
contents of music audio files. The aim of Sonic Visualiser is to be
the first program you reach for when want to study a musical recording
rather than simply listen to it.

OPTIONS
=======

[*file*] ...
  One or more Sonic Visualiser session files (**.sv**) or audio
  files may be given as arguments.

**-h**, **--help**
  Display built-in help.

**-help-all**
  Display built-in help, including Qt-specific options.

**-v**, **--version**
  Display Sonic Visualiser version number and exit.

**--no-audio**
  Do not attempt to open an audio output device.

**-no-osc**
  Do not provide an Open Sound Control port for remote control.

**--no-splash**
  Do not show a splash screen.

**--osc-script** *scriptfile*
  Batch run the Open Sound Control script found in the
  given file. Supply "-" as file to read from stdin.
  Scripts consist of /command arg1 arg2 ... OSC control
  lines, optionally interleaved with numbers to specify
  pauses in seconds.

**--first-run**
  Clear any saved settings and reset to first-run behaviour.


COPYRIGHT
=========

See the file /usr/doc/sonic-visualiser-|version|/COPYING for license information.

AUTHORS
=======

sonic-visualiser was initiated and developed in the Centre for Digital
Music, Queen Mary University, of London. It is currently maintained
primarily by Chris Cannam at Particular Programs, Ltd.

This man page written for the SlackBuilds.org project
by B. Watson, and is licensed under the WTFPL.

SEE ALSO
========

The sonic-visualiser homepage: https://sonicvisualiser.org/
