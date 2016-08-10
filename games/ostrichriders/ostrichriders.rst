.. RST source for ostrichriders(1) man page. Convert with:
..   rst2man.py ostrichriders.rst > ostrichriders.6
.. rst2man.py comes from the SBo development/docutils package.

.. |version| replace:: 0.6.3
.. |date| date::

.. converting from pod:
.. s/B<\([^>]*\)>/**\1**/g
.. s/I<\([^>]*\)>/*\1*/g

=============
ostrichriders
=============

--------------------------------
clone of the arcade game "Joust"
--------------------------------

:Manual section: 6
:Manual group: SlackBuilds.org
:Date: |date|
:Version: |version|

SYNOPSIS
========

ostrichriders [*-l libdir*]

DESCRIPTION
===========

Enemy knights are invading the kingdom. As one of the elite ostrich
riders, it is your duty to defend the kingdom. With lance in hand
you fly off. Remember to stay above your opponent lest you fall to
his lance. Collect the eggs lest your opponent hatches stronger than
before. Work together with other knights.

The game is controlled entirely via the keyboard. Up to 3 players can
play on the same instance of the game (no networked multiplayer). The
menu is operated with arrow keys and Enter, and the gameplay keys are
configurable via the menu.

OPTIONS
=======

*-l* <libdir>
            Use alternate game data directory.

FILES
=====

*/usr/share/ostrichriders/*
            Game data directory.

*~/.ostrichriders/*
            Per-user directory (settings and high scores).

BUGS
====

The default player 1 and 2 controls are shown on the menu screen, but
are not updated if the controls are changed using the Controls menu.

COPYRIGHT
=========

See the file /usr/doc/PRGNAM-|version|/LICENCE for license information.

AUTHORS
=======

PRGNAM was developed by Seby, Suiland, and Dennis Payne.

This man page written for the SlackBuilds.org project
by B. Watson, and is licensed under the WTFPL.

SEE ALSO
========

The ostrichriders homepage: http://identicalsoftware.com/ostrichriders/
