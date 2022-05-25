.. RST source for epy(1) man page. Convert with:
..   rst2man.py epy.rst > epy.1
.. rst2man.py comes from the SBo development/docutils package.

.. |version| replace:: 2022.4.18
.. |date| date::

===
epy
===

---------------------
terminal ebook reader
---------------------

:Manual section: 1
:Manual group: SlackBuilds.org
:Date: |date|
:Version: |version|

SYNOPSIS
========

epy [-h] [-r] [-d] [-v] [PATH | # | PATTERN | URL]

DESCRIPTION
===========

**epy** is an ebook reader that runs in a terminal. It supports
**epub**, **fb2**, **mobi**, **azw**, and **azw3** formatted books,
plus it's able to view HTML, given a URL. **epy** only displays text,
not images.

OPTIONS
=======

-r, --history
                Print reading history.

-d, --dump      Dump the content of an ebook on standard output.

-v, --version   Output version number.

-h, --help
                Output usage string.

FILES
=====

/usr/doc/epy-|version|/README.md is the complete documentation for **epy**.

~/.config/epy/ contains the config file, **configuration.json**, and the
reading history database, **states.db**.

COPYRIGHT
=========

See the file /usr/doc/epy-|version|/LICENSE for license information.

AUTHORS
=======

epy was written by Benawi Adha.

This man page written for the SlackBuilds.org project
by B. Watson, and is licensed under the WTFPL.

SEE ALSO
========

The epy homepage: http://www.epy.org/
