.. RST source for Sl(1) man page. Convert with:
..   rst2man.py Sl.rst > Sl.1
.. rst2man.py comes from the SBo development/docutils package.

.. |version| replace:: 1.1.3
.. |date| date::

==
Sl
==

--------------------
ls with enhancements
--------------------

:Manual section: 1
:Manual group: SlackBuilds.org
:Date: |date|
:Version: |version|

SYNOPSIS
========

Sl [**-1**] [**-a**] [**-atime**] [**-only**] [**-startup**] *startup-file* [**-width**] *terminal-width* [**-log**] [**-version**]

SBO NOTE
========

**Sl** may also be run as **sl**, unless *games/sl* is installed. The
documentation here uses the lowercase version of the name.

DESCRIPTION
===========

sl takes the most common use of Unix ls, to display the files in a
directory compactly in multiple columns, and makes it substantially
more useful.

sl groups files by purpose so you can mentally organize many files
quickly; for instance, it collects HTML and PHP files together, as
opposed to leaving them mixed up with supporting images, CSS, and
JavaScript. sl points out interesting files, which include those that
have been recently modified, read relatively recently, are relatively
large, have warnings, or need to be checked in to or out of version
control.

sl is also aesthetically pleasing due to attention to layout and
filtering as well as limiting color and text annotations to salient
information.

OPTIONS
=======

**-1**
  Single column output (same as ls)

**-a**
  Show hidden (dot) files (same as ls)

**-atime**
  Use access time instead of modification time, for marking "recent" files.

**-only**
  Don't show summary (e.g. "6 files, 11K") at the end of the output

**-startup** *file.tcl*
  Use this startup file instead of *~/.sl.tcl*.

**-width** *terminal-width*
  Assume the terminal is this many columns wide. Default is to query the
  terminal via **stty(1)**, or the **$COLUMNS** environment variable.

**-log**
  Print some debugging info (probably only useful if you're hacking sl's code)

**-version**
  Output version number

FILES
=====

**~/.sl.tcl**
  Startup file. See /usr/doc/Sl-|version|/sl.tcl.example.

COPYRIGHT
=========

sl is licensed under the GNU Public License version 3.

AUTHORS
=======

sl was written by Tom Phelps.

This man page written for the SlackBuilds.org project
by B. Watson, and is licensed under the WTFPL.

SEE ALSO
========

The complete documentation: /usr/doc/Sl-|version|/README.upstream
