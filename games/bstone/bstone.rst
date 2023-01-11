.. RST source for bstone(6) man page. Convert with:
..   rst2man.py bstone.rst > bstone.6
.. rst2man.py comes from the SBo development/docutils package.

.. |version| replace:: 1.1.12
.. |date| date::

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

**--version**  
  Outputs the port's version to standard output and into message box.

**--aog_sw**  
  Switches the port to "Blake Stone: Aliens Of Gold (shareware)" mode.  
  If appropriate data files are not found, the port will fail.

**--aog**  
  Switches the port to "Blake Stone: Aliens Of Gold" mode.  
  If appropriate data files are not found, the port will fail.

**--ps**  
  Switches the port to "Blake Stone: Planet Strike" mode.  
  If appropriate data files are not found, the port will fail.

**--no_screens**  
  Skips start-up screens and the ending promo pages (AOG SW).

**--cheats**  
  Enables so called "debug mode" without much fuss.

**--data_dir** dir  
  Specifies a directory with game's resource files.  
  Default: */usr/share/games/bstone*

**--mod_dir** dir  
  Specifies a directory with mod's resource files.  
  Default: undefined.

**--profile_dir** dir  
  Overrides default directory of the game's profile files.
  Default: *~/.local/share/bibendovsky/bstone/*

**--vid_renderer** value  
  Select a renderer.  
  Values:

    - auto_detect - tries to select the best renderer.
    - software - the vanilla renderer.
    - gl_2_0 - OpenGL 2.0 or higher.
    - gl_3_2_c - OpenGL 3.2 core or higher.
    - gles_2_0 - OpenGL ES 2.0 or higher.

  Default: auto_detect

**--vid_width** width  
  Specifies window width.  
  Minimum width: 320  
  Default width: 640

**--vid_height** height  
  Specifies window height.  
  Minimum height: 240  
  Default height: 480

**--vid_x** offset  
  Sets a horizontal offset from the left side of the desktop screen.  
  Applicable for positionable window only.  
  Default: 0

**--vid_y** offset  
  Sets a vertical offset from the top side of the desktop screen.  
  Applicable for positionable window only.  
  Default: 0

**--vid_is_positioned** value  
  Centers a window on the desktop or moves it in the specified position.  
  Values: 0 (centered) or 1 (positioned)  
  Default: 0

**--vid_is_vsync** value  
  Enables or disables vertical synchronization.  
  Values: 0 (disable) or 1 (enable)  
  Default: 1

**--vid_is_widescreen** value  
  Enables or disables widescreen rendering.  
  Values: 0 (disable) or 1 (enable)  
  Default: 1

**--vid_is_ui_stretched** value  
  Stretches the UI or keeps it at 4x3 ratio otherwise.  
  Values: 0 (non-stretched) or 1 (stretched)  
  Default: 0

**--vid_2d_texture_filter** filter  
  Sets texturing filter for UI.  
  Applicable only for 3D-rendering.  
  Values: nearest or linear  
  Default: nearest

**--vid_3d_texture_image_filter** filter  
  Sets texturing image filter for the scene.  
  Applicable only for 3D-rendering.  
  Values: nearest or linear  
  Default: nearest

**--vid_3d_texture_mipmap_filter** filter  
  Sets texturing mipmap filter for the scene.  
  Applicable only for 3D-rendering.  
  Values: nearest or linear  
  Default: nearest

**--vid_3d_texture_anisotropy** value  
  Sets anisotropy degree for the scene.  
  Value 1 or lower disables the filter.  
  Applicable only for 3D-rendering.  
  Values: [1..16]  
  Default: 1

**--vid_texture_upscale_filter** filter  
  Sets texturing upscale filter.  
  Applicable only for 3D-rendering.  
  Values: none or xbrz  
  Default: none  
  **WARNING** xbrz is a high resource usage filter!

**--vid_texture_upscale_xbrz_degree** degree  
  Sets a degree of xBRZ texturing upscale.  
  Applicable only for 3D-rendering.  
  Values: [2..6]  
  Default: 0

**--vid_aa_kind** value  
  Sets an anti-aliasing mode.  
  Applicable only for 3D-rendering.  
  Values: none or msaa  
  Default: none

**--vid_aa_degree** value  
  Sets a degree of the anti-aliasing.  
  Applicable only for 3D-rendering.  
  Values: [2..32]  
  Default: 1

**--vid_filler_color_index** value  
  Sets a color for screen bars.  
  Values: [0..255]  
  Default: 0

**--vid_external_textures** value  
  Toggles external textures.  
  Values: 0 (disable), 1 (enable).  
  Default: 0

**--snd_is_disabled** value  
  Enables or disables audio subsystem.  
  Values: 0 (disable) or 1 (enable)  
  Default: 0

**--snd_rate** sampling_rate  
  Specifies sampling rate of mixer in hertz.  
  Default: 44100  
  Minimum: 11025

**--snd_mix_size** duration  
  Specifies mix data size in milliseconds.  
  Default: 40  
  Minimum: 20

**--snd_driver** value  
  Specifies the audio driver to use.  
  Values: auto-detect, 2d_sdl (2D SDL), 3d_openal (3D OpenAL)  
  Default: auto-detect  
  Auto-detect order: 3d_openal, 2d_sdl

**--snd_oal_library** value  
  Specifies OpenAL driver's name.  
  Default: "" (OpenAL32.dll on Windows and libopenal.so on non-Windows system).

**--snd_oal_device_name** value  
  Specifies OpenAL device name.  
  Default: ""

**--snd_sfx_type** value  
  Specifies SFX type.  
  Values: adlib (AdLib) or pc_speaker (PC Speaker)  
  Default: adlib

**--snd_is_sfx_digitized** value  
  Toggles SFX digitization.  
  If enabled overrides AdLib / PC Speaker SFX audio chunk if such one is available in AUDIOT.* file.  
  Values: 0 (disable) or 1 (enable)  
  Default: 1

**--snd_opl3_type** value  
  Specifies OPL3 emulator type.  
  Values: dbopl (DOSBox) or nuked (Nuked)  
  Default: dbopl

**--calculate_hashes**  
  Calculates hashes (SHA-1) of all resource files and outputs them into the log.

**--extract_vga_palette** dir  
  Extracts VGA palette into existing directory dir.  
  Supported file format: **.bmp**

**--extract_walls** dir  
  Extracts graphics resources (wall, flooring, etc.) into existing directory dir.  
  Supported file format: **.bmp**

**--extract_sprites** dir  
  Extracts graphics resources (actors, decorations, etc.) into existing directory dir.  
  Supported file format: **.bmp**

**--extract_music** dir  
  Extracts music resources into existing directory dir.  
  Supported file format: **.wav**
  Supported file format: data (unprocessed)

**--extract_sfx** dir  
  Extracts sfx resources into existing directory dir.  
  Supported file format: **.wav**
  Supported file format: data (unprocessed)

**--extract_texts** dir  
  Extracts text resources into existing directory dir.  
  Supported file format: **.txt**

**--extract_all** dir  
  Extracts all resources (walls, sprites, etc.) into existing directory dir.

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
