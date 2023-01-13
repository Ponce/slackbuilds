Notes and optional stuff.

XU4 Upgrade Note
----------------
If you upgraded from xu4-20130612_svn to 1.2.1 or later, your old
settings from ~/.xu4 will no longer be read. You can try:

mkdir -p ~/.config/xu4
cp -a ~/.xu4/* ~/.config/xu4

...but there's no guarantee the new engine will read the old config or
savegames (not tested, YMMV).


Slackware Upgrade Note
----------------------
If you upgraded from 14.1 to 14.2, your old ~/.xu4/xu4rc needs to be
edited, to disable XML validation (otherwise the game won't start).
Edit the file manually, or use this:

sed -i '/validateXml/s,1,0,' ~/.config/xu4/xu4rc


PDF Manuals
-----------
Some of the documentation in this package is in Microsoft Word format. To
read it, you can use calligra... or just live with the text-only versions
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

URL: https://slackware.uk/~urchlay/src/ultima4_scanned_docs.zip
md5sum: c6be37b7028d6f7b56843a73517a5c31

The PDF docs aren't listed in the .info file because they're fairly large,
and not needed just to play the game.


Running without PulseAudio
--------------------------
Some of us still prefer not to use PulseAudio. For xu4, there's no
option for ALSA or SDL audio. To get sound without PulseAudio, install
apulse, then run xu4 as "apulse xu4" from a terminal. If you like,
you can edit the .desktop file to make it launch this way from the
GUI, too.
