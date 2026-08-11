.. RST source for mac(1) man page. Convert with:
..   rst2man.py mac.rst > mac.1

.. |version| replace:: 13.25
.. |date| date::

===
mac
===

----------------------------------------
decode/encode Monkey's Audio codec files
----------------------------------------

:Manual section: 1
:Manual group: SlackBuilds.org
:Date: |date|
:Version: |version|

SYNOPSIS
========

**mac** *input-file* [*output-file*] [*options*]

DESCRIPTION
===========

Monkey's Audio (aka APE) is a lossless audio compression format,
similar to FLAC. mac is a console frontend to Monkey's Audio, able to
encode and decode APE audio files.

If you encode a WAV file to APE, then decode it back to WAV, the
audio in the decoded WAV file will be byte-for-byte identical to the
original (although any extra data such as tags/comments in the RIFF
header will not be preserved).

OPTIONS
=======

**--help**
  Show built-in usage message (same as running **mac** with no arguments).

**-threads=N**
  Set the number of threads when compressing or decompressing. *N* should be
  a number from 1 to the number of cores/thread supported by your CPU.

**-readfullinput**
  Read the entire file until the end of file if it's of unknown
  length, so the seek table can be made perfect. Generally only needed
  when reading from a pipe.

**-t** *tag*
  Sets an APE (or, with **-L**, ID3v3) tag. See **mac --help** for examples.

**-r** *tag*
  Removes the tag.

**-L**
  Converts the APE tag in an APE file into an ID3v1 tag.

Compression Options
-------------------

**-c[level]**
  Compress (encode). *input-file* must be a WAV file.
  *output-file* will be an APE audio file. Higher *level*\s result
  in better compression, at the expense of longer encoding time. The
  supported levels are:

    1000
      *(fast)*, usually around 45%-50% compression ratio.
    2000
      *(normal)*, usually around 40%-45% compression ratio.
    3000
      *(high)*, only slightly better than 2000 (usually by 1% or so).
    4000
      *(very high)*, probably the point of diminishing returns.
    5000
      *(insane)*, takes around 3x as long as 4000, may not compress any better.

**-n[level]**
  Convert (recompress). As **-c**, but **input-file** must be an APE audio
  file.

Decompression Options
---------------------

**-d**
  Decompress (decode). *input-file* must be an APE audio file.
  *output-file* will be a WAV file.

**-V**
  Verify. *input-file* must be an APE audio file. It will be decoded, and
  any errors will be displayed, but the decoded audio won't be saved.

**-v**
  Quick verify. Just checks that *input-file* has a valid APE header.

EXAMPLES
========

Compress
  mac "Metallica - One.wav" "Metallica - One.ape" -c2000

Decompress
  mac "Metallica - One.ape" "Metallica - One.wav" -d

Verify
  mac "Metallica - One.ape" -V

Quick verify
  mac "Metallica - One.ape" -v

Note that filenames with spaces and punctuation should be put inside
quotes, as usual. Run **mac --help** for more examples.

NOTES
=====

**mac** can only handle WAV files with 8, 16, or 24 bit samples, not
e.g. 32-bit or floating point. If needed, you can convert to 16-bit
with a command like:

  $ sox -G input.wav -b16 output.wav

WAV files must have 1 or 2 channels (mono or stereo;
quad/surround/5.1/etc are not supported). Any sampling rate is
supported.

**ffmpeg**\(1) can decode and convert APE files, though it cannot encode
to APE.

**mplayer**\(1) and **audacious**\(1) can play APE files.

**file**\(1) knows about APE files. Example:

  $ file test.ape

  test.ape: Monkey's Audio compressed format version 3990 with normal compression, stereo, sample rate 48000

COPYRIGHT
=========

See the file /usr/doc/mac-|version|/License.txt for license information.

AUTHORS
=======

The original Monkey's Audio Codec was written by Matthew
T. Ashland. It was ported to Linux by Frank Klemm and SuperMMX, then
enhanced and bugfixed by Jason Jordan.

This man page written for the SlackBuilds.org project
by B. Watson, and is licensed under the WTFPL.

SEE ALSO
========

**ffmpeg**\(1), **mplayer**\(1), **audacious**\(1), **flac**\(1), **shorten**\(1), **sox**\(1)

The Monkey's Audio Codec homepage: https://www.monkeysaudio.com/

