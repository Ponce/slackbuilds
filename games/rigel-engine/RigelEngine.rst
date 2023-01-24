.. RST source for RigelEngine(1) man page. Convert with:
..   rst2man.py RigelEngine.rst > RigelEngine.6

.. |version| replace:: 0.9.1
.. |date| date::

===========
RigelEngine
===========

---------------------------------
reimplementation of Duke Nukem II
---------------------------------

:Manual section: 6
:Manual group: SlackBuilds.org
:Date: |date|
:Version: |version|

SYNOPSIS
========

RigelEngine [**-s** | **--skip-intro**] [**-d** | **--debug-mode**] [**--no-audio**] [**--play-demo**] [**-l** | **--play-level** *level-name*] [**--difficulty** *easy|medium|hard*] [**--player-pos** *x,y*] [*game-path*]

DESCRIPTION
===========

**RigelEngine** is a modern reimplementation of the game Duke Nukem II,
originally released in 1993 for MS-DOS by Apogee Software.

In order to run RigelEngine, the game data from the original game is
required. Both the shareware version and the registered version work.
When launching RigelEngine for the first time, it will show a file
browser UI and ask you to select the location of your Duke Nukem
II installation. The chosen path will be stored in the game's user
profile, so that you don't have to select it again next time.

It's also possible to pass the path to the game files as argument on
the command line.

The only files actually used by RigelEngine are **NUKEM2.CMP** (the main
data tile; required) and **NUKEM2.F1** through **NUKEM2.F5** (intro movie
files; actually optional).

OPTIONS
=======

-?, -h, --help
  Show built-in help and exit.

-s, --skip-intro
  Skip intro movies/Apogee logo, go straight to main menu.

-d, --debug-mode
  Enable debugging features.

--no-audio
  Disable all audio output.

--play-demo
  Play pre-recorded demo.

**-l**, **--play-level** *level-name*
  Directly jump to given map, skipping intro/menu etc.

**--difficulty** *easy|medium|hard*
  Difficulty to use when jumping to a level.

**--player-pos** *x,y*
  Position to place the player at when jumping to a level.

*game-path*
  Path to original game's installation. If not provided here, the game will show a folder browser UI.

FILES
=====

**$XDG_DATA_HOME/lethal-guitar/Rigel Engine/**

  Per-user configuration, savegames, and log file are stored here.

The default value of **$XDG_DATA_HOME** is the same as **$HOME**.

COPYRIGHT
=========

See the file /usr/doc/rigel-engine-|version|/LICENSE.md for license information.

AUTHORS
=======

RigelEngine was written by lethal-guitar.

This man page written for the SlackBuilds.org project
by B. Watson, and is licensed under the WTFPL.

SEE ALSO
========

/usr/doc/rigel-engine-|version|/README.md

https://github.com/lethal-guitar/RigelEngine/wiki
