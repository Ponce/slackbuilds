.. RST source for ncursesoflife(1) man page. Convert with:
..   rst2man.py ncursesoflife.rst > ncursesoflife.6
.. rst2man.py comes from the SBo development/docutils package.

.. |version| replace:: 20141006_0ceeca7
.. |date| date::

.. converting from pod:
.. s/B<\([^>]*\)>/**\1**/g
.. s/I<\([^>]*\)>/*\1*/g

=============
ncursesoflife
=============

---------------------------------------
console Conway's Game of Life simulator
---------------------------------------

:Manual section: 6
:Manual group: SlackBuilds.org
:Date: |date|
:Version: |version|

SYNOPSIS
========

ncursesoflife

DESCRIPTION
===========

ncursesoflife is a simple Conway's Life simulator, with the ability
to draw your own patterns and run the simulation one step at a time
or continuously.

There are no command-line options or arguments.

CONTROLS
========

SIM stage:

**p**
     play/pause

**n**
     step

**+**
     faster

**-**
     slower

**q**
     quit

WHEN PAUSED:

**w** **a** **s** **d**, **arrow keys**
     move

**space**
     toggle cell

Game starts out paused.  All SIM keystrokes will work when paused (step only works paused).  

AUTHORS
=======

ncursesoflife was written by AftExploision.

This man page written for the SlackBuilds.org project
by B. Watson, and is licensed under the WTFPL.

SEE ALSO
========

The ncursesoflife homepage: https://github.com/AftExploision/NcursesOfLife
