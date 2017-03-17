.. RST source for sdlpop(6) man page. Convert with:
..   rst2man.py sdlpop.rst > sdlpop.6
.. rst2man.py comes from the SBo development/docutils package.

.. |version| replace:: 1.17
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

sdlpop [megahit [*level*]] [draw] [full] [demo] [record] [replay | *filename.PIR*] [validate *filename.PIR*] [mod *mod_name*] [debug] [seed=number]

DESCRIPTION
===========

SDLPoP is an open-source port of Prince of Persia 1, that runs natively under Windows and Linux. It is based on the DOS version of the game, and uses SDL 2.  All data files needed to play the game are included.

This manual page just describes the command-line options and keyboard controls.
Full documentation can be found in\:

   /usr/doc/sdlpop-|version|/Readme.txt

OPTIONS
=======

**Note**: options are NOT preceded by **-**, except for *--help* and *--version*.

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

*validate* **replays/filename.p1r**
            Print out information about a replay file and quit.

*mod* **mod_name**
            Run with custom data files from **~/.sdlpop/mods/mod_name**.

*debug*
            Enable debug cheats.

*seed=number*
            Set initial random seed, for testing.

*--version*, *-v*
            Display SDLPoP version and quit.

*--help*, *-h*, *-?*
            Display help and quit.

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
     Pause game.

*space*
     Show time left.

*Ctrl-A*
     Restart level.

*Ctrl-G*
     Save game (on levels 3..13).

*Ctrl-J*
     Joystick/gamepad mode (implemented by segrax).

*Ctrl-K*
     Keyboard mode.

*Ctrl-R*
     Return to intro.

*Ctrl-S*
     Sound on/off.

*Ctrl-V*
     Show version.

*Ctrl-Q*
     Quit game.

*Ctrl-L*
     Load game (when in the intro).

*Alt-Enter*
     Toggle fullscreen.

*F6*
     Quicksave.

*F9*
     Quickload.

Viewing or recording replays
----------------------------

*Ctrl+Tab (in game)*
     start or stop recording.

*Tab (on title screen)*
     View/cycle through the saved replays in the **~/.sdlpop/replays** directory.

*F (while viewing a replay)*
     Skip forward to the next room.

*Shift-F (while viewing a replay)*
     Skip forward to the next level.

Cheats
------


*Shift-L*
     Go to next level.

*c*
     Show numbers of current and adjacent rooms.

*Shift-C*
     Show numbers of diagonally adjacent rooms.

*-*
     Less remaining time.

*+*
     More remaining time.

*r*
     Resurrect kid.

*k*
     Kill guard.

*Shift-I*
     Flip screen upside-down.

*Shift-W*
     Slow falling.

*h*
     Look at room to the left.

*j*
     Look at room to the right.

*u*
     Look at room above.

*n*
     Look at room below.

*Shift-B*
     Toggle hiding of non-animated objects.

*Shift-S*
     Restore lost hit-point (like a small red potion).

*Shift-T*
     Give more hit-points (like a big red potion).

Debug cheats
------------

*[*
    Shift kid 1 pixel to the left.

*]*
    Shift kid 1 pixel to the right.

*t*
    Toggle timer.

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

