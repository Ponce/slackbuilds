.. RST source for crc32_simple(1) man page. Convert with:
..   rst2man.py crc32_simple.rst > crc32_simple.1
.. rst2man.py comes from the SBo development/docutils package.

.. |version| replace:: 20120911
.. |date| date::

.. converting from pod:
.. s/B<\([^>]*\)>/**\1**/g
.. s/I<\([^>]*\)>/*\1*/g

============
crc32_simple
============

---------------------------------
calculate standard crc32 checksum
---------------------------------

:Manual section: 1
:Manual group: SlackBuilds.org
:Date: |date|
:Version: |version|

SYNOPSIS
========

crc32_simple [filenames]

DESCRIPTION
===========

Simple public domain implementation of the standard CRC32 checksum.
Outputs the checksum for each file given as a command line argument.
Invalid file names and files that cause errors are silently skipped.
The program reads from stdin if it is called with no arguments.

AUTHORS
=======

crc32_simple was written by Björn Samuelsson.

This man page written for the SlackBuilds.org project
by B. Watson, and is licensed under the WTFPL.
