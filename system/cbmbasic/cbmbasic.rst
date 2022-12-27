.. RST source for cbmbasic(1) man page. Convert with:
..   rst2man.py cbmbasic.rst > cbmbasic.1
.. rst2man.py comes from the SBo development/docutils package.

.. |version| replace:: 1.0+20221218_352a313
.. |date| date::

========
cbmbasic
========

--------------------------------------------
port of Commodore 64 BASIC to modern systems
--------------------------------------------

:Manual section: 1
:Manual group: SlackBuilds.org
:Date: |date|
:Version: |version|

SYNOPSIS
========

**cbmbasic**

**cbmbasic** *program.bas*

DESCRIPTION
===========

**cbmbasic** is a 100% compatible version of Commodore's version of
Microsoft BASIC 6502 as found on the Commodore 64. You can use it in
interactive mode or pass a BASIC file as a command line parameter.

**cbmbasic** does not emulate 6502 code; all code is completely native. On a 1 GHz CPU you get about 1000x speed compared to a 1 MHz 6502.

There are no command-line options.

USAGE
=====

You can use **cbmbasic** in interactive mode by just running the binary
without parameters, or you can specify an ASCII-encoded BASIC program
on the command line. You can also use **cbmbasic** as a UNIX scripting
language by adding a hashbang line to your BASIC program and making
it executable::

    $ ls -l hello.bas
    -rwxr-xr-x  1 mist  staff  40  7 Apr 21:30 hello.bas
    $ cat hello.bas
    #!/usr/bin/env cbmbasic
    PRINT"HELLO WORLD!"
    $ ./hello.bas
    HELLO WORLD!

**cbmbasic** implements a small plugin system that lets developers add
additional statements, functions etc. Right now, you can turn this on
with **SYS 1** (turn off with **SYS 0**) and use the new statements
LOCATE *y*, *x* (set cursor position), SYSTEM *string* (run shell
command) and the extended WAIT *port*, *mask*, which implements the
Bill Gates easter egg.

AUTHORS
=======

**cbmbasic** was ported by Michael Steil and James Abbatiello. The
original 6502 version was written by Microsoft.

This man page written for the SlackBuilds.org project
by B. Watson, and is licensed under the WTFPL.

SEE ALSO
========

The cbmbasic homepage: https://github.com/mist64/cbmbasic
