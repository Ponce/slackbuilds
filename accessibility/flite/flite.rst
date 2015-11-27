.. RST source for flite(1) man page. Convert with:
..   rst2man.py flite.rst > flite.1
.. rst2man.py comes from the SBo development/docutils package.

.. |version| replace:: 2.0.0
.. |date| date::

======
flite
======

---------------------------------
a small simple speech synthesizer
---------------------------------

:Manual section: 1
:Manual group: SlackBuilds.org
:Authors: `Alan W. Black`; `Kevin Lorenzo`
:Date: |date|
:Version: |version|
:Copyright: See /usr/doc/flite-|version|/COPYING for full copyright information on flite.
            This man page written for the SlackBuilds.org project
            by B. Watson, and is licensed under the WTFPL.

SYNOPSIS
========

flite [*-options*] [*text/file*] [*wavefile*]

DESCRIPTION
===========

Converts text in *text/file* to a waveform in *wavefile*.

If *text/file* contains a space, it is treated as a literal
text string and spoken, and not as a file name. If *text/file*
is omitted or **-**, text will be read from standard input.

If *wavefile* is unspecified or **play**, the result is
played on the current systems audio device.  If *wavefile*
is **none**, the waveform is discarded (good for benchmarking).

Any other options must appear before *text/file* and/or *wavefile*.

The full documentation for **flite** can be read as a GNU
info file with the command **info flite**, or as HTML in
*/usr/doc/flite-|version|/html/index.html*.

OPTIONS
=======

.. notice the **-opt** *param* stuff? rst's option recognition
.. can't handle non-GNU-style options like -option (it thinks the
.. option is -o, and the ption is the parameter). So we have to help
.. it out a little.

--version   Output flite version number

-?, -h, --help
            Output usage string

-o WAVEFILE
            Explicitly set output filename

-f TEXTFILE
            Explicitly set input filename

-t TEXT     Explicitly set input textstring

-p PHONES   Explicitly set input textstring and synthesize as phones

**--set** *F=V*
            Set feature (guesses type)

**-s** *F=V*
            Set feature (guesses type)

**--seti** *F=V*
            Set int feature

**--setf** *F=V*
            Set float feature

**--sets** *F=V*
            Set string feature

**-ssml**   Read input text/file in ssml mode

-b          Benchmark mode

-l          Loop endlessly

**-voice** *NAME*
            Use voice *NAME* (*NAME* can be filename or url too)

**-voicedir** *NAME*
            Directory containing voice data

**-lv**
            List voices available

**-add_lex** *FILENAME*
            add lex addenda from *FILENAME*

**-pw**
            Print words

**-ps**
            Print segments

**-psdur**
            Print segments and their durations (end-time)

**-pr** *RelName*
            Print relation *RelName*

**-voicedump** *FILENAME*
            Dump selected (cg) voice to *FILENAME*

-v          Verbose mode

SEE ALSO
========

The flite homepage: http://www.festvox.org/flite/
