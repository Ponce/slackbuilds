.. RST source for pom1(6) man page. Convert with:
..   rst2man.py pom1.rst > pom1.6
.. rst2man.py comes from the SBo development/docutils package.

.. |version| replace:: 1.0.0
.. |date| date::

====
pom1
====

----------------
Apple I emulator
----------------

:Manual section: 6
:Manual group: SlackBuilds.org
:Date: |date|
:Version: |version|

SYNOPSIS
========

pom1 [*-options*]

DESCRIPTION
===========

**pom1** is an Apple I emulator.

The Apple I was Apple's first desktop computer, released in 1976.

OPTIONS
=======

Options can be set from the config file, on the command line, or via
Control key combinations while running. At exit, **pom1** writes the
current config back to the config file.

============== ===       ====================== ==========================================
Option         Key       Command Line           Description
============== ===       ====================== ==========================================
Load Memory    ^L                               Load memory from a binary or ascii file.
Save Memory    ^S                               Save memory to a binary or ascii file.
Quit           ^Q                               Quit the emulator.
Reset          ^R                               Soft reset the emulator.
Hard Reset     ^H                               Hard reset the emulator.
Pixel Size     ^P        **-pixelsize** *n*     Set the pixel size (1 or 2).
Scanlines      ^N        **-scanlines**         Turn scanlines on or off (pixel size 2 only).
Terminal Speed ^T        **-terminalspeed** *n* Set the terminal speed (Range: 1 - 120).
RAM 8K         ^E        **-ram8k**             Use only 8KB of RAM or entire 64KB of RAM.
Write In ROM   ^W        **-writeinrom**        Allow writing data in ROM or not.
IRQ/BRK Vector ^V                               Set address of interrupt vector.
Fullscreen     ^F        **-fullscreen**        Switch to fullscreen or window.
Blink Cursor   ^B        **-blinkcursor**       Set the cursor to blink or not.
Cursor Block   ^C        **-blockcursor**       Set the cursor to block or \@.
Show About     ^A                               Show version and copyright information.
ROM Directory            **-romdir** *dir*      Look here for ROMS (see **FILES**).
============== ===       ====================== ==========================================

FILES
=====

**~/.pom1/pom1.cfg**
  Read at startup and overwritten at exit. Contains the state of options that
  can be set from the command line (**-pixelsize**, etc). If this file is
  missing, it will be created.

**/usr/share/games/pom1/roms**
  Default location for the ROM images: **basic.rom**, **charmap.rom**, and **monitor.rom**.

ENVIRONMENT
===========

**POM1ROMDIR**
  If set, overrides the built-in path to the ROM images. Same as the command-line
  option **-romdir**.

COPYRIGHT
=========

See the file /usr/doc/pom1-|version|/COPYING for license information.

AUTHORS
=======

**pom1** was written by John D. Corrado and Verhille Arnaud.

This man page written for the SlackBuilds.org project
by B. Watson, and is licensed under the WTFPL.

SEE ALSO
========

The **pom1** homepage: http://pom1.sourceforge.net/

Wikipedia's Apple I entry: https://en.wikipedia.org/wiki/Apple_I
