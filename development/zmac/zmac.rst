.. RST source for zmac(1) man page. Convert with:
..   rst2man.py zmac.rst > zmac.1

.. |version| replace:: 20221018_0.7
.. |date| date::

====
zmac
====

--------------------------
Z-80 macro cross-assembler
--------------------------

:Manual section: 1
:Manual group: SlackBuilds.org
:Date: |date|
:Version: |version|

SYNOPSIS
========

**zmac** [*--help*] [*--version*] [*--dep*] [*--mras*] [*--od dir*] [*--oo sfx1,sfx2*] [*--xo sfx1,sfx2*] [*--dri*] [*--rel*] [*--rel7*] [*--nmnv*] [*--z180*] [*--fcal*] [*--doc*] [*--zmac*] [*-8bcefghijJlLmnopstz*] [*filename[.z]*]

DESCRIPTION
===========

zmac is a Z-80 macro cross-assembler. It has all the features you'd
expect. It assembles the specified input file (with a '.z' extension
if there is no pre-existing extension and the file as given doesn't
exist) and produces program output in many different formats. It also
produces a nicely-formatted listing of the machine code and cycle
counts alongside the source in a ".lst" file.

To reduce clutter and command line option usage, by default all zmac
output is put into an (auto-created) zout subdirectory. For file.z
the listing will be in zout/file.lst, the TRS-80 executable format
in zout/file.cmd and so on. For more friendly usage in make files
and integrated development environments the -o, --oo, --xo and --xd
options may be used to select specific output file formats and where
they are written.

Undocumented Z-80 instructions are supported as well as 8080 and Z-180
(aka HD64180).

zmac strives to be a powerful assembler with expressions familiar to C
programmers while providing good backward compatibility with original
assemblers such as Edtasm, MRAS and Macro-80.

This man page only documents the command-line options. The full documentation can be found here:
/usr/doc/zmac-|version|/zmac.html

OPTIONS
=======

Space-separated arguments in the ZMAC_ARGS environment variable are added to the
end of the command line.


--help           Display a list of options and a terse description of what the
                 options do.

--version        Print zmac version name.

--mras           MRAS compatibility mode. Any ? in a label will be expanded to
                 the current module identifier as set by \*mod. Operator
                 precedence and results are changed.

--od dir         Place output files in dir instead of the default "zout"
                 subdirectory. Creates dir if necessary.

--oo hex,cmd
                 Output only the the file types by suffix. Multiple --oo
                 arguments may be used. "--oo lst,cas" is equivalent to "--oo
                 lst --oo cas". See "Output Formats" for a list of output types
                 by suffix.

--xo tap,wav
                 Do not output the file type types listed by suffix.

--dri            Enable compatibility with Digital Research (CP/M) assemblers:
                 Ignores dollar signs in constants and symbols. Silences a
                 warning when using Z80.LIB. Allows the use of '*' in first
                 column for comment lines. Accepts $-MACRO directives.

--nmnv           Do not interpret Z-80 or 8080 mnemonics as values in
                 expressions.

--rel            Output ".rel" (relocatable object file) format only. Exported
                 symbols are truncated to length 6.

--rel7           Output ".rel" (relocatable object file) format only. Exported
                 symbols are truncated to length 7.

--zmac           zmac compatibility mode. defl labels are undefined after each
                 pass. Quotes and double quotes are stripped from macro
                 arguments before expansion. $ is ignored in identifiers
                 allowing foo$bar to construct identifiers in macro expansions.
                 Use ` (backquote) instead in normal mode. Labels starting with
                 "." are temporary and are reset whenever a non-temporary label
                 is defined (thus they may be reused). Labels starting with "_"
                 are local to their file thus avoid multiple definition when
                 brought in with include.

--z180           Use Z-180 timings and extended instructions. Undocumented Z-80
                 instructions will generate errors as the Z-180 (or H64810) does
                 not support them. Equivalent to .z180 pseudo-op.

--dep            Print all files read by include, incbin and import.

--doc            Print full documentation in HTML format to standard output.

-Pk=number
                 Set @@k to the given numeric value before assembly. Up to 10
                 parameters can be set from 0 though 9. -Pk is shorthand for
                 -Pk=-1. For example, P4=$123 effectively puts @@4 equ $123 at
                 the top of the first file.

-Dsymbol         Define symbol to be 1 before assembly.

--fcal           Always treat an indentifier in the first column as a label.
                 zmac uses various heuristics in the case of ambiguity when a
                 label does not have a colon. This option turns heuristics off.

-8               Accept 8080 mnemonics preferentially and use 8080 instruction
                 timings. Equivalent to .8080 pseudo-op.

-b               Don't generate any machine code output at all.

-c               Don't display cycle counts in the listing.

-e               Omit the "error report" section in the listing.

-f               List instructions not assembled due to "if" expressions being
                 false. (Normally these are not shown in the listing.)

-g               List only the first line of equivalent hex for a source line.

-h               Display a list of options and a terse description of what the
                 options do. (same as --help)

-i               Don't list files included with include, read or import.

-I dir           Add dir to the end of the include file search path.

-j               Promote relative jumps and DJNZ to absolute equivalents as
                 needed.

-J               Error if an absolute jump could be replaced with a relative
                 jump.

-l               List to standard output.

-L               Generate listing no matter what. Overrides any conflicting
                 options.

-m               List macro expansions.

-n               Omit line numbers from listing.

-o filename.cmd
                 Output only the named file. Multiple "-o" options can be used
                 to name a set of different files.

-p               Use a few linefeeds for page break in listing rather than ^L.

-P               Output listing for a printer with headers, multiple symbols per
                 column, etc.

-s               Omit the symbol table from the listing.

-t               Only output number of errors instead list of each one.

-z               Accept Z-80 mnemonics preferentially and use Z-80 instruction
                 timings. Equivalent to .z80 pseudo-op.

LICENSE
=======

**CC0**

To the extent possible under law, George Phillips has waived all copyright
and related or neighboring rights to zmac macro cross assembler for the Zilog
Z-80 microprocessor. This work is published from: Canada.

AUTHORS
=======

Bruce Norskog originally wrote zmac in 1978.

Updates and bugfixes over the years by John Providenza, Colin Kelley, and more
recently by Russell Marks, Mark RISON, Chris Smith, Matthew Phillips and Tim
Mann.

Extensive modifications for cycle counting, multiple output formats, ".rel"
output, 8080 mode and older assembler compatibilty were written by George
Phillips.

This man page written for the SlackBuilds.org project
by B. Watson, and is licensed under the WTFPL.

SEE ALSO
========

**ld80**\(1)

The zmac homepage: http://48k.ca/zmac.html
