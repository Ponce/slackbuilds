.. RST source for snes9x-gtk(1) man page. Convert with:
..   rst2man.py snes9x-gtk.rst > snes9x-gtk.6

.. |version| replace:: 1.62.3
.. |date| date::

==========
snes9x-gtk
==========

--------------------------------------------
Super Nintendo Entertainment System emulator
--------------------------------------------

:Manual section: 6
:Manual group: SlackBuilds.org
:Date: |date|
:Version: |version|

SYNOPSIS
========

**snes9x-gtk** [**-filter** *type*] [**-mutesound**] [**rom-file**]

DESCRIPTION
===========

Snes9x is a portable, freeware Super Nintendo Entertainment
System (SNES) emulator. It basically allows you to play most games
designed for the SNES and Super Famicom Nintendo game systems
on your PC or Workstation; they include some real gems that were only
ever released in Japan.

**snes9x-gtk** is an unofficial port of Snes9x with a GTK+ graphical front‐end.

With no ROM file argument, **snes9x-gtk** will start its graphical user
interface. When a ROM file is named on the command line, snes9x-gtk
will start emulation immediately.

Unlike the original snes9x, **snes9x-gtk** doesn't extensively use
command-line options to affect its behaviour. Instead, use the GUI
and/or keyboard shortcuts from within the emulator.

OPTIONS
=======

**-filter** *type*
  Use a filter to scale the video. Filter types are:

    *none* *supereagle* *2xsai* *super2xsai* *hq2x* *hq3x* *hq4x* *epx* *ntsc*

  The -filter option does the same thing as the GUI's "Apply Scaling
  Filter" selection (under Preferences / Display).

**-mutesound**
  Disable audio output. The sound CPU is still emulated. Note that this
  option will enable the "mute sound?" checkbox in the Preferences user
  interface, whose value will be saved across sessions (you must use
  the GUI to unmute the audio).

FILES
=====

**~/.config/snes9x/snes9x.conf**
  Configuration file. Not intended to be edited directly; stores the
  settings made in the GUI. To return all settings to their defaults,
  remove this file.

Note that the graphical **snes9x-gtk** does not share config files or
directories with command-line **snes9x**\.

COPYRIGHT
=========

See the file /usr/doc/snes9x-|version|/LICENSE for license information.

AUTHORS
=======

snes9x-gtk was ported by Brandon Wright <bearoso@gmail.com>.

Snes9x was written by Gary Henderson and Jerremy Koot. It also includes
code from Ivar (Ivar@snes9x.com), zsKnight, _Demo_, and many others.

This man page written for the SlackBuilds.org project
by B. Watson, and is licensed under the WTFPL.

SEE ALSO
========

**snes9x**\(6)
