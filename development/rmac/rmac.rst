.. RST source for rmac(1) man page. Convert with:
..   rst2man.py rmac.rst > rmac.1
.. rst2man.py comes from the SBo development/docutils package.

.. |version| replace:: 2.2.14_20221221
.. |date| date::

====
rmac
====

------------------------------
68000 and 6502 cross assembler
------------------------------

:Manual section: 1
:Manual group: SlackBuilds.org
:Date: |date|
:Version: |version|

SYNOPSIS
========

rmac [*-options*] *source-file* [*source-file ...*]

DESCRIPTION
===========

RMAC began its life as MADMAC. It was initially written at Atari
Corporation by programmers who needed a high performance assembler for
their work. Then, more than 20 years later, because there was still a need
for such an assembler and what was available wasn't up to expectations,
Subqmod and eventually Reboot continued work on the freely released
source, adding Jaguar extensions and fixing bugs. And of course recently
6502 support was added back!

OPTIONS
=======

-dname\ *[=value]*   Define symbol, with optional value.

-e\ *[file[.err]]*   Direct error messages to the specified file.

-fa                  ALCYON output object file format (implied when **-p** or **-ps** is enabled).

-fb                  BSD COFF output object file format.

-fe                  ELF output object file format.

-fr                  Absolute address. Source is required to have only one **.org**.

-fx                  Atari 800 com/exe/xex output object file format.

-g                   Generate source level debug info. Requires BSD COFF object file format.

-i\ *path*           Set include-file directory search path. *Note* this is a
                     **semicolon** separated list of directories.

-l\ *[file[prn]]*    Construct and direct assembly listing to the specified file.

-l\ *\*[filename]*   Create an output listing file without pagination.

-m\ *cpu*            Set default CPU type. Choices are: **68000** **68020**
                     **68030** **68040** **68060** **68881** **68882**
                     **56001** **6502** **tom** **jerry**

-n                   Don't do things behind your back in RISC assembler.

-o\ *file[.o]*       Direct object code output to the specified file.

+/~oall              Turn all optimisations on/off

+o\ *0-30*           Enable specific optimisation

~o\ *0-30*           Disable specific optimisation

                      `0: Absolute long adddresses to word (default: on)`
                      
                      `1: move.l #x,dn/an to moveq (default: on)`

                      `2: Word branches to short (default: on)`
                      
                      `3: Outer displacement 0(an) to (an) (default: on)`                      
                      `4: lea size(An),An to addq #size,An (default: off)`                      
                      `5: 68020+ Absolute long base displacement to word (default: off)`

                      `6: Convert null short branches to NOP`

                      `7: Convert clr.l Dn to moveq #0,Dn`

                      `8: Convert adda.w/l #x,Dy to addq.w/l #x,Dy`

                      `9: Convert adda.w/l #x,Dy to lea x(Dy),Dy`

                      `10: 56001 Use short format for immediate values if possible`

                      `11: 56001 Auto convert short addressing mode to long (default: on)`

                      `30: Enforce PC relative (alternative name: op)`

-p                   Produce an executable (**.prg**) output file.

-ps                  Produce an executable (**.prg**) output file with symbols.

-q                   Make RMAC resident in memory (Atari ST only).

-r *size*            automatically pad the size of each
                     segment in the output file until the size is an integral multiple of the
                     specified boundary. Size is a letter that specifies the desired boundary.
					 
                      `-rw Word (2 bytes, default alignment)`

                      `-rl Long (4 bytes)`

                      `-rp Phrase (8 bytes)`
                      
                      `-rd Double Phrase (16 bytes)`
                      
                      `-rq Quad Phrase (32 bytes)`

-s                   Warn about unoptimized long branches and applied optimisations.

-u                   Force referenced and undefined symbols global.

-v                   Verbose mode (print running dialogue).

-x                   Turn on debugging mode

-yn                  Set listing page size to n lines.

-4                   Use C style operator precedence.

file\ *[s]*          Assemble the specified file.

FILES
=====

  /usr/share/rmac/atari.s
    Atari ST system equates.

ENVIRONMENT
===========

  RMACPATH
    Semicolon-separated list of directories to search for include files.

AUTHORS
=======

rmac is Copyright (C) 199x Landon Dyer, 2011-2017 Reboot.

This man page written for the SlackBuilds.org project
by B. Watson, and is licensed under the WTFPL.

SEE ALSO
========

*hatari*\ (1)

The full **rmac** documentation: /usr/doc/rmac-|version|/rmac.html
