.. RST source for dis(1) man page. Convert with:
..   rst2man.py dis.rst > dis.1
.. rst2man.py comes from the SBo development/docutils package.

.. |version| replace:: 0.6
.. |date| date::

===
dis
===

------------------------------------------
dis - statically tracing 6502 disassembler
------------------------------------------

:Manual section: 1
:Manual group: SlackBuilds.org
:Date: |date|
:Version: |version|

SYNOPSIS
========

dis [*-options*] file ...

DESCRIPTION
===========

dis creates XASM/MADS-compatible assembly code from a memory dump or
an executable. dis statically traces execution paths starting from
code entry points to mark which memory locations contain code. All
other memory is treated as data. dis traces through JMP, JSR and BXX
branch instructions. It stops at RTS, RTI and illegal instructions.

dis automatically determines common code entry points when
disassembling Atari XEX/SAP files and Commodore 64 PRG files.

The disassembly is written to standard output.

OPTIONS
=======

*-c* **L=XXXX**
  Code entry point(s)

*-d* **L=XXXX**
  Data location(s) - Disallow tracing as code

*-C* **L=XXXX**
  Constant value(s)

*-v* **L=XXXX**
  Vector(s), e.g. FFFA

*-A* **L=XXXX**
  Data address(es)

*-P* **L=XXXX**
  Code address(es) - Trace target as code

*-o* **L=XXXX**
  Origin for raw files

*-l*
  Create labels

*-i*
  Emit illegal opcodes

*-t* **TYPE**
  Disassemble as TYPE::

           xex - Atari executable (-x)
           sap - Atari SAP file
           prg - Commodore 64 executable (-p)
           raw - raw memory

*-x*
  Disassemble as Atari executable (same as **-t xex**)

*-p*
  Disassemble as Commodore 64 executable (same as **-t prg**)

*-comment*
  Emit comments

*-call*
  Emit callers

*-access*
  Emit accessors

*-extern*
  Emit labels for out-of-range addresses

*-rangelabels*
  Emit labels for ranges instead of base+offset

*-verbose*
  Print info to STDERR

*-dump*
  Print options in format for -a

*-dumpequ*
  Print equ statements for all labels

*-headers*
  Print opt h- if disabled with -noheaders

*-a* **FILE**
  Read options from FILE. Lines are: OPTION VALUE. If **FILE**
  is not found, it will be searched for in **/usr/share/dis** instead.

Addresses may include a range, e.g. table=$300+F

Addresses may include xex segment number, e.g. 3:1FAE

Addresses for -A and -P may be given as HIGH_LOW, e.g. 3C64_3C62

FILES
=====

**/usr/share/dis/\*.dop**
  Predefined option files for various platforms, for use with *-a*.
  These include:

    sys.dop, hardware.dop: for use with Atari 8-bit object code.

    6510.dop, cia.dop, sid.dop, vic.dop: for use with Commodore 64 object code.

COPYRIGHT
=========

See the file /usr/doc/dis-|version|/LICENSE.md for license information.

AUTHORS
=======

dis was written by Lyren Brown.

This man page written for the SlackBuilds.org project
by B. Watson, and is licensed under the WTFPL.

SEE ALSO
========

The full documentation for **dis**::

  /usr/doc/dis-0.6/README.md

The AtariAge thread::

  http://atariage.com/forums/topic/232658-statically-tracing-6502-disassembler/
