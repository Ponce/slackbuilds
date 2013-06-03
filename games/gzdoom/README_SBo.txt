Game Data
---------
gzdoom is only a game engine. To actually play the game, you'll need the
game data (IWAD file) from one or more of the supported games. These
include Doom, Ultimate Doom, Final Doom, FreeDoom, Heretic, Hexen,
and Strife.  Place the .wad file(s) in /usr/share/games/doom.

If you don't own any of the supported games, you can install one or more
of these slackbuilds.org packages to get a playable game:

freedoom, doom_shareware_data, heretic_shareware_data, hexen_demo_data

Music Support
-------------
To hear the in-game music, there are several options. In the game menu,
select "Options | Sound Options" and set "MIDI Device" to one of the
below:

1. FMOD (the default) - Install ff8dls and set the console variable
snd_midipatchset to "/usr/share/sounds/dls/ff8.dls" (from the in-game
console or by editing ~/.config/gzdoom/zdoom.ini). Alternatively,
if you dual-boot with Windows, use something like
/dosC/windows/system32/drivers/gm.dls (replace dosC with the mountpoint
of your C: drive in Windows).

2. FluidSynth - Install fluidsynth (before building gzdoom) and
fluid-soundfont.

3. Timidity - Install TiMidity++ and either eawpats or freepats, and
set up /etc/timidity/timidity.cfg to use it.

4. GUS or OPL - Nothing extra required; these are software emulations
of classic soundcards from the early 1990s. They may sound "clunky" to
modern ears, but they may also bring back fond memories for long-time
Doom players.

While you're in the Sound Options menu, it's probably a good idea to
set "Output System" to "ALSA" (otherwise, the default is OSS emulation,
which doesn't share the soundcard nicely with other apps).

