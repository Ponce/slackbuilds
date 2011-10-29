Optional stuff: Music, enhanced graphics, and PDF manuals.

Music
-----
To hear the in-game music, you'll need a set of MIDI patches, either the
eawpats or freepats package from slackbuilds.org (make sure you set up
timidity.cfg correctly). These can be installed after the fact (no need
to rebuild xu4 after installing them). The timidity package itself isn't
required (xu4 uses SDL_mixer to play back the music).

Enhanced Graphics
-----------------
By default, the script will build a package that uses the graphics from
the original PC/DOS version of the game. If you'd like to use the
upgraded graphics from the Ultima IV Upgrade Project, download the file
u4upgrad.zip and place it in the same directory as the SlackBuild script,
before running it. The upgrade can be downloaded here:

URL: http://www.moongates.com/u4/upgrade/files/u4upgrad.zip
md5sum: 4ce9c9cd9dab111275e0ebfde7a482c4
Homepage: http://www.moongates.com/u4/upgrade/Upgrade.htm

The graphics upgrade isn't listed in the .info file because it isn't
required to play the game, and also because some users will prefer the
original CGA-style graphics.

PDF Manuals
-----------
Some of the documentation in this package is in Microsoft Word format. To
read it, you can use KWord... or just live with the text-only versions
(also included in this package). These are the manuals for the original
game, and unlike most modern games, you really do need to read them to
have any chance of completing Ultima IV. The text files and Word docs
contain all the information needed to play the game.

However, the text and MS Word manuals don't really capture the
flavor of the original manuals: they're just the content, without the
presentation. If you want a more authentic retro-gaming experience,
you should install the PDF manuals. To do this, download the file
ultima4_scanned_docs.zip and place it in the SlackBuild directory,
before running the script.

URL: http://urchlay.naptime.net/slackstuff/src/ultima4_scanned_docs.zip
md5sum: c6be37b7028d6f7b56843a73517a5c31

The PDF docs aren't listed in the .info file because they're fairly large,
and not needed just to play the game.
