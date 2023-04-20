.. RST source for acefile-unace(1) man page. Convert with:
..   rst2man.py acefile-unace.rst > acefile-unace.1

.. |version| replace:: 0.6.12
.. |date| date::

=============
acefile-unace
=============

------------------------------
extract/view/test ACE archives
------------------------------

:Manual section: 1
:Manual group: SlackBuilds.org
:Date: |date|
:Version: |version|

SYNOPSIS
========

**acefile-unace** [**-h**] [**-V**] [**-x** | **-t** | **-l** |
**--extract** | **--test** | **--list** | **--headers**] [**-d**
*directory*] [**-p** *password*] [**-r** | **--restore**] [**-b** |
**-batch**] [**--debug**] **ace-file** [**file(s)**]

DESCRIPTION
===========

**acefile-unace** extracts, views, or tests **ACE** archives, such
as those created by WinACE. It does not allow creating or writing to
archives.

**acefile-unace** supports up to version 2.0 of the ACE archive
format, including the EXE, DELTA, PIC and SOUND modes of ACE 2.0,
password protected archives, and multi-volume archives.

The **ace-file** argument is required. With no options, the default is to
extract all files within **ace-file** to the current directory.

OPTIONS
=======

-h, --help
  Show built-in help message and exit.

-V, --version
  Show version number and exit.

--extract, -x
  Extract files in archive (default).

--test, -t
  Test archive integrity.

--list, -l
  List files in archive.

--headers
  Dump archive headers.

-d directory, --basedir directory
  Base directory for extraction (default: current directory).

-p password, --password password
  Password for decryption.

-r, --restore
  Restore mtime/atime, attribs and ntsecurity on extraction.

-b, --batch
  Suppress all interactive input.

-v, --verbose
  Be more verbose.

--debug
  Show mode transitions and expose internal exceptions.

COPYRIGHT
=========

See the file /usr/doc/acefile-unace-|version|/LICENSE.md for license information.

AUTHORS
=======

**acefile-unace** was written by Daniel Roethlisberger.

This man page written for the SlackBuilds.org project
by B. Watson, and is licensed under the WTFPL.

SEE ALSO
========

The acefile-unace homepage: https://pypi.org/project/acefile/
