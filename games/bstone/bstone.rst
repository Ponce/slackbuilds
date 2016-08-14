.. RST source for bstone(6) man page. Convert with:
..   rst2man.py bstone.rst > bstone.6
.. rst2man.py comes from the SBo development/docutils package.

.. |version| replace:: 1.1.7
.. |date| date::

.. converting from pod:
.. s/B<\([^>]*\)>/**\1**/g
.. s/I<\([^>]*\)>/*\1*/g

======
bstone
======

------------------------------------
source port of the Blake Stone games
------------------------------------

:Manual section: 6
:Manual group: SlackBuilds.org
:Date: |date|
:Version: |version|

SYNOPSIS
========

bstone [*-options*]

DESCRIPTION
===========

BStone is a source port of Blake Stone game series: Aliens of Gold and Planet Strike.

Features:

- High resolution rendering of world (extended vanilla engine)

- Modern and vanilla controls

- Allows to customize control bindings

- Separate volume control of sound effects and music

Supported games:

- Aliens of Gold v1.0 full

- Aliens of Gold v2.0 full

- Aliens of Gold v2.1 full

- Aliens of Gold v3.0 full

- Aliens of Gold v3.0 shareware

- Planet Strike v1.0

- Planet Strike v1.1

This man page only describes the command-line options. For full documentation,
see /usr/doc/bstone-|version|/README.md

OPTIONS
=======

.. notice the **-opt** *param* stuff? rst's option recognition
.. can't handle non-GNU-style options like -option (it thinks the
.. option is -o, and the ption is the parameter). So we have to help
.. it out a little.

*--version*
  Outputs the port's version to standard output and  
  into message box.

*--aog_sw*
  Switches the port to Blake Stone: Aliens of Gold (shareware, v3.0) mode.  
  If appropriate data files will not be found the port will fail.  
  Default switch strategy: AoG (full) -> AoG (SW) -> PS

*--aog_10*
  Switches the port to Blake Stone: Aliens of Gold (full, v1.0) mode.  
  If appropriate data files will not be found the port will fail.  
  Default switch strategy: AoG (full) -> AoG (SW) -> PS

*--aog_2x*
  Switches the port to Blake Stone: Aliens of Gold (full, v2.0/v2.1) mode.  
  If appropriate data files will not be found the port will fail.  
  Default switch strategy: AoG (full) -> AoG (SW) -> PS

*--aog_30*
  Switches the port to Blake Stone: Aliens of Gold (full, v3.0) mode.  
  If appropriate data files will not be found the port will fail.  
  Default switch strategy: AoG (full) -> AoG (SW) -> PS

*--ps*
  Switches the port to Blake Stone: Planet Strike (full, v1.0/v1.1) mode.  
  If appropriate data files will not be found the port will fail.  
  Default switch strategy: AoG (full) -> AoG (SW) -> PS

*--no_screens*
  Skips start-up screens (AoG/PS) and ending promo pages (AoG SW only).

*--cheats*
  Enables so called "debug mode" without much fuss.

*--data_dir path_to_data*
  Specifies location to the game's data files.  
  Default: /usr/share/games/bstone/

*--profile_dir path*
  Overrides default location of the game's profile files. Config files
  and savegames are written here.
  Default: .local/share/bibendovsky/bstone/

*--vid_renderer [soft|ogl]*
  Forces to use a specified renderer.  
  "soft" selects a software renderer.  
  "ogl" selects an OpenGL 2.x compatible renderer.  
  Default order without this option: ogl, soft.

*--vid_windowed*
  Runs the game in windowed mode.  
  Default video mode: 640x480

*--vid_mode width height*
  Selects the specified resolution for windowed mode.  
  Without this option the game will use desktop's resolution.  
  Minimum width: 640  
  Minimum height: 480

*--vid_scale factor*
  Refinement factor. The higher a value the greater internal resolution  
  mode will be used to render a scene. The dimensions of the resolution mode  
  are proportional to the original one (320x200) by 'factor' value.  
  This option can greatly affect the performance of a renderer (especially a  
  software one).  
  Minimum factor: 1 (identical to the original game)  
  Default factor: depends on the game's resolution mode.

*--vid_window_x offset*
  Sets a horizontal offset from the left side of the desktop screen.  
  Applicable for windowed mode only.

*--vid_window_y offset*
  Sets a vertical offset from the top side of the desktop screen.  
  Applicable for windowed mode only.

*--snd_rate sampling_rate*
  Specifies sampling rate of mixer in hertz.  
  Default: 44100 Hz  
  Minimum: 11025 Hz

*--snd_mix_size duration*
  Specifies mix data size in milliseconds.  
  Default: 40 ms  
  Minimum: 20 ms

COPYRIGHT
=========

See the file /usr/doc/bstone-|version|/LICENSE for license information.

AUTHORS
=======

bstone was written by Boris I. Bendovsky, based on an original
game by JAM Productions, published by Apogee Entertainment, LLC.

This man page written for the SlackBuilds.org project
by B. Watson, and is licensed under the WTFPL.

SEE ALSO
========

The bstone homepage: http://bibendovsky.github.io/bstone/
