I hate having to have a set of notes/instructions that's longer than
the SlackBuild is, but this stuff is important...

Stratagus
---------

The version number of wargus needs to match the version number of your
installed stratagus package. In practice this won't be a problem if
you use SlackBuilds.org for both (because both will get updated at the
same time).

Upgrade Notes
-------------

The dependencies for in-game music have changed. wargus 2.2.x
used TiMidity++ and eawpats. Starting with 2.3.0, fluidsynth and
fluid-soundfont are used instead.

If you're upgrading from a previous version of wargus, you may have
to delete your old preferences directory:

  rm -rf ~/.stratagus/wc2

Slackware Note
--------------

When creating a package, you'll see errors like:

WARNING:  gzip test failed on usr/share/games/stratagus/wargus/music/Orc Defeat.ogg.gz

These are harmless, and caused by makepkg's gzip test not being able to
handle filenames with spaces in them. There's a thread on linuxquestions
about makepkg's problems with spaces in filenames:

http://www.linuxquestions.org/questions/slackware-14/bug-in-makepkg-and-symlinks-with-blanks-in-filename-4175480597/

The general consensus seems to be, changing makepkg isn't going to happen.

SlackBuilds.org Note
--------------------

In the .info file, stratagus, ffmpeg2theora, fluidsynth, and
fluid-soundfont are listed as requirements. ffmpeg2theora is only required
at build time; the others required at runtime (matters if you're deploying
on a host other than the build host).

Game Data
---------

By itself, wargus isn't a playable game. It needs the data from the
original Warcraft II game.

You need the original Warcraft II for DOS or the Beyond the Dark Portal
expansion pack to extract the game data files. Battle.net edition doesn't
work. This can be either a CD-ROM, ISO image, installed game directory
(e.g. on your Windows C: drive), or a zip/rar/7z/tar archive of any
of the above.

You can choose to either build a package that includes the game data, or
add the game data separately after package installation. If you include
the data in your package, you MAY NOT redistribute your package.

To build a package with the data:

Whatever form you have the game in, set the environment
variable GAMEDATA to point to it:

export GAMEDATA=/dev/cdrom               # original CD
export GAMEDATA=~/oldgames/warcraft2.rar # archive of your old install
export GAMEDATA=~/dosbox/war2            # installed copy
export GAMEDATA=/tmp/warcraft2.iso       # image of CD

...then run ./wargus.SlackBuild

If GAMEDATA isn't set, or if the extraction process fails, your wargus
package won't include the game data. You'll be unable to play the game
until you've extracted the data yourself.

Note that the data extraction process ignores many possible errors. If
the game doesn't seem to work correctly, it's possible your install of
Warcraft II is corrupted.

If you build a package without the data:

The extraction script used by the SlackBuild is installed as
/usr/bin/extract-warcraft2 (run with no arguments for usage) and can
be run any time without reinstalling the wargus package. If you do
this, and later decide to remove wargus, you'll have to manually rm -rf
/usr/share/games/stratagus/wargus after package removal.

For game data extraction to work, you will need:

- ffmpeg2theora

- if you're extracting from a 7zip or rar archive, you'll need p7zip
  or unrar.

Extraction takes a while, depending on your CPU speed. It renders all the
game's MIDI music as wav files, transcodes those to .ogg, then transcodes
all the game's videos to ogg theora.

extract-warcraft2 is a wrapper for wartool, supplied with wargus. See
the wartool man page for more information.

