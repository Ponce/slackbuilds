.. RST source for archmage(1) man page. Convert with:
..   rst2man.py archmage.rst > archmage.1
.. rst2man.py comes from the SBo development/docutils package.

.. |version| replace:: 0.4.2.1
.. |date| date::

========
archmage
========

---------------------------------------
convert CHM to PDF, HTML, or plain text
---------------------------------------

:Manual section: 1
:Manual group: SlackBuilds.org
:Date: |date|
:Version: |version|

SYNOPSIS
========

archmage [*-options*] **chmfile** [**destdir** | **destfile**]

DESCRIPTION
===========

**archmage** converts CHM files to HTML, plain text and PDF. CHM is the
format used by Microsoft HTML Help, also known as Compiled HTML.

OPTIONS
=======

-x, --extract
  Extracts CHM file into specified directory. If destination
  directory is omitted, then a new one will be created based
  on the name of the CHM file. This option is the default.

-c, --convert=format
  Convert CHM file into specified file format. If destination
  file is omitted, the output filename will be created based on
  the name of the CHM file. Available formats::

     html - Single HTML file
     text - Plain text file (uses lynx(1) or elinks(1))
     pdf - Adobe PDF

-d, --dump
  Dump HTML data from CHM file to standard output.

-V, --version
  Print version number and exit.

-h, --help
  Print help message and exit.

COPYRIGHT
=========

See the file /usr/doc/archmage-|version|/COPYING for license information.

AUTHORS
=======

archmage was written by dottedmag.

This man page written for the SlackBuilds.org project
by B. Watson, and is licensed under the WTFPL.

SEE ALSO
========

The archmage homepage: https://github.com/dottedmag/archmage
