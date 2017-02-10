.. RST source for wmdl(1) man page. Convert with:
..   rst2man.py wmdl.rst > wmdl.1
.. rst2man.py comes from the SBo development/docutils package.

.. |version| replace:: 1.4.1
.. |date| date::

====
wmdl
====

----------------------------------------------
CPU load meter, using id Software's Doom faces
----------------------------------------------

:Manual section: 1
:Manual group: SlackBuilds.org
:Date: |date|
:Version: |version|

SYNOPSIS
========

wmdl [-v] [-h] [-s yes/no] [-w withdrawn/iconic/normal] [-m cpu/load/uptime] [-f scale_factor] [-u milliseconds] [-d display] [-g geometry] [-i initial_set_of_images]


DESCRIPTION
===========

A simple CPU load meter, using id Software's Doom faces (more
bloody = higher system load) or Tux the penguin (more angry = higher
system load).

wmdl is a WindowMaker dockapp, but can be used with other window managers
by running in normal window mode (see -w option below).

OPTIONS
=======

.. notice the **-opt** *param* stuff? rst's option recognition
.. can't handle non-GNU-style options like -option (it thinks the
.. option is -o, and the ption is the parameter). So we have to help
.. it out a little.

-h
   Print usage info and exit.

-v
   Verbose.

-g geometry
   Window geometry, default 64x64+10+10

-d dpy
   Display. Default is to read the DISPLAY environment variable.

-w withdrawn/iconic/normal
   Window mode: Iconic, Normal, or Withdrawn. Default: withdrawn.

-s yes/no
   Shaped window: yes or no. "yes" requires X11 Shape extension.

-m cpu/load/command [command index]
   Use load, cpu, or external command. See /usr/doc/wmdl-|version|/README for command examples.
   Default: load.

-f scale_factor
   Scale: floating point number = 100% bloody. Default: 1.0 for '-m cpu',
   2.0 for '-m load'.

-u milliseconds
   Update period in milliseconds. Default: 999

-i face_set
   0 = Doom faces (default), 1 = Tux faces.

COPYRIGHT
=========

See the file /usr/doc/wmdl-|version|/README for license information.

AUTHORS
=======

wmdl was written by Ben Cohen, with contributions from Guilhem Valentin,
Chris Conn, and Kevin Pulo. Doom face images are copyrighted by id
Software.

This man page written for the SlackBuilds.org project
by B. Watson, and is licensed under the WTFPL.

SEE ALSO
========

See the file /usr/doc/wmdl-|version|/README for complete documentation.
