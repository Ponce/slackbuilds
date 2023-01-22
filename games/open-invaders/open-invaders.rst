.. RST source for open-invaders(1) man page. Convert with:
..   rst2man.py open-invaders.rst > open-invaders.6

.. |version| replace:: 0.3_8
.. |date| date::

=============
open-invaders
=============

------------------------------
game similar to Space Invaders
------------------------------

:Manual section: 6
:Manual group: SlackBuilds.org
:Date: |date|
:Version: |version|

SYNOPSIS
========

open-invaders [**-f** | **-w**]

DESCRIPTION
===========

**open-invaders** is a Space Invaders clone with updated graphics and
sound. It can be played with either the keyboard or a game controller,
and features 'unlockable' content.

For more information about gameplay, see:

  /usr/doc/open-invaders-|version|/README

OPTIONS
=======

-f
  Start in fullscreen mode (overrides config file).

-w
  Start in windowed mode (overrides config file).

KEYBOARD
========

These keystrokes can be changed from the Options menu within the game. The
defaults are:

**Arrow Keys**
  Move left/right/up/down.

**Left Shift**
  Fire.

**P**
  Pause game.

**Q**
  Quit game, return to main menu.

These keystrokes cannot be changed:

**Control-F**, **Alt-Enter**
  Toggle fullscreen mode.

**Control-S**
  Save screenshot. Screenshots are in **.bmp** format, and will be saved
  to **~/oi_screen_NNNN.bmp**, where *NNNN* is a random 4-digit number.

**Control-C**
  Exit the application.

FILES
=====

~/.openinvaders/config
  Config file. Can be edited with a text editor, or via the Options menu
  in the game.

~/.openinvaders/hiscore
  High scores. Not human-readable.

COPYRIGHT
=========

See the file /usr/doc/open-invaders-|version|/COPYING for license information.

AUTHORS
=======

**open-invaders** was written by Darryl LeCount.

This man page written for the SlackBuilds.org project
by B. Watson, and is licensed under the WTFPL.
