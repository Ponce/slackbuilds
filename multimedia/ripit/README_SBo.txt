
The TL;DR version: you probably don't need any of the optional deps.

If you're still reading: ripit's optional dependencies are runtime deps,
so you can install them after installing ripit and they will be detected.

If you don't install anything extra, you'll be able to rip with
cdparanoia or cdda2wav, and encode to mp3, flac, ogg, wavpack, or any
format supported by ffmpeg (try "ffmpeg -encoders|grep ^.A"). You'll
be UNable to submit updated CDDB entries (most people don't need to do
this anyway).

Here's the list of optional deps available from SBo:

faac - Required for encoding to mp4/aac (-c 3 option).

musepack-tools or mppenc - Required for encoding to MusePack
                           (mpc) format (-c 5 option).

libwwwperl - Required for submitting updated CDDB entries to freedb.org.
             If this package is missing, ripit will warn that LWP::Simple
             is not installed. You can ignore the warning, if you never
             intend to submit any CDDB entries.

perl-MusicBrainz-DiscID and perl-WebService-MusicBrainz -
  These can be used for identifying the disc. However, the SlackBuild author
  has NOT tested this script with MusicBrainz, and does not guarantee that
  it'll work. If you manage to get this working, please contact the maintainer
  (email address in the .info file) and let me know how you managed it, so I
  can update this documentation.

There are other optional deps not available on SBo. These include:

dagrab, tosha, cdd -
  CD rippers, which could be used instead of cdparanoia or cdda2wav.

MP3::Tag - Required for including cover art within mp3 files.

Unicode::UCD - Required for non-UTF-8 id3 tags.
