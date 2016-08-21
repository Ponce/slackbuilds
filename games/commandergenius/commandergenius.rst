.. RST source for commandergenius(6) man page. Convert with:
..   rst2man.py commandergenius.rst > commandergenius.6
.. rst2man.py comes from the SBo development/docutils package.

.. |version| replace:: 1.9.5.3-Beta
.. |dotlessversion| replace:: 1953beta
.. |date| date::

.. converting from pod:
.. s/B<\([^>]*\)>/**\1**/g
.. s/I<\([^>]*\)>/*\1*/g

===============
commandergenius
===============

-------------------------------------------
open source engine for Commander Keen games
-------------------------------------------

:Manual section: 6
:Manual group: SlackBuilds.org
:Date: |date|
:Version: |version|

SYNOPSIS
========

commandergenius [*dir=dir*] [*finale=<on|off>*]

CGeniusExe [*dir=dir*] [*finale=<on|off>*]

DESCRIPTION
===========

Commander Genius is an open-source clone of Commander Keen which allows
you to play the games, and some of the mods made for it. All of the
original data files are required to do so, however the authors have
provided convenient way to download some of the games (choose "Game
Center" at the main menu). It's also possible to use the data files from
an installed copy of one or more of the games.

Supported games are Keen 1 through 6, plus Keen Dreams and several
fan-made mods.

This man page is a brief summary. Full documentation can be found
in:

/usr/doc/commandergenius-|dotlessversion|/README

OPTIONS
=======

*dir=dir*
   Launch game in the given directory. This is a relative path from
   one of the directories configured in *cgenius.cfg*; absolute paths
   are not allowed.

*finale=<on|off>*
   Skip directly to the finale (ending) of the game.

FILES
=====

*/usr/share/games/commandergenius*
   System-wide directory. Games may be installed here for use by
   multiple players, in the *games/* subdirectory. Also, content from
   the HQP (high quality pack) is installed here.

*~/.CommanderGenius*
   Per-user directory, containing any games downloaded from the in-game
   Game Center. Also contains these files:

*cgenius.cfg*
   Main config file, rewritten on game exit. Contains user preferences.
   Normally not edited by hand, but it's possible to do so.

*games.cfg*
   List of installed games and their directory paths.

*CGLog.html*
   Log file created by the game.

*downloads/*
   Zip files downloaded within the Game Center are saved here.

*games/*
   Files extracted from downloaded zip files are stored here. Also,
   users may manually copy game data files here and add them to
   *games.cfg*, to install games not available from the Game Center.

COPYRIGHT
=========

See the file /usr/doc/commandergenius-|dotlessversion|/COPYRIGHT for license information.

AUTHORS
=======

commandergenius was written by Gerstrong <gerstrong@gmail.com>.

This man page written for the SlackBuilds.org project
by B. Watson, and is licensed under the WTFPL.

SEE ALSO
========

The commandergenius homepage:

https://github.com/gerstrong/Commander-Genius
