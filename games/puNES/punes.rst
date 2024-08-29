.. RST source for punes(1) man page. Convert with:
..   rst2man.py punes.rst > punes.6

.. |version| replace:: 0.111
.. |date| date::

=====
punes
=====

--------------------------------------
Nintendo Entertainment System emulator
--------------------------------------

:Manual section: 6
:Manual group: SlackBuilds.org
:Date: |date|
:Version: |version|

SYNOPSIS
========

punes [*options*] [file ...]

DESCRIPTION
===========

**punes** is a Nintendo Entertaiment System emulator with a Qt user
interface, lots of video effects, and support for compressed ROMs.

OPTIONS
=======

Normally, these options are not used, since **punes** is a GUI
application with a Settings menu where you can configure everything.
These options will override what's in the config file, and will be
saved to the config file when the "Save Settings" option is used.

-h, --help
  Display built-in help (in an X window, not on stdout).

-V, --version
  Print the version number on standard output.

--portable
  Start in portable mode: use the directory the executable is in
  for configuration and NVRAM saved data.

-m, --mode *mode*
  Preferred video mode: pal, ntsc, dendy, auto.

-s, --size *size*
  Window size: 1x, 2x, 3x, 4x, 5x, 6x.

-e, --pixel-aspect-ratio *ratio*
  Change the aspect ratio. Choices: 1:1, 5:4, 8:7, 11:8.

--par-soft-stretch *yes|no*
  Improves the stretched image. Choices: yes, no.

--overscan-blk-brd *yes|no*
  Enable black borders in windowed mode. Choices: yes, no.

--overscan-blk-brd-f *yes|no*
  Enable black borders in fullscreen mode. Choices: yes, no.

-o, --overscan *on|off*
  Default overscan. Choices: on, off.

-i, --filter
  Filter to apply. Choices: nofilter, scale2x, scale3x, scale4x,
  hq2x, hq3x, hq4x, xbrz2x, xbrz3x, xbrz4x, xbrz5x, xbrz6x, xbrz2xmt,
  xbrz3xmt, xbrz4xmt, xbrz5xmt, xbrz6xmt, ntsc, 2xsai, super2xsai,
  supereagle, tv2x, tv3x, tv4x, dotmatrix, paltv1x, paltv2x, paltv3x.

FILES
=====

**~/.config/puNES/**
  Default location for config files. **input.cfg**, **puNES.cfg**, and
  **recent.cfg** are human-readable and editable, though it's usually
  easier to use the Settings menus in the GUI.

**~/.local/share/puNES/**
  Saved data is stored here, including save-states and screenshots.

.. ENVIRONMENT
.. ===========

.. EXIT STATUS
.. ===========

.. BUGS
.. ====

.. EXAMPLES
.. ========

COPYRIGHT
=========

See the file /usr/doc/puNES-|version|/COPYING for license information.

AUTHORS
=======

puNES was written by FHorse.

This man page written for the SlackBuilds.org project
by B. Watson, and is licensed under the WTFPL.

SEE ALSO
========

The puNES homepage: https://github.com/punesemu/puNES

The puNES forum thread: https://github.com/punesemu/puNES
