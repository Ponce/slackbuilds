.. RST source for zorkwrapper.sh(6) man page. Convert with:
..   rst2man.py zorkwrapper.sh.rst > zorkwrapper.sh.6
.. rst2man.py comes from the SBo development/docutils package.

.. |version| replace:: 20211011
.. |date| date::

==============
zorkwrapper.sh
==============

-----------------------
play Infocom Zork games
-----------------------

:Manual section: 6
:Manual group: SlackBuilds.org
:Date: |date|
:Version: |version|

SYNOPSIS
========

| **zork**
| **zork2**
| **zork3**
| **ztuu**

DESCRIPTION
===========

**zorkwrapper.sh** runs the Infocom Zork games. It's installed via
symlinks in the /usr/games directory, so each game can be run by
simply typing its name.

Supported games:

**zork**
  Zork I: The Great Underground Empire

**zork2**
  Zork II: The Wizard of Frobozz

**zork3**
  Zork III: The Dungeon Master

**ztuu**
  Zork: The Undiscovered Underground

The games are run with the first interpreter found, from the following list:

  **fizmo**, **frotz**, **zoom**.

OPTIONS
=======

There are no options or arguments.

FILES
=====

**/usr/share/games/zork/zorkwrapper.sh** is the master copy of the script,
which gets symlinked to the game names in **/usr/games**.

**/usr/share/zcode/** contains the Z-Machine files:

  **zork1.z3**, **zork2.z3**, **zork3.z3**, **ztuu.z5**

AUTHORS
=======

**zorkwrapper.sh** and this man page were written for the
SlackBuilds.org project by B. Watson, and are licensed under the WTFPL.

The Zork games are the property of Activision, which released them
as free-to-use downloads. See /usr/doc/zork-|version|/readme-\*.txt
for license information.

SEE ALSO
========

**fizmo**\(6), **frotz**\(6), **zoom**\(6)

http://www.infocom-if.org/
