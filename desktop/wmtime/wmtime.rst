.. RST source for wmtime(1) man page. Convert with:
..   rst2man.py wmtime.rst > wmtime.1
.. rst2man.py comes from the SBo development/docutils package.

.. |version| replace:: 1.0b2
.. |date| date::

======
wmtime
======

--------------------------------------
clock/calendar dockapp for windowmaker
--------------------------------------

:Manual section: 1
:Manual group: SlackBuilds.org
:Date: |date|
:Version: |version|

SYNOPSIS
========

wmtime [-digital] [-display *dpy*] [-h] [-v]

DESCRIPTION
===========

wmtime is a clock and calendar dockapp for windowmaker. It can display
an analog-style clock face or a digital-style readout. The current month,
day, and day of week are displayed also.

wmtime supports multiple languages for the weekday and month names. See
*FILES* below for details on how to change the language.

OPTIONS
=======

-h
    Print usage message and exit.
 
-v
    Print version number and exit.

**-digital**
    Display a digital clock face (default is analog).

**-display** *dpy*
    X11 display. Default is to read the DISPLAY environment variable.

FILES
=====

/usr/share/wmtime/languages/\*.lang
    Language support files. Each is a text file with exactly 19 lines. The
    first 7 lines are the 2-letter weekday name abbreviations, starting
    with Sunday. The other 12 lines are the 3-letter month name abbreviations,
    starting with January. Only ASCII is supported, no Unicode or extended 8859-*
    character sets.

/usr/share/wmtime/language
    Symlink to one of the files in /usr/share/wmtime/languages/. This is the
    language the application will use. The system administrator can adjust the
    symlink, but there's no way for a normal user to use a different language
    than the system default.

COPYRIGHT
=========

See the file /usr/doc/wmtime-|version|/COPYING for license information.

AUTHORS
=======

wmtime was written by tijno and warp.

This man page written for the SlackBuilds.org project
by B. Watson, and is licensed under the WTFPL.
