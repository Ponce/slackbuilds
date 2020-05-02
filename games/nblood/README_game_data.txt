Game Data README for nblood
---------------------------

nblood actually includes 3 game binaries: nblood itself, rednukem,
and pcexhumed.


nblood
======

The nblood binary plays only Blood version 1.21, and its add-on, Cryptic
Passage. You'll need the "One Unit Whole Blood" CD-ROM: this is the only
version of the game supported by nblood.

If you want to include the game data in the nblood package:

- First, install system/isextract. This is needed to extract the data.

- Mount the CD-ROM (anywhere) before running the SlackBuild and the
  build script will find the data there.

- If you have an ISO image instead of a disc, just copy or symlink the .iso
  file into the SlackBuild directory (no need to mount anything).

If you have an installed copy of the game rather than a CD or ISO,
you should be able to just copy it to /usr/share/games/nblood. Filename
upper/lower case doesn't matter.

If you're working from the original CD, you can also rip the audio
tracks and convert them to ogg or flac. Follow the instructions in
/usr/doc/nblood-$VERSION/README.md to hear them in the game.


rednukem
========

The rednukem binary only plays Duke Nukem 3D: Atomic Edition v1.5 and
possibly (untested) the Plutonium Pak.

For Atomic Edition, all you need is the DUKE3D.GRP file from the install
CD (mine's in atominst/ on the CD) or an installed copy of the game. It's
44356548 bytes long and has an md5sum of 22b6938fe767e5cc57d1fe13080cd522.
Copy this file to /usr/share/games/eduke32/ (no, that's not a typo,
rednukem uses eduke32's data directory). The filename actually doesn't
matter, rednukem uses the checksum to detect it.


pcexhumed
=========

The pcexhumed binary plays:

- Powerslave demo version. Install the powerslave_demo_data build to
  play this.

- The PC version of Exhumed. All I have is the demo version, and it fails
  to play for me so I didn't make a package for it.

- Supposedly the full versions of Powerslave and Exhumed are supported,
  if you can find copies to try. Untested.
