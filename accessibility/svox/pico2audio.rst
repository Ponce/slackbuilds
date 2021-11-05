.. RST source for pico2audio(1) man page. Convert with:
..   rst2man.py pico2audio.rst > pico2audio.1
.. rst2man.py comes from the SBo development/docutils package.

.. |version| replace:: 20210802
.. |date| date::

.. converting from pod:
.. s/B<\([^>]*\)>/**\1**/g
.. s/I<\([^>]*\)>/*\1*/g

==========
pico2audio
==========

------------------------------------
text-to-speech wrapper for pico2wave
------------------------------------

:Manual section: 1
:Manual group: SlackBuilds.org
:Date: |date|
:Version: |version|

SYNOPSIS
========

pico2audio [*-l <language>*] [*words*]

DESCRIPTION
===========

**pico2audio** is a shell script wrapper for **pico2wave**. It renders text to
speech and plays it using the **play** command.

If a *-l <language>* option is given, it will be passed to pico2wave. See
**pico2wave**\(1) for details.

If *words* are given, they are used as input. Unlike the pico2wave command,
there's no requirement to quote multiple words. If no *words* are given,
words are read from standard input.

Exit status is that of **pico2wave**.

EXAMPLES
========

Examples:

  pico2audio Hello world.
    Speaks "Hello world" in the default language (en-US).

  pico2audio -l en-GB Hello world.
    As above, in a British accent.

  fortune -s | pico2audio
    Reads from standard input.

  pico2audio < /etc/motd
    Speak a text file. Don't forget the **<** or it says the filename instead.

AUTHOR
======

pico2audio was written by B. Watson, and is licensed under the WTFPL.

SEE ALSO
========

**pico2wave**\(1), **play**\(1)
