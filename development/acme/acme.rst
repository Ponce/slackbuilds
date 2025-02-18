.. RST source for acme(1) man page. Convert with:
..   rst2man.py acme.rst > acme.1

.. |version| replace:: 0.97+20250126_r434
.. |date| date::

====
acme
====

--------------------------------
6502/65c02/65816 cross assembler
--------------------------------

:Manual section: 1
:Manual group: SlackBuilds.org
:Date: |date|
:Version: |version|

SYNOPSIS
========

acme [*-options*] *FILE* ...

DESCRIPTION
===========

**acme** is a cross assembler for the 65xx range of processors. It knows
about the standard 6502, the 65c02 and the 65816. It also supports
the undocumented ("illegal") opcodes of the NMOS versions of the 6502,
like the 6510 variant that is used in the Commodore C=64, and it also
supports extensions to the intruction set done by other parties.

The full documentation for **acme** is installed in:

  /usr/doc/acme-|version|

Start with **Help.txt**. This man page just lists the command-line options.

Note: the **ACME** environment variable is not required in this build
of **acme**. If set, it will be respected, but if it's not set, the
assembler will look for include files in **/usr/share/acme/ACME_Lib**\.

OPTIONS
=======

-h, --help
    show this help and exit

-f,--format *FORMAT*
    set output file format

-o,--outfile *FILE*
    set output file name

-r,--report *FILE*
    set report file name

-l,--symbollist *FILE*
    set symbol list file name

--labeldump
    old name for --symbollist

--vicelabels *FILE*
    set file name for label dump in VICE format

--setpc *VALUE*
    set program counter

--from-to *VALUE* *VALUE*
    set start and end+1 of output file

--cpu *CPU*
  set target processor

--initmem *VALUE*
  define 'empty' memory

--maxerrors *NUMBER*
  set number of errors before exiting

--maxdepth *NUMBER*
  set recursion depth for macro calls and !src

--ignore-zeroes
  do not determine number size by leading zeroes

--strict-segments     turn segment overlap warnings into errors

--strict              treat all warnings like errors

**-v0** *through* **-v9**
  set verbosity level. no space allowed between **-v** and the number.

-D *SYMBOL=VALUE*
   define global symbol

-I *PATH/TO/DIR*
   add search path for input files

-Wno-label-indent         suppress warnings about indented labels

-Wno-old-for              (old, use "--dialect 0.94.8" instead)

-Wno-bin-len              suppress warnings about lengths of binary literals

-Wtype-mismatch           enable type checking (warn about type mismatch)

--use-stdout          fix for 'Relaunch64' IDE (see docs)

--msvc                output errors in MS VS format

--color               use ANSI color codes for error output

--fullstop            use '.' as pseudo opcode prefix

--dialect *VERSION*
  behave like different version

--debuglevel *VALUE*
 drop all higher-level debug messages

--test
  enable experimental features

-V, --version
  show version and exit

COPYRIGHT
=========

See the file /usr/doc/acme-|version|/COPYING for license information.

AUTHORS
=======

acme was written by Marco Baye.

This man page written for the SlackBuilds.org project
by B. Watson, and is licensed under the WTFPL.

SEE ALSO
========

**toacme**\(1)

The acme homepage: https://sourceforge.net/projects/acme-crossass/
