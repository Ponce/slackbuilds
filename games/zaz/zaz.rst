.. RST source for zaz(1) man page. Convert with:
..   rst2man.py zaz.rst > zaz.6

.. |version| replace:: 1.0.0
.. |date| date::

===
zaz
===

------------------
action/puzzle game
------------------

:Manual section: 6
:Manual group: SlackBuilds.org
:Date: |date|
:Version: |version|

SYNOPSIS
========

zaz [**-d** *directory*] [**-e** [*-level*]] [**-p** *level*] [**-t**]

DESCRIPTION
===========

Zaz is a game where the player has to get rid of incoming balls by
arranging them in triplets. The idea of the game is loosely based on
games like Luxor, Zuma, Puzz Loop, and Puzzle Bobble. The twists that
make Zaz stand out from other games of this type are that the balls
have to be picked from the path (insted of being randomly assigned for
the player) and that the player's "vehicle" is also attached to a path
which is different from level to level.

The game can be controlled with either the mouse or the keyboard (see
**CONTROLS**, below).

OPTIONS
=======

These options are used for editing levels and testing them. For normal
gameplay, **zaz** should be run without options.

-d *directory*
  Use *directory* for game data location. The default is */usr/share/zaz*.

-e [*level*]
  Start up in level editing mode. If **level** is given, it will be loaded
  into the editor, otherwise *default* is used. **level** should be the name
  of the *.lvl* file, minus the *.lvl* extension.
  Must be run from within the data directory (or a copy of it).

-p *level*
  Test-play a level (possibly created with **-e**).
  Must be run from within the data directory (or a copy of it).

-t
  This is supposed to run the built-in self-tests. However, all it seems to
  do is segfault.

CONTROLS
========

Movement
  Mouse X axis or keyboard left/right arrows.

Pick or Fire Ball
  Mouse button 1 (normally left), keyboard Space, Enter, or down arrow.

Speedup (advance puzzle)
  Mouse button 3 (normally right), or keyboard up arrow.

There is no way to change these keyboard/mouse control mappings. If
the keyboard movement doesn't seem to work properly (arrow keys jump
the player all the way left or right), try moving the mouse slightly.

FILES
=====

**$HOME/.zaz/** contains:

  **settings**
    Saved settings. Human-readable, but normally edited within the game,
    via the *Options* menu.

  **hiscores**
    Self-explanatory.

  **\*.profile**
    Used to keep track of which levels have been unlocked.

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

See the file /usr/doc/zaz-|version|/COPYING for license information.

AUTHORS
=======

zaz was written by Remigiusz Dybka, with music by paniQ.

This man page written for the SlackBuilds.org project
by B. Watson, and is licensed under the WTFPL.

SEE ALSO
========

The zaz homepage: http://zaz.sourceforge.net
