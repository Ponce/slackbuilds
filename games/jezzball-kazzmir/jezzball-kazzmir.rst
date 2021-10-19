.. RST source for jezzball-kazzmir(6) man page. Convert with:
..   rst2man.py jezzball-kazzmir.rst > jezzball-kazzmir.6
.. rst2man.py comes from the SBo development/docutils package.

.. |version| replace:: 1.1
.. |date| date::

================
jezzball-kazzmir
================

------------------------------
clone of classic Jezzball game
------------------------------

:Manual section: 6
:Manual group: SlackBuilds.org
:Date: |date|
:Version: |version|

SYNOPSIS
========

jezzball-kazzmir [*-d datadir*]

DESCRIPTION
===========

Jezzball is a classic game much like Qix, wherein you must create walls
and not get hit by the flying balls. If you create enough walls to cover
80% of the screen, you go to the next level, where you get one extra life
and another ball trying to kill you.

This is a clone of the original Jezzball, with gameplay similar but
not identical to the original Windows version.

OPTIONS
=======

**-d** *datadir*
  Use alternate game data directory. The default is */usr/share/games/jezzball-kazzmir*.

CONTROLS
========

The game is played entirely with the mouse.

Left click to create a wall.

Right click to change the direction of the mouse (horizontal/vertical).

FILES
=====

**/var/games/jezzball-kazzmir/scores.jzb**
  High score file.

AUTHORS
=======

jezzball-kazzmir was written by by Kazzmir aka Jon Rafkind.

This man page written for the SlackBuilds.org project
by B. Watson, and is licensed under the WTFPL.

SEE ALSO
========

The jezzball-kazzmir homepage: https://www.allegro.cc/depot/Jezzball
