.. RST source for vera(6) man page. Convert with:
..   rst2man.py vera.rst > vera.6
.. rst2man.py comes from the SBo development/docutils package.

.. |version| replace:: 1.24
.. |date| date::

====
vera
====

-------------------------------------
look up acronyms in the VERA database
-------------------------------------

:Manual section: 6
:Manual group: SlackBuilds.org
:Date: |date|
:Version: |version|

SYNOPSIS
========

vera *acronym* ...

DESCRIPTION
===========

**vera** looks up one or more acronyms in the VERA acronym
database. Example::

  $ vera ianal
  IANAL
       I Am Not A Lawyer (slang, Usenet, IRC)

There are no options.

FILES
=====

*/usr/share/info/vera.info.gz* - the acronym database. Can
be browsed with the command *info vera*.

AUTHORS
=======

The *vera* command was written by Andres Soolo.

This man page written for the SlackBuilds.org project
by B. Watson, and is licensed under the WTFPL.

SEE ALSO
========

*wtf*\(6)

/usr/doc/vera-|version|/README

/usr/doc/vera-|version|/vera.html
