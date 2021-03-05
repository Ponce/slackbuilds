.. RST source for lddsafe(1) man page. Convert with:
..   rst2man.py lddsafe.rst > lddsafe.1
.. rst2man.py comes from the SBo development/docutils package.

.. |version| replace:: 20110819_02842ba
.. |date| date::

=======
lddsafe
=======

---------------------------------------------------------
safely print shared library dependencies (similar to ldd)
---------------------------------------------------------

:Manual section: 1
:Manual group: SlackBuilds.org
:Date: |date|
:Version: |version|

SYNOPSIS
========

lddsafe [*-n*] **FILE** ...

DESCRIPTION
===========

lddsafe is a shell script written for Linux distributions (tested
under Slackware Linux) that prints shared library dependencies for
executable files and shared libraries, similar to ldd. However,
it uses objdump instead of loading the program, hence avoiding the
security problems of ldd.

OPTIONS
=======

-n     Nonrecursive mode. List direct dependencies only.

AUTHORS
=======

lddsafe was written by Ricardo Garcia Gonzalez and Ivan Mironov, and
released as public domain code.

This man page written for the SlackBuilds.org project
by B. Watson, and is licensed under the WTFPL.

SEE ALSO
========

The lddsafe homepage: https://github.com/rg3/lddsafe/
