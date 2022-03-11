Although EDuke32 has been released under the GPL, the game data
(graphics, sounds, levels, etc) is still proprietary.

For Duke Nukem 3D (eduke32), there are a couple of options:

- Buy the game, and copy DUKE3D.GRP and DUKE.RTS file from the game CD to
  /usr/share/games/eduke32/ or your ~/.config/eduke32 directory.

  Note: DUKE3D.GRP should be named "duke3d.grp" (lowercase), but DUKE.RTS
  should be uppercase.

- Or, install the eduke32_shareware_data package from slackbuilds.org. This
  only gives you the first episode of the game.

For Nam/Napalm (eduke32):

1. copy NAM.GRP or NAPALM.GRP to /usr/share/games/eduke32

2. copy GAME.CON to /usr/share/games/eduke32/NAM.CON (or NAPALM.CON).
   Do NOT name it GAME.CON, or Duke Nukem 3D will fail to start!

For WW2GI (eduke32):

1. copy WW2GI.GRP ENHANCE.CON, XDEFS.CON, and XUSER.CON to
   /usr/share/games/eduke32

2. copy GAME.CON to /usr/share/games/eduke32/WW2GI.CON (again, don't
   name it GAME.CON).

For Shadow Warrior (voidsw):

- Buy the game, and copy SW.GRP to /usr/share/games/eduke32/

- Or, install one or more of these SBo packages:

  jfsw_demo_data (shareware; first 4 levels only)
  jfsw_registered_data (full game)
  jfsw_wanton_destruction (expansion pack)
  jfsw_twin_dragon (expansion pack)

  (Yes, voidsw will find the game data in /usr/share/games/jfsw)

For Ion Fury (fury), presumably you copy the .grp file from the game
directory to ~/.config/fury. The engine doesn't look anywhere else for
the data files. I don't own this game, so I can't go into more detail.
If you do own this game, email me with the details and I'll update
this documentation.
