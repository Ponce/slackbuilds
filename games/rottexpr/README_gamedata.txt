There are at least 3 versions of Rise of the Triad that are supported
by rottexpr. Each game version uses a different game binary, but there's a
wrapper script that looks at the available game data files and runs the
"best" version of the game (this is what happens if you just run "rottexpr",
or run Rise of the Triad from the KDE/XFCE application menu). The game
looks for the data files in /usr/share/games/rottexpr, and the different
versions can coexist. All filenames must be UPPERCASE.

Which version do I have?
------------------------
If you've got an installed copy of the game, maybe on a DOS/Windows partition,
here's how to identify it:

- If you have no files named DARKWAR.*, you have the shareware/demo
version.

- If you have DARKWAR.(WAD|RTL|RTC), but no ROTTCD.RTC, you have the
registered floppy/download version.

- If you have ROTTCD.RTC (and DARKWAR.*), you have the CD-ROM version.
---

Shareware/Demo version 1.3
--------------------------
Data files: HUNTBGIN.WAD HUNTBGIN.RTC HUNTBGIN.RTL REMOTE1.RTS

This is always included in the package.

The binary for the shareware version is called "rottexpr-demo".
---

Registered (Floppy Disk, Registered Download) version 1.3
---------------------------------------------------------
Data files: DARKWAR.WAD DARKWAR.RTC DARKWAR.RTL REMOTE1.RTS

Copy these files from your DOS/Windows ROTT game directory to
/usr/share/games/rottexpr/, making sure to give them all-uppercase names.
If the shareware REMOTE1.RTS is already there, it doesn't matter whether
you overwrite it or not (this file is identical in the demo and registered
versions).

If you have an older version than 1.3, see http://www.3drealms.com/rott/
for a patch.

The binary for the registered version is called "rottexpr-reg".
---

CD-ROM version 1.3
------------------
Data files: DARKWAR.WAD ROTTCD.RTC DARKWAR.RTL REMOTE1.RTS

Copy these files from your Rise of the Triad CD-ROM to
/usr/share/games/rottexpr/, making sure to give them all-uppercase names.
On my CD, there are two copies of the files (in the rottplay/ and
rottinst/ subdirectories). The REMOTE1.RTS is identical to the
one from the shareware and registered versions.

The binary for the CD-ROM version is called "rottexpr-cdrom". (The CD doesn't
have to be in the drive to play the game, though)

This version of the game is identical to the registered version except
that it uses a different set of levels for multiplayer games.

If you have an older version than 1.3, see http://www.3drealms.com/rott/
for a patch.
---

Data File MD5 sums
------------------
2823fe5baa07fa2a5a05df3af0cf8265  DARKWAR.RTC
d1f44aa4d1cb230ba6c3694acc09b6b7  DARKWAR.RTL
2ec4b19372d1ae55d01058f772f6214f  DARKWAR.WAD
4d90dec2da07a8eee1162efd3e23d98d  HUNTBGIN.RTC
b9b0a3be46a4f7fccabb1c1e8cf5455f  HUNTBGIN.RTL
37793500e3b1de2125a98604b69838e3  HUNTBGIN.WAD
190c69835af502e4d8f08ee733c3fcc5  REMOTE1.RTS
64c8e7123a7edcb7b8739b42cdae0120  ROTTCD.RTC

These md5sums are for the 1.3 shareware and CD-ROM versions of the game
(the files the SlackBuild author used for testing). If yours don't match,
they might be for an older version of the game, or they might be corrupt
(try them and see).
---

Wrapper Script (/usr/games/rottexpr)
--------------------------------
If you run "rottexpr" from the command line, or launch it from the KDE/XFCE
application menu, this script looks in /usr/share/games/rottexpr to see which
set of data files you have, and runs the correct game binary for you.

If the script finds ROTTCD.RTC, it runs rottexpr-cdrom
Otherwise, if it finds DARKWAR.WAD, it runs rottexpr-reg
Otherwise, if it finds HUNTBGIN.WAD, it runs rottexpr-demo
If none of the above exist, it exits with an error.

If you have the correct data files, you can always run rottexpr-demo,
rottexpr-reg, or rottexpr-cdrom directly, to choose which version of the game
to play. You probably should always do this for multiplayer games,
since all players need to be running the same version of the game.
---

Add-on Levels
-------------
Add-on level packs require the registered or CD-ROM version of the game.
To load them, use the "file", "filertl", and/or "filertc" options. Unlike
the main game data files, add-on files are searched for in the current
directory (or you can give the full path).

Example: to play the ROTT Reject Level Pack, download and unzip it, then
run:

$ rottexpr filertc REJECTS.RTC

...and then start up comm-bat mode.

RTL files are single-player levels and RTC files are for comm-bat
(multiplayer). Remember that comm-bat mode doesn't really work in this
port of ROTT (no networking code, so all you can do is run around by
yourself).
---
