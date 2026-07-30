.. RST source for Maelstrom(1) man page. Convert with:
..   rst2man.py Maelstrom.rst > Maelstrom.6

.. |version| replace:: 4.0.2
.. |date| date::

=========
Maelstrom
=========

----------------------------
Enhanced Asteroids-like game
----------------------------

:Manual section: 1
:Manual group: Ambrosia Software
:Date: |date|
:Version: |version|

SYNOPSIS
========

Maelstrom [--full-screen | --windowed] [--geometry WxH] [--control-brakes]

DESCRIPTION
===========

Maelstrom is a game based on Asteroids, but with several gameplay enhancements:

  - High-resolution color graphics
  - Digital audio
  - Powerups
  - Networked multiplayer/deathmatch mode (up to 3 players)

Game storyline:

  You pilot your ship through the dreaded "Maelstrom" asteroid belt -- suddenly
  your best friend thrusts towards you and fires, directly at your cockpit. You
  raise your shields just in time, and the battle is joined.

  The deadliest stretch of space known to mankind has just gotten deadlier.
  Everywhere massive asteroids jostle for a chance to crush your ship, and deadly
  shinobi fighter patrols pursue you across the asteroid belt. But the deadliest
  of them all is your sister ship, assigned to you on patrol. The pilot, trained
  by your own Navy, battle hardened by months in the Maelstrom, is equipped with a
  twin of your own ship and intimate knowledge of your tactics.

  The lovely Stratocaster R&R facility never sounded so good, but as you fire full
  thrusters to dodge the latest barrage you begin to think you'll never get
  home...

OPTIONS
=======

--fullscreen
  Run Maelstrom in full-screen mode. You may also press Alt-Enter while
  Maelstrom is running, to toggle full-screen.

--windowed
  Run Maelstrom in windowed mode (which is already the default). Alt-Enter toggles.

--geometry *WxH*
  Set width and height of the window, in windowed mode.

--control-brakes
  Allow manual brake control.

CONTROLS
========

The game may be played with either the keyboard or a joystick.  The game
controls may be remapped by pressing C at the main menu. The default keyboard
controls are:

Space, Joystick Button 1
  Fire

Up Arrow, Joystick Up
  Thrust

Down Arrow, Joystick Button 2
  Shield

Right Arrow, Joystick Right
  Turn Clockwise

Left Arrow, Joystick Left
  Turn Counter-clockwise

CapsLock
  Pause

Escape
  Abort Game

Alt-Enter
  Toggle between fullscreen and windowed modes. This keystroke may not be
  remapped.

No special configuration must be done to play with a joystick, provided the
joystick is supported by the SDL library on your OS. There is no way to remap
the joystick controls.

ADD-ONS
=======

Maelstrom add-ons consist of replacement sounds, replacement sprites,
or both. Typically, the add-on content is distributed as a zip file.

**NOTE**: Add-on zip files for Maelstrom versons before 4.0 are
*incompatible* with Maelstrom 4.0 and up. They must be converted with a tool
called **macres**, which ships with the Maelstrom source.

Installing Mods:
  To manually install a mod, just copy the zip file to **/opt/maelstrom/mods/**.
  On Slackware, you can also install the **maelstrom-mods** package from
  SlackBuilds.org, which contains Maelstrom 4.0 compatible conversions of all
  the add-on content formerly available at libsdl.org.

  **NOTE**: The "Select art & sound" dialog in Maelstrom can only display
  5 items (it's not scrollable), two of which are "Original" and "Maelstrom 1980".
  Trying to install more than 3 add-on mods isn't going to be useful.

Using Mods:
  At the game's main menu (title screen), click the cardboard box icon
  in the lower right of the screen (it's kind of a skeletal cardboard
  box, requires some imagination, which is why I even mentioned it
  here).

FILES
=====

/opt/maelstrom/
  Game installation directory. Includes the executable, libraries, and game data (sounds
  and images).

/opt/maelstrom/mods/
  Extra game content may be installed here.

$HOME/.local/share/Ambrosia Software/Maelstrom
  Per-user settings and high-score records.

SEE ALSO
========

/usr/doc/maelstrom-|version|/README.md

AUTHORS
=======

The original version of this game was written for the Macintosh by Andrew Welch,
of Ambrosia Software. It was ported to Linux and then to the Simple DirectMedia
Layer library by Sam Lantinga.

Man page created by B. Watson for SlackBuilds.org project (but others are free
to use it)

COPYRIGHT
=========

The source code to Maelstrom 3.0 and higher has been released under the GNU
General Public License which can be found in COPYING.GPL.

The artwork and sounds used by Maelstrom are copyright Ambrosia Software
(http://www.ambrosiasw.com) and may not be redistributed separately from the
Maelstrom GPL source code.
