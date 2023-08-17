.. RST source for asapconv(1) man page. Convert with:
..   rst2man.py asapconv.rst > asapconv.1

.. |version| replace:: 5.3.0
.. |date| date::

========
asapconv
========

---------------------------------------------------
convert Atari 8-bit chiptunes to .wav or .xex files
---------------------------------------------------

:Manual section: 1
:Manual group: SlackBuilds.org
:Date: |date|
:Version: |version|

SYNOPSIS
========

**asapconv** [*-options*] **inputfile** [*...*]

DESCRIPTION
===========

**asapconv** converts one or more Atari 8-bit chiptune files to
*.wav*, raw audio sample files, *.xex* (Atari 8-bit executables), or
the *.sap* chiptune format.

The supported input formats are: SAP, CMC, CM3, CMR, CMS, DMC, DLT,
MPT, MPD, RMT, TMC, TM8, TM2 or FC.

Although the **--help** output implies that it's possible to convert
to any supported input format, non-SAP input files can only be
converted to *.sap* or the same format they're already in. Attempts
to convert between two different non-SAP formats result in "conversion
error" and a 0-byte output file (and a non-zero exit status).

The only useful reason to "convert" a non-SAP file to the format it's
already in is to relocate the music to a different Atari address,
using the **--address=** option. If you don't know why you'd want to
do that, you don't need to do it...

The raw audio files created by **asapconv** are headerless, containing
only the audio samples. They can be played or converted with
e.g. **sox**\(1). For most purposes, *.wav* is more convenient.

OPTIONS
=======

**-h**, **--help**
  Show built-in help.

**-v**, **--version**
  Show version number.

**-o** *file.ext*, **--output**\=file.ext
  Write output to the given file. The extension must be *.wav*,
  *.raw*, *.xex*, *.sap*, or the same extension as the input file. If
  only an extension is given, the filename will be derived from the
  input filename. If the filename part is given as *-* (e.g. *-.wav*),
  output is written to standard output. If *file* includes a directory
  (e.g. *dir/foo.wav*), output is written to that directory, but
  **asapconv** will not create the directory (it must already
  exist). Output filenames can also contain printf-style **%**
  escapes; see the **--help** output for details.

**-a** *author*, **--author**\=author
  Sets the author name in the output file.

**-n** *name*, **--name**\=name
  Sets the music name (title) in the output file.

**-d** *date*, **--date**\=date
  Sets the creation date (DD/MM/YYYY) in the output file.

**-s** *song*, **--song**\=song
  Select subsong number (zero-based). The default is 0, which will be
  the only subsong in a file that contains only one song. Use
  **chksap.pl -s filename** to see how many subsongs exist in a SAP file.

**-t** **time**, **--time**\=time
  Set output length; **time** must be given in minutes:seconds (e.g. 1:00).

**--tag**
  Include author/title/date tags in the output. Only works for **.wav**
  and **.xex** output. For *xex* files, the tag information will be shown
  on the Atari screen while the song is playing.

**-m** *channels*, **--mute** *channels*
  For *.wav* or *.raw* output only: Mute the given list of POKEY
  channels. This is a comma-separated list of channels numbered
  1 through 8. Channels 1 to 4 are the first POKEY (only POKEY,
  in an unmodified Atari), and 5 to 8 are the second POKEY in a
  stereo-modded Atari.

**-b**, **--byte-samples**
  Use 8-bit samples for *.wav* or *.raw* output.

**-w**, **--word-samples**
  Use 16-bit samples for *.wav* or *.raw* output. This is the default already.

**--address=**\=hex-address
  Relocate music to this address. Only useful when converting to *.sap*
  or to the same format as the input file.

EXIT STATUS
===========

**asapconv** exits with zero status on success or non-zero on failure.

.. EXAMPLES
.. ========

COPYRIGHT
=========

See the file /usr/doc/asap-|version|/COPYING for license information.

AUTHORS
=======

The ASAP suite was written by Piotr Fusik, with contributions from many
others (see the website for details).

This man page written for the SlackBuilds.org project
by B. Watson, and is licensed under the WTFPL.

SEE ALSO
========

**chksap.pl**\(1), **asap-sdl**\(1), **asap-mplayer**\(1), **sap2ntsc**\(1), **sap2txt**\(1)

The ASAP website: https://asap.sourceforge.net/
