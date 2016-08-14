.. RST source for sdlpop(6) man page. Convert with:
..   rst2man.py sdlpop.rst > sdlpop.6
.. rst2man.py comes from the SBo development/docutils package.

.. |version| replace:: 1.16
.. |date| date::

======
sdlpop
======

--------------------------------------
open source port of Prince of Persia 1
--------------------------------------

:Manual section: 6
:Manual group: SlackBuilds.org
:Date: |date|
:Version: |version|

SYNOPSIS
========

sdlpop [megahit [*level*]] [draw] [full] [demo] [record] [replay | *filename*.PIR]

DESCRIPTION
===========

SDLPoP is an open-source port of Prince of Persia 1, that runs natively under Windows and Linux. It is based on the DOS version of the game, and uses SDL 2.  All data files needed to play the game are included.

This manual page just describes the command-line options and keyboard controls.
Full documentation can be found in\:

   /usr/doc/sdlpop-|version|/Readme.txt

OPTIONS
=======

**Note**: options are NOT preceded by **-**.

.. notice the **-opt** *param* stuff? rst's option recognition
.. can't handle non-GNU-style options like -option (it thinks the
.. option is -o, and the ption is the parameter). So we have to help
.. it out a little.

*megahit*   Enable cheats.

*1* through *14*
            Start the given level. Requires *megahit*.

*draw*      Draw directly to the screen, skipping the offscreen buffer.

*full*      Run in full screen mode.

*demo*      Run in demo mode. Only the first two levels will be playable, and quotes from magazine reviews will be displayed.

*record*    Start recording immediately (see the Replays section in Readme.txt).

*replay* or a .PIR filename
            Start replaying immediately (see the Replays section in Readme.txt).
            Filenames not beginning with **/** are interpreted as relative paths
            from the *~/.sdlpop* directory, not the current directory.

KEYBOARD
========

Controlling the kid
-------------------


*left*
     turn or run left

*right*
     turn or run right

*up*
     jump or climb up

*down*
     crouch or climb down

*shift*
     pick up things

*shift+left/right*
     careful step

*home or up+left*
     jump left

*page up or up+right*
     jump right

You can also use the numeric keypad.

Gamepad equivalents
-------------------


*left/right*
     left/right

*A*
     down

*B*
     quit

*X*
     shift

*Y*
     up

Controlling the game
--------------------


*Esc*
     pause game

*space*
     show time left

*Ctrl-A*
     restart level

*Ctrl-G*
     save game (on levels 3..13)

*Ctrl-J*
     joystick/gamepad mode (implemented by segrax)

*Ctrl-K*
     keyboard mode

*Ctrl-R*
     return to intro

*Ctrl-S*
     sound on/off

*Ctrl-V*
     show version

*Ctrl-Q*
     quit game

*Ctrl-L*
     load game (when in the intro)

*Alt-Enter*
     toggle fullscreen

*F6*
     quicksave

*F9*
     quickload

Viewing or recording replays
----------------------------


*Ctrl+Tab (in game)*
     start or stop recording

*Tab (on title screen)*
     view/cycle through the saved replays in the SDLPoP directory

Cheats
------


*Shift-L*
     go to next level

*c*
     show numbers of current and adjacent rooms

*Shift-C*
     show numbers of diagonally adjacent rooms

*-*
     less remaining time

*+*
     more remaining time

*r*
     resurrect kid

*k*
     kill guard

*Shift-I*
     flip screen upside-down

*Shift-W*
     slow falling

*h*
     look at room to the left

*j*
     look at room to the right

*u*
     look at room above

*n*
     look at room below

*Shift-B*
     toggle hiding of non-animated objects

*Shift-S*
     Restore lost hit-point. (Like a small red potion.)

*Shift-T*
     Give more hit-points. (Like a big red potion.)

.. other sections we might want, uncomment as needed.

FILES
=====

*/usr/share/games/sdlpop/*
     Game data files, including graphics, levels, and music.

*~/.sdlpop/*
     Per-user game directory, created the first time **sdlpop** is run.
     The game changes directory here before running.
     Contains symlinks to the data files, and\:

*~/.sdlpop/SDLPoP.ini*
     Config file for sdlpop. Copied (not symlinked) from the data directory,
     so it can be edited as desired. See the comments in **SDLPoP.ini** itself
     for a description.

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

See the file /usr/doc/sdlpop-|version|/gpl-3.0.txt for license information.

AUTHORS
=======

sdlpop was written by David from forum.princed.org, with contributions
from other forum members.

This man page written for the SlackBuilds.org project
by B. Watson, and is licensed under the WTFPL.

SEE ALSO
========

Homepage: http://www.popot.org/get_the_games.php?game=SDLPoP

Topic in forum: http://forum.princed.org/viewtopic.php?f=69&t=3512

GitHub: https://github.com/NagyD/SDLPoP

