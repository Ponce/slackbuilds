.. RST source for stretchplayer(1) man page. Convert with:
..   rst2man.py stretchplayer.rst > stretchplayer.1
.. rst2man.py comes from the SBo development/docutils package.

.. |version| replace:: 0.503_4
.. |date| date::

=============
stretchplayer
=============

----------------------------------------------
audio player with time stretch and pitch shift
----------------------------------------------

:Manual section: 1
:Manual group: SlackBuilds.org
:Date: |date|
:Version: |version|

SYNOPSIS
========

stretchplayer [*file*]

DESCRIPTION
===========

**stretchplayer** is an audio file player that allows you to change
the speed of the song without changing the pitch. It will also allow
you to transpose the song to another key (while also changing the
speed independently). This is a very powerful tool for musicians who
are learning to play a pre-recorded song. Its features include:

- Time Stretch (25% to 125% of song speed, without changing pitch)

- Pitch shift (up or down 1 octave)

- A/B repeat

- Lots of keyboard accelerators

The player supports all the audio formats that libsndfile supports, which
currently includes OGG/Vorbis, WAV, W64, AIFF, SND, and FLAC. Note that
neither libsndfile nor StretchPlayer supports MP3 files for patent liability
reasons.

**stretchplayer** takes no arguments other than an optional *file* to play.

KEYBOARD
========

**Space**
  Play/Pause.

**S**
  Stop.

**Enter**
  A/B Loop.

**Left**, **Right** arrows
  Playback Speed.

**+**, **-**
  Transposition/tuning. Increase/decrease pitch by 100 cents (1 semitone). With
  *Shift*, adjust pitch by 10 cents. With *Control*, adjust by 1 cent.

**Up**, **Down** arrows
  Increase/decrease volume.

**O**
  Open new file.

**Escape**
  Quit.

**Home**
  Reset pitch and speed to defaults, seek to beginning of song.

BUGS
====

**stretchplayer** will not work if you have a small JACK buffer size (<= 256 frames).
Bug reports can be sent to gabriel@teuton.org.

COPYRIGHT
=========

See the file /usr/doc/stretchplayer-|version|/COPYING for license information.

AUTHORS
=======

stretchplayer was written by Gabriel M. Beddingfield.

The fine-tuning patch (Ctrl/Shift to adjust +/- 1 or 10 cents) was
written by B. Watson.

This man page written for the SlackBuilds.org project
by B. Watson, and is licensed under the WTFPL.

SEE ALSO
========

**mplayer**\(1), **mpv**\(1), **jackd**\(1), **qjackctl**\(1)

/usr/doc/stretchplayer-|version|/README.txt

The stretchplayer homepage::

  https://www.teuton.org/~gabriel/stretchplayer/
