.. RST source for snes9x(6) man page. Convert with:
..   rst2man.py snes9x.rst > snes9x.6

.. |version| replace:: 1.62.3
.. |date| date::

======
snes9x
======

--------------------------------------------
Super Nintendo Entertainment System emulator
--------------------------------------------

:Manual section: 6
:Manual group: SlackBuilds.org
:Date: |date|
:Version: |version|

SYNOPSIS
========

**snes9x** [*options*] **rom-file**

DESCRIPTION
===========

Snes9x is a portable, freeware Super Nintendo Entertainment
System (SNES) emulator. It basically allows you to play most games
designed for the SNES and Super Famicom Nintendo game systems
on your PC or Workstation; they include some real gems that were only
ever released in Japan.

For the full documentation, see:

  /usr/doc/snes9x-|version|/readme_unix.html

This is the command-line build of **snes9x**. For the GUI version,
see **snes9x-gtk**\(6).

OPTIONS
=======

This man page doesn't include a list of options. Run **snes9x** with
no arguments (or with **--help**) to see them.

FILES
=====

**~/.snes9x/snes9x.conf**
  The config file. **snes9x** doesn't create this; the default config
  file is found in /usr/doc/snes9x-|version|/snes9x.conf.default and
  must be copied to ~/.snes9x/snes9x.conf manually.

The directory **~/.snes9x/** also contains subdirectories for savestates,
screenshots, sram, etc. These are populated by **snes9x** as needed.

Note that the graphical **snes9x-gtk** does not share config files or
directories with command-line **snes9x**\.

COPYRIGHT
=========

See the file /usr/doc/snes9x-|version|/LICENSE for license information.

AUTHORS
=======

Snes9x was written by Gary Henderson and Jerremy Koot. It also includes
code from Ivar (Ivar@snes9x.com), zsKnight, _Demo_, and many others.

This man page written for the SlackBuilds.org project
by B. Watson, and is licensed under the WTFPL.

SEE ALSO
========

**snes9x-gtk**\(6)
