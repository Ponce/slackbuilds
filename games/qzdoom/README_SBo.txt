Game Data
---------
qzdoom is only a game engine. To actually play the game, you'll need the
game data (IWAD file) from one or more of the supported games. These
include Doom, Ultimate Doom, Final Doom, FreeDoom, Heretic, Hexen,
and Strife.  Place the .wad file(s) in /usr/share/games/doom.

If you don't own any of the supported games, you can install one or more
of these slackbuilds.org packages to get a playable game:

- freedoom
- doom_shareware_data
- heretic_shareware_data
- hexen_demo_data
- chexquest3

Music Support
-------------
To hear the in-game music, there are several options. In the game menu,
select "Options | Sound Options" and set "MIDI Device" to one of the
below:

1. FluidSynth - Install fluidsynth and fluid-soundfont. These are runtime
dependencies (no need to rebuild qzdoom).

2. Timidity - Install TiMidity++ and either eawpats or freepats (all
runtime dependencies), and set up /etc/timidity/timidity.cfg to use
it. This uses more CPU than FluidSynth, and may make the framerate
stutter and jerk even on high-end systems.

3. GUS or OPL - Nothing extra required; these are software emulations
of classic soundcards from the early 1990s. They may sound "clunky" to
modern ears, but they may also bring back fond memories for long-time
Doom players.

qzdoom also supports WildMIDI, but this is currently not available on SBo.
