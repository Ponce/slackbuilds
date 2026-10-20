.. RST source for fsv(1) man page. Convert with:
..   rst2man.py fsv.rst > fsv.1

.. |version| replace:: 3.0
.. |date| date::

===
fsv
===

------------------------
3D filesystem visualizer
------------------------

:Manual section: 1
:Manual group: SlackBuilds.org
:Date: |date|
:Version: |version|

SYNOPSIS
========

fsv [*rootdir*] [*-options*]

DESCRIPTION
===========

**fsv** (pronounced eff-ess-vee) is a file system visualizer in cyberspace. It
lays out files and directories in three dimensions, geometrically
representing the file system hierarchy to allow visual overview and
analysis. **fsv** can visualize a modest home directory, a workstation's
hard drive, or any arbitrarily large collection of files, limited only
by the host computer's memory and graphics hardware.

**fsv** is a clone of SGI's **fsn**, which was featured in the movie Jurassic Park.

Full documentation is available via the Help -> Contents menu option, or
in /usr/doc/fsv-|version|/html/fsv.html

OPTIONS
=======

**rootdir**
  Root directory for visualization (defaults to current directory)

--mapv
  Start in MapV mode (default)

--treev
  Start in TreeV mode

--help
  Print built-in help and exit

AUTHORS
=======

**fsv** was originally written by Daniel Richard G. <skunk@mit.edu>.

**fsv** is now maintained by Janne Blomqvist: https://github.com/jabl

This man page written by B. Watson for the SlackBuilds.org project and
released under the WTFPL.
