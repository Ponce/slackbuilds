.. RST source for picospeaker(1) man page. Convert with:
..   rst2man.py picospeaker.rst > picospeaker.1
.. rst2man.py comes from the SBo development/docutils package.

.. |version| replace:: 0.6.2
.. |date| date::

===========
picospeaker
===========

-----------------------------------
command-line interface to Svox Pico
-----------------------------------

:Manual section: 1
:Manual group: SlackBuilds.org
:Date: |date|
:Version: |version|

SYNOPSIS
========

picospeaker [*-options*] <*text*>

DESCRIPTION
===========

PicoSpeaker is a program written in Python that speaks text on its
command line or standard input using SVox Pico (**pico2wave**\(1)) and
**sox**\(1). Speech rate, pitch, volume and language can be specified,
and output can be saved to any file format supported by **sox**, or
sent directly to the audio device.

OPTIONS
=======

**-l**, **--language** *language*
  Language to speak (default is *en-US*). Available languages are
  *en-US*, *en-GB*, *de-DE*, *es-ES*, *fr-FR* and *it-IT*. These may
  be abbreviated to the two-letter code (e.g. *en*).

**-v**, **--volume** *number*
  Output volume (default is 1.0).

**-r**, **--rate** *number*
  Rate of speech from -90 to 9900 (default is 0). This is a percentage, offset by 100 (so -90 is 10% original speed, 100 is 2x).

**-p**, **--pitch** *number*
  Voice pitch (semitones) from -79 to 39 (default is 0).

**-o**, **--output** *file*
  Output to the specified file (default is sound card output).

**-c**, **--compress**, **-q**, **--quality** *number*
  Compression/quality level of output file, depends on file type. This option causes an error if no output file is specified.

**-t**, **--type** *type*
  Save output file as *type*. Only needed if saving with a nonstandard extension. This option causes an error if no output file is specified.

**-V**, **--version**
  Print version information.

**-h**, **--help**, **-u**, **--usage**
  Print built-in help message.

COPYRIGHT
=========

**picospeaker** is free and unencumbered software released into the public domain.
See the file /usr/doc/picospeaker-|version|/UNLICENSE for details.

AUTHORS
=======

**picospeaker** was written by written by Kyle and forked by shilbert01.

This man page written for the SlackBuilds.org project
by B. Watson, and is licensed under the WTFPL.

SEE ALSO
========

**pico2wave**\(1), **sox**\(1)
