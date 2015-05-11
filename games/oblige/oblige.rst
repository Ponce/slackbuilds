.. RST source for oblige(6) man page. Convert with:
..   rst2man.py oblige.rst > oblige.6
.. rst2man.py comes from the SBo development/docutils package.

.. |version| replace:: 6.20
.. |date| date::

======
oblige
======

-------------------------------------------
random level generator for Doom and Doom II
-------------------------------------------

:Manual section: 6
:Manual group: SlackBuilds.org
:Date: |date|
:Version: |version|

SYNOPSIS
========

oblige [*-options*]

DESCRIPTION
===========

**oblige** creates a patch WAD file for use with Doom or Doom II,
containing one or more randomly-generated levels. The generated WAD
files are ready to play (no separate node-building pass is needed).

Normally, **oblige** is controlled by its GUI, but it can be used
noninteractively (see the **-b** option below).

OPTIONS
=======

--home <dir>
  Home directory, where B<oblige> looks for its config file, and creates
  temporary files. Default is *~/.oblige*.

--install <dir>
  Installation directory, where **oblige** looks for lua scripts and other
  data. Default is */usr/share/oblige*.

--config <file>

  Config file to use. Default is *~/.oblige/CONFIG.txt*. Not used in
  **--batch** mode.

--batch, **-b** *<output>*
  Batch mode (no GUI). Uses built-in default config (never reads the
  normal config file used by the GUI), but the **--load** option can be
  used to override the defaults. *output* will be a PWAD file and will
  be overwritten without prompting if it exists.

--load, **-l** *<file>*
  Load settings from a file. This is in the same format as
  *~/.oblige/CONFIG.txt*, and any settings in the loaded file will override
  the ones there. In **--batch** mode, "**--load ~/.oblige/CONFIG.txt**"
  will generate levels according to the settings configured by the GUI.

--keep, -k
  Keep random seed from loaded settings. Normally the seed stored in the
  config file is ignored, and a new seed is generated.

--debug, -d
  Enable verbose debugging messages in log.

--terminal, -t
  Print log messages to stdout (rather than *~/.oblige/LIGS.txt*). Disabled
  by default, unless in **--batch** mode.

--help, -h
  Show built-in help message.

.. other sections we might want, uncomment as needed.

.. FILES
.. =====

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

See the file /usr/doc/oblige-|version|/GPL.txt for license information.

AUTHORS
=======

**oblige** is (c) 2006-2015 by Andrew Apted.

This man page written for the SlackBuilds.org project
by B. Watson, and is licensed under the WTFPL.

SEE ALSO
========

`oblige-legacy4(6)`, an older version of **oblige** with a simpler
level-generation algorithm and support for other games including Heretic,
Hexen, and Quake.

The **oblige** home page: http://oblige.sourceforge.net
