.. RST source for listener(1) man page. Convert with:
..   rst2man.py listener.rst > listener.1
.. rst2man.py comes from the SBo development/docutils package.

.. |version| replace:: 2.2
.. |date| date::

========
listener
========

------------------------------
listen for sound and record it
------------------------------

:Manual section: 1
:Manual group: SlackBuilds.org
:Date: |date|
:Version: |version|

SYNOPSIS
========

listener [*-options*]

DESCRIPTION
===========

Listener listens for sound. If it detects any, it starts recording
automatically and also automatically stops when things become silent
again.

OPTIONS
=======

Most options can be set in the config file.

-c<configfile>    Config file to use (default is **/etc/listener.conf**).

-l<detect_level>
                  Detect level.

-m<min_duration>
                  Minimum duration to record (samples).

-b<rec_silence>   How many seconds to keep recording after no sound is heard.

-x<max_duration>  Maximum duration to record (seconds).

-S<pars>          Sets the sample rate, number of channels, output file type, etc.
                  e.g.: **44100,1,wav**
                  or: **2,ima_adpcm,10khz**.
                  See below for a list of fileformats and subtypes.

-F                Use a fixed amplification factor.

-o                Exit after 1 recording.

-w<wav_path>      Where to write outfile files.

-p                Read from pipe (together with splitaudio).

-y<command>       Script to call as soon as the recording starts.

-e<command>       Script to call after recording.

-f                Fork into the background.

-a<pidfile>       File to write the pid in.

-s                Be silent.

-h                Print help text and exit.

Supported file formats: wav, aiff, au, raw, paf, svx, nist, voc, ircam, w64, mat4, mat5, pvf, xi, htk, sds, avr, wavex, sd2, flac, caf, wve, ogg, mpc2k, rf64

Supported sub-types: pcm_s8, pcms8, pcm8, pcm_16, pcm16, pcm_24, pcm24, pcm_32, pcm32, pcm_u8, pcmu8, float, double, ulaw, alaw, ima_adpcm, ms_adpcm, gsm610, vox_adpcm, g721_32, g723_24, g723_40, dwvw_12, dwvw_16, dwvw_24, dwvw_n, dpcm_8, dpcm_16, vorbis

FILES
=====

/etc/listener.conf   The default config file (when **-c** not used).

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

See the file /usr/doc/listener-|version|/license.txt for license information.

AUTHORS
=======

listener was written by folkert@vanheusden.com.

This man page written for the SlackBuilds.org project
by B. Watson, and is licensed under the WTFPL.

SEE ALSO
========

The listener homepage: https://www.vanheusden.com/listener/
