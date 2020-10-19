.. RST source for cr3(1) man page. Convert with:
..   rst2man.py cr3.rst > cr3.1
.. rst2man.py comes from the SBo development/docutils package.

.. Note to SBo admins: Please don't include this file in the doc dir
.. in the package. It's here because it's the source for the man page.

.. |version| replace:: 3.2.49
.. |date| date::

===
cr3
===

--------------------------
coolreader (e-book reader)
--------------------------

:Manual section: 1
:Manual group: SlackBuilds.org
:Date: |date|
:Version: |version|

SYNOPSIS
========

cr3 [*-options*] [filename]

DESCRIPTION
===========

CoolReader is an e-book reader for various platforms.

Supported file formats include plain text, HTML, RTF, Microsoft Word
(.doc), Palm Pilot (.prc, .pdb, .pml, .mobi), FB2, and EPUB.

OPTIONS
=======

--version   Output version number.

-?, -h, --help
            Output usage string.

--loglevel=ERROR|WARN|INFO|DEBUG|TRACE
            Set logging level.

--logfile=<filename>|stdout|stderr
            Set log file. Default is stderr.

FILES
=====

~/.cr3/
   Per-user configuration, cache, and bookmarks. It's not recommended to
   edit **cr3.ini** by hand.

COPYRIGHT
=========

See the file /usr/doc/coolreader-|version|/COPYING for license information.

AUTHORS
=======

cr3 was written by Vadim Lopatin, aka buggins.

This man page written for the SlackBuilds.org project
by B. Watson, and is licensed under the WTFPL.

SEE ALSO
========

The cr3 homepage: https://github.com/buggins/coolreader
