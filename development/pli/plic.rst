.. RST source for plic(1) man page. Convert with:
..   rst2man.py plic.rst > plic.1
.. rst2man.py comes from the SBo development/docutils package.

.. This is mostly copypasta from prog_guide.html, with a bit
.. of commentary explaining things that aren't entirely clear.

.. |version| replace:: 0.9.10d
.. |date| date::

====
plic
====

---------------------------------------
Iron Spring PL/I Compiler for x86 Linux
---------------------------------------

:Manual section: 1
:Manual group: SlackBuilds.org
:Date: |date|
:Version: |version|

SYNOPSIS
========

plic [*options*] <input-files> [*-o* output-file]

DESCRIPTION
===========

**plic** is a compiler for the PL/I language.

This man page doesn't attempt to fully document **plic**. It's just
intended as a reference for the command-line options and arguments.
For full documentation, see: /usr/doc/pli-|version|/prog_guide.html

...and the other HTML and PDF documents found in the same directory.

One major difference between **plic** and other compilers for other
languages you may have used: **plic** doesn't link executables
nor call **ld**\(1) to link them as e.g. **gcc**\(1) does. **plic**
produces object files (named with *.o* extension), which must then be
linked with a separate **ld** command. The full documentation explains
this, and there is also a sample Makefile for building a simple
PL/I application, found in: /usr/doc/pli-|version|/samples/SA_make

The **pli** SlackBuilds.org package also includes a **plicl** wrapper
script, which does compiling and linking in one step, at least for
simple PL/I programs. It has its own man page.

OPTIONS
=======

-V
  Print version and copyright info to stderr (not stdout!) and exit.

-S
  Generate assembler (symbolic) output. Default output filename is
  the input filename with the extension changed to *.asm* (use **-o** to
  change it).

-C
  Generate compiled (object code) output. Default object filename is
  the input filename with the extension changed to *.o* (use **-o** to
  change it). A listing file (extension *.lst*) is also created. This
  option should always be used when compiling; without it, **plic**
  still generates an object file, but confusingly, its extension will
  be *.exe*, and no *.lst* file will be created.

-N
  Generate statement number tables to provide information for run-time
  error messages.

**-o** *file*
  Set the output filename. The space between the option and argument
  is optional.

**-i** *directory*
  Use *directory* as the absolute or relative path to a directory to
  be searched for %INCLUDE files. This option may be used more than once on the
  command line, and directories will be searched in the order listed.
  The space between the option and argument is optional. Note that
  you must use **-i .** if you want to search for include files in the
  current directory.

**-l[saxgmov]**
  Listing options. One or more of [saxgmov] may be entered, in any 
  order, e.g. **-lsx**.

  -ls
    list source

  -la
    list attributes

  -lx
    list cross-reference

  -lg
    list aggregates

  -lm
    list generated code in a format similar to a disassembly.

  -lo
    list procedure map (statement offset table)
  -lv
    list additional warning messages

**-m(start[,end])**
  This option defines the first and last positions of each
  input line that contain input for the compiler. If this
  option is omitted the source is assumed to be the entire line.
  This option is included for compatibility with mainframe compilers
  which would use, for example, -m(2,72).

**-cn(<list>)**, **-co(<list>)**
  These options define up to four characters each to be used as
  substitutions for the NOT(¬) [-cn()] and/or OR(|) [-co()]
  operator IN ADDITION TO the defaults. Parentheses are metacharacters
  in most Linux shells, so quote these options with either single- or
  double-quotes.

**-e[wsd]**
  Error options. Can be combined, e.g. -ewd. Normally, the compiler's
  exit status is 4 if only warnings were issued, and 8 for any errors
  in the code [but, exit status is 0 for errors like "Input file not found"].
  These options are useful when the compiler is run from a script or Makefile.

  -ew
    Tells the compiler to exit with 0 status if only warning messages
    were issued.

  -es
    Tells the compiler to exit with 0 status if any errors *or*
    warnings were issued.

  -ed
    Display messages on stderr, as well as stdout. Normally, stdout
    is the .lst file, so this option allows you to see any compile
    errors/warnings immediately, without scrolling through the
    listing.

**-d<option>**
  <options> is a character string, with or without enclosing quotes.

  -dLIB
    Tells the compiler it is compiling a standard run-time library procedure.

  -dELF
    Causes the compiler to generate ELF object files (already the default, on Linux).

  -dOMF
    Causes the compiler to generate OMF object files (this is the default on OS/2).

.. FILES
.. =====

.. ENVIRONMENT
.. ===========

.. EXIT STATUS
.. ===========

.. BUGS
.. ====

.. EXAMPLES
.. ========

COPYRIGHT
=========

See the file /usr/doc/pli-|version|/readme_linux.html for license information.

AUTHORS
=======

plic is copyright Iron Spring Software.

This man page written for the SlackBuilds.org project
by B. Watson, and is licensed under the WTFPL.

SEE ALSO
========

**plicl**\(1), **ld**\(1)

http://www.iron-spring.com/
