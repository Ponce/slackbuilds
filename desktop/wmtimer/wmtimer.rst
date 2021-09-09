.. RST source for wmtimer(1) man page. Convert with:
..   rst2man.py wmtimer.rst > wmtimer.1
.. rst2man.py comes from the SBo development/docutils package.

.. |version| replace:: 2.92
.. |date| date::

=======
wmtimer
=======

-----------------------------------
alarm clock dockapp for windowmaker
-----------------------------------

:Manual section: 1
:Manual group: SlackBuilds.org
:Date: |date|
:Version: |version|

SYNOPSIS
========

wmtimer -[a|c|r] [-b] [-color *<color>*] [-display *<display>*] [-geometry *<geom>*] -t *<hh:mm:ss>* -e *<command>*

DESCRIPTION
===========

**wmtimer** is a dockable alarm clock for WindowMaker which can be run in
alarm, countdown timer, or chronograph mode. In alarm or timer mode,
you can either execute a command or sound the system bell when the time
is reached.

**wmtimer** can be configured either at startup time via the command
line, or by using the GTK interface by clicking on the main part of the
window (anywhere except the buttons).

To switch to the Chrono function simply click on the right arrow button to
start the chronograph.

You can pause the chronogaph by clicking on the center, rectangle button
and resume again by clicking the right arrow button.

You can reset the timer by clicking on the left arrow button.

Without any of the **-a**, **-c**, or **-r** options, **wmtimer**
just shows the current time until it's clicked on.

Time entered via the command line must be in the form of hh:mm:ss. You
don't need to have 2 digits for each number but you must have at least
zeroes as placeholders for hours, minutes and seconds.

OPTIONS
=======

-a
       Alarm mode. **wmtimer** will beep or exec a command at the specified time.

-b     Beep. This uses the X11 "system bell", which may be disabled
       via **xset(1)** (in which case you won't hear anything).

-c
       Countdown timer mode. **wmtimer** will beep or exec a command when specified time counts down to 0.

-color *color*
       Set text color; as a color name (e.g. **green**), or hex digits: *rgb:RR/GG/BB* or *#RRGGBB*.

-display *display*
       X display to connect to (default: **:0**).

-e *command*
       Exec command. If the command has arguments, it must be quoted. If
       any of the arguments have spaces, quote them again (e.g. use
       double-quotes around the whole command, and single-quotes around
       filenames with spaces).

-geometry *geom*
       Window size and placement. Not usually needed.

-r
       Start in chronograph (stopwatch) mode.

-t *<hh:mm:ss>*
       With **-a**, sets the alarm time. With **-c**, sets the initial time
       to count down from. With **-r**, sets the initial time to count *up*
       from. Without this option, the default time is **00:00:00**.

-h     Show built-in help.

-v     Print the version number and exit.

COPYRIGHT
=========

See the file /usr/doc/wmtimer-|version|/COPYING for license information.

AUTHORS
=======

wmtimer was written by Josh King <wmtimer@darkops.net>.

This man page written for the SlackBuilds.org project
by B. Watson, and is licensed under the WTFPL.

SEE ALSO
========

/usr/doc/wmtimer-|version|/README
