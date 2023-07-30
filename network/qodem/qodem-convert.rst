.. RST source for qodem-convert(1) man page. Convert with:
..   rst2man.py qodem-convert.rst > qodem-convert.1

.. |version| replace:: 1.0.1
.. |date| date::

=============
qodem-convert
=============

-----------------------------------------
convert BBS dialing lists to qodem format
-----------------------------------------

:Manual section: 1
:Manual group: SlackBuilds.org
:Date: |date|
:Version: |version|

SYNOPSIS
========

qodem-convert-syncterm **input.lst** **output.txt**

qodem-convert-ibbs **input.txt** **output.txt**

DESCRIPTION
===========

These utilities convert BBS dialing lists to the **fonebook.txt**
format used by **qodem**\(1).

To convert a **syncterm**\(1) list, use a command like::

  qodem-convert-syncterm ~/.syncterm/syncterm.lst ~/.qodem/fonebook.txt

To convert the telnetbbsguide list, first download it from::

  https://www.telnetbbsguide.com/lists/download-list/

Get either the Monthly or Daily zip file. Extract it, and find the
"short form" list, which will have a filename like **short_Jul_23.txt**.
Use a command like::

  qodem-convert-ibbs short_Jul_23.txt ~/.qodem/fonebook.txt

COPYRIGHT
=========

Public Domain, or CC0 License in jurisdictions that do not recognize
the public domain.

AUTHORS
=======

**qodem**, **qodem-convert-syncterm**, and **qodem-convert-ibbs** were
written by Autumn Lamonte.

This man page written for the SlackBuilds.org project
by B. Watson, and is licensed under the WTFPL.

SEE ALSO
========

**qodem**\(1), **qodem-x11**\(1), **syncterm**\(1)

The qodem homepage: https://qodem.sourceforge.io/
