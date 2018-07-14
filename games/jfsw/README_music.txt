The most important things to understand about the music in Shadow Warrior:

The demo/shareware version of the game uses MIDI. There are actually
.MID files stored within sw.grp.

The full/registered version and/or expansion pack uses CD audio
tracks. They *can't* use MIDI: there's no MIDI data inside its .grp
files at all.

So there are 2 completely separate procedures for getting the music
to work, depending on whether you're playing the full/expansion or
demo version.

Full (Registered) Version, Wanton Destruction expansion
-------------------------------------------------------

For these versions, jfsw doesn't actually support CD audio from a
physical CD [*]. It does, however, support .ogg files made from the CD.
You can use CD ripping software to rip these from the original CD,
or download them (for free, account creation required) from:

https://www.gog.com/game/shadow_warrior_complete

...or download it from Steam (also for free). The same files are available
there, under the name "Shadow Warrior Classic".

The .ogg files should be named "track02.ogg" through "track14.ogg", all
lowercase (there is NO "track01.ogg"!), and placed in either ~/.jfsw/
or /usr/share/games/jfsw/

Run the game, and the music should play. If not, use the in-game menus
(Options, Sound Menu) to enable the music and turn up the volume.

If you followed the steps below to get the demo music to play, you'll
have to re-edit ~/.jfsw/sw.cfg and change the MusicDevice back to 0.

If you're never going to play the demo version, there's no need to build
jfsw with fluidsynth support (although, it won't hurt anything if you do).

Note: When using the .ogg soundtrack, under some conditions, it seems
the background music stops playing after loading a saved game. If this
happens to you, toggle the music off & back on (under Options, Sound
Menu), which should start it playing again.

[*] There is some code in jfaudiolib that's supposed to play CD audio
    but it's (a) SDL-1.2 only, and (b) broken.

Demo (Shareware) Version
------------------------

For the shareware version, the MIDI data is already present inside the
sw.grp file. To actually hear it, you'll have to:

1. Build and install fluidsynth. Doesn't matter whether or not
   optional jack-audio-connection-kit and/or lash are included (jfsw
   doesn't use them though).

2. Build and install fluid-soundfont.

3. Build and install jfsw. When installing, the description should say
   the package was built with fluidsynth.

4. Run the game once, and exit it normally, to get it to create a config
   file. You should now have a ~/.jfsw/sw.cfg file.

5. Edit ~/.jfsw/sw.cfg, find the line that says "MusicDevice = 0", and
   change the 0 to a 6. This enables fluidsynth.

6. Run the game again. Make sure the music is enabled and the music
   volume is turned up (under Options, Sound Menu).

Unfortunately, the edited config file won't work with the full version.
You'll have to change MusicDevice back to 0 (meaning 'autodetect') to get
the .ogg tracks to play. Other possible values are 1 (SDL) and 7 (ALSA).

There's no direct way to change which soundfont jfsw uses. What it does is
look in /usr/share/sounds/sf2/ and pick the first soundfont it finds, in
sorted order. Basically it does the C++ equivalent of:

$ ls /usr/share/sounds/sf2/*.sf2 | head -1

If the only sound fonts in that directory are the ones installed by
the fluid-soundfont package, it will choose "FluidR3_GM.sf2", which is
reasonable and sounds good.

If you want to use a different soundfont, try something like this:

# cd /usr/share/sounds/sf2/
# ln -s MySoundFont.sf2 000-jfsw.sf2

Check with the ls command above, to make sure 000-jfsw.sf2 sorts first.
