.. RST source for syobonaction(6) man page. Convert with:
..   rst2man.py syobonaction.rst > syobonaction.6
.. rst2man.py comes from the SBo development/docutils package.

.. |version| replace:: 0.2
.. |date| date::

============
syobonaction
============

-------------------------------------------
very difficult side-scrolling platform game
-------------------------------------------

:Manual section: 6
:Manual group: SlackBuilds.org
:Date: |date|
:Version: |version|

SYNOPSIS
========

syobonaction [*-nosound*] [*--fullscreen*]

DESCRIPTION
===========

Syobon Action is a 2D Japanese freeware video game notoriously known on
the Internet for its extremely difficult levels. It's a parody of
Super Mario Brothers.

This man page documents OpenSyobon-M, the modified SDL port of OpenSyobon,
which is itself an unofficial SDL port of the original game.

OPTIONS
=======

**-nosound**
  Disable sound in the game.

**-fullscreen**
  Run the game fullscreen (by default, it's in a window).

CONTROLS
========

**Jump**
  Up arrow, Z, semicolon, joystick button 1.

**Movement**
  Left/right arrows, joystick left/right.

**Enter Warp Pipe**
  Down arrow, joystick down.

On the main menu, 0 through 9 select the starting level.

AUTHORS
=======

OpenSyobon-M was written by Wei Mingzhi <whistler_wmz at
users.sf.net>. This version contains additional levels made by Kazuki
Okawa.

OpenSyobon-M is based on Open Syobon Action RC 2 by Mathew Velasquez, which
is based on the original Syobon Action by Chiku.

This man page written for the SlackBuilds.org project
by B. Watson, and is licensed under the WTFPL.

SEE ALSO
========

The syobonaction readme: /usr/doc/syobonaction-|version|/readme.txt
