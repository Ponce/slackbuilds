-----------------------------------------------
Urban Terror: Total Conversion for Quake3:Arena
4.3 Release
http://www.urbanterror.info
-----------------------------------------------

This is the readme file for release 4.3 of Urban Terror.  
Please refer to http://www.urbanterror.info/ for further details.


Legal stuff
===========
FrozenSand accept no responsibility for any damage or injuries
resulting from use of this software. You download and install 
this software at your own risk. 

Urban Terror is a collection of files created by Frozensand Games Limited, 
community maps and community assets which are creditted in the map 
readme's. The files that constitute this modification are copyright 
Frozensand Games Limited 2000-2017. 

Use of any file contained within the mod is illegal without permission. 
Anyone wishing to re-use any of the media contained within the official 
release of Urban Terror should first contact Frozen Sand at 
http://www.frozensand.com or http://www.urbanterror.info 

Urban Terror is distributed free over the Internet and is covered by the 
Quake 3 SDK licence agreement [EULA]. The mod files may not be sold [in 
any form] or distributed on physical media unless with permission from 
iD Software. 

For further information on legal use of programs derived from Quake 3 
source code, please contact their respective authors. 


Installation
============
If you have Quake 3 Arena and want to continue using PunkBuster: Make 
sure you have Quake 3 Arena updated with Point Release 1.32(c) and 
update PunkBuster with pbsetup. Copy the q3ut4 folder from 4.3 to your
quake3-directory and make shortcut to quake3.exe. Add "+set fs_game q3ut4"
to the targetfield of the shortcut.

If you don't have Quake 3 Arena and/or don't care about PunkBuster: 
Run the 4.3 Auto-Updater or unzip the 4.3 zip.

Beta 4.3

The #<number> you can read in the changelog correspond to the issue numbers on our GitHub bug tracker.
https://github.com/FrozenSand/UrbanTerror4/issues


Beta 4.3.4 [21.06.2018]

- Fixed the random crash issues which happened especially (but not only) on the map Eagle #431
- Fixed several potential buffer overflow exploits
- Fixed the bug where unpinning a 2nd nade in a row and switching to another weapon would result in the nade being dropped on the floor. #26
- Fixed players being stuck with level 19 in Gun Game when g_randomorder was set to 1 #436
- Magnum: fixed the reload animation and the reappearance of the crosshair not being completely synced
- Bomb mode: fixed SurvivorWinner events not being written in the server logs in some situations. #293
- In order to free up some space in the "serverinfo" variable, and to try to prevent the "info string length exceeded" error messages on the servers, and the subsequent potential bugs:
    - Removed g_bombDefuseTime and g_bombExplodeTime from the serverinfo
    - Changed g_teamnameRed and g_teamnameBlue to g_nameRed and g_nameBlue
    - Removed the "Clan" and "Location" serverinfo vars from server_example.cfg - server admins are free to add them back to their configs if needed
    - Removed auth_tags, auth_verbosity, auth_cheaters and auth_log from the serverinfo as they weren't strictly needed
    - Removed dmflags from the serverinfo string, it's an unused leftover from Quake 2
    - This frees up about 115 chars in the serverinfo string
- Fixed output of the "where" client command
- Fixed map/next map vote menu ignoring previously highlighted map and calling vote with the first map on the list #122
- Menus: fixed inconsistencies in leading space in weapon select screen. #304


Beta 4.3.3 [28.02.2018]

- Fixed CVE-2017-6903 #73
- Fixed a potential buffer overflow exploit with the funstuff cvars
- Fixed a potential exploit with the cl_guid variable
- Fixed a potential exploit: do not allow loading .menu files from the /download/ subfolder and enforce menu files to have the .menu extension
- Fixed a potential exploit where the result of the /stats command called by a spectator while following a player would be sent to the followed player instead of the spectator
- Fixed a potential exploit with ROM and INIT cvar types being forced to USERINFO
- Fixed the server browser not showing any server when using the legacy Quake 3 engine
- Fixed modern ioq3 engines crashing with the error "Engine linkage error #31" #399
- Fixed the substitute status being sometimes applied when g_matchmode = 0 #404
- Fixed substitute players randomly spawning and being invincible on map restart in certain game modes
- Fixed wrong value of y-axis being used when loading a saved position in Jump mode #80
- Jump mode: fixed persistent position saving which was sometimes loading another player's saved position #131
- Gun Game: fixed being stuck with the HK69 when playing with g_randomorder 1 #394
- Tweaked the FR-F1: torso/vest hits make players bleed. Zoom reset if getting >= 50% of damage (previously: 20%)
- Tweaked P90's and Benelli's positions on screen #217
- Potentially fixed fire mode of a spectated player's weapon being sometimes picked up #7
- Fixed bots failing to load on Cascade and Kingdom
- Tweaked bot files for UrT 4.3.3
- Fixed g_inactivity timer inconsistencies #414
- Fixed the rcon "players" command that wasn't always displaying player's auth names #419
- Fixed /rcon players command returning wrong slot and IP values for clients
- Added current half info to /rcon players if g_swaproles is set to 1
- Fixed a bug where a map_restart after changing the g_matchmode cvar would spawn the same random weapon an infinite number of times #81
- Fixed g_redteamlist and g_blueteamlist not always being recognized as valid server cvars #83
- Potentially fixed the "Couldn't find weapon xx" error which was introduced in 4.2.014
- Fixed the TOD50 texture file size which was causing a crash on map load when using the legacy Quake 3 engine
- Updated quake3's master server port in server_example.cfg (please update your custom server configs!)
- Fixed the server browser showing several times the same servers when quickly refreshing the list multiple times
- Clarified server browser filter options
- Fixed a bug where spamming a key binding while downloading a map would result in a "client overflow" game crash
- Fixed ignore list not being saved on map reload/change and other inconsistencies with the /ignore command #23
- Replaced all .png textures with .tga textures to fix some UI elements not being displayed correctly when using the legacy Quake 3 engine


Beta 4.3.2 [04.02.2017]

- Engine: Build optimizations, full SSE/SSE2 support on Windows
- Engine: Locked sv_fps / snaps back to 20 #348
- Engine: New mouse acceleration style 2 (cl_mouseAccelStyle 2), with logistic curve for smooth and limited accel #54
- Engine: Various fixes for OpenBSD and 64bit systems #59 #60
- Engine: Updated Q_CleanStr to discard multiple color code prefixes and fixed broken COM_GetExtension #63 #38
- Engine: Fixed 'stopserverdemo' being called on clients where the command doesn't exist #63
- Scoreboard columns sorting update: KAD columns now reads KDA (kills, deaths, assists)
- Added assists to player sorting (K>D>A) on scoreboard
- Renamed ".44 Magnum" to "Magnum" in the kill events
- Fixed scores not updating in time when moving to intermission #142
- Fixed $gametime and $roundtime calculation #346
- Instagib: Prevent bots from switching to knife 
- Instagib: Display a gamemode explanation text + an 'INSTAGIB' box in the team selection menu
- Instagib: Disabled the gear selection menu in InstaGib
- Instagib: Everyone has a medkit as their sole item 
- Instagib: Added a gamemode identifier, ' - INSTAGIB' next to the game mode name  on the map load screen
- Gun Game: Added a cvar g_randomorder (0/1): random gun order on map load
- Gun Game: Fixed scoreboard sorting inconsistencies #319
- Gun Game: Fixed a possible server crash when two players would win at the exact same time (very unlikely)
- New sound for the Glock when a silencer is equipped
- Minor weapon specs enhancements
- Fixed 'bot_minplayers' not working properly
- New version for Paris fixing #335 and #361 along with other enhancements
- Added support for r_noborder in the menu files
- Fixed weapon verification of items when primary is 'none' #320
- New .arena scripts for maps to include the newer gametypes in the server creation menu
- Updated default.cfg, server_example.cfg & mapcycle_example.txt
- The rcon command 'players' now displays correctly auth logins and and assists were added


Beta 4.3.1 [05.10.2016]

- Fixed the FPS drops / lag issue #334
- Slightly improved engine performances on Windows
- Fixed Ghosttown, Paris, Mykonos appearing as 3rd party maps in the server browser #296
- Added instagib to server_example.cfg #342


Beta 4.3.0 [30.09.2016]

- New gametype: Gun Game (g_gametype 11)
- New game mode: Instagib (affects all gametypes with the cvar g_instagib 1|0 (1=on, 0=off))
- New gear menus
- New weapons: FR-F1, P90, Magnum, Benelli
- Unlocked sv_fps and snaps (range: 20 - 125, default: 60)
- Updated AK103 bullet description
- Added kill assists in team gametypes
- Added silent ladder walking (hold your walk key while climbing ladders)
- Hid the "ut4_" prefix in the server list for map names
- Adjusted weapon/item drop velocities (they drop towards where you aim rather than from your groin all the time)
- Added ut_echo $cvar substitution
- Added cg_chatBG (0 - light, 1 - dark, 2 - dependent on speed)
- Added cg_chatOrder (1 - messages are displayed from top to bottom, 2 - from bottom to top)
- Updated console design
- Added console tabs
- Added cg_radioPos (0 - normal, 1 - directional, 2 - directional + distance like the player is yelling)
- Added support for choosing no primary weapon (it was possible before if you edited the 'gear' cvar)
- Added ammo colours
- Added centered team scores (cg_drawTeamScores 2)
- Added movement keypress overlay: cg_drawKeys (1 - visible only when in spectator, 2 - always visible)
- Fixed defusers appearing dead on the miniscoreboard #191
- Fixed some issues with the /me command
- Fixed unknown values for $crosshair #185
- Fixed player name colouring in FFA #192
- Fixed cooked grenades being fired and dropped on death
- Cleared filter bar on connect #178
- Fixed stamina drain on ladder sprinting #188
- Blocked multiple flags from being taken by the same player
- Fixed use key pickup not working on some maps #135
- Fixed the ability to boot another player while holding the jump key despite being on the ground

- New: admins can perform rcon commands directly from the in-game chat box without having to know the rcon password. Everything is handled by the auth system. Documentation incoming.
- New: auth-unban rcon command. AccountUnban in the server logs
- Fixed the Benelli and the P90 looking too small
- Fixed the missing TOD50 skin and icons
- Tweaked the P90: less damage, more accuracy
- Disabled the countdown sound by default
- Gun Game: added a mandatory helmet to everyone
- Gun Game: added the weapons introduced in 4.3
- Gun Game: fixed the level randomly showing 0/16 on the HUD
- Gun Game: latched the cvar g_hardcore (needs a reload to be applied)
- Gun Game: added the player's level to the scoreboard, and players are now sorted by their level
- Gun Game: fixed being downgraded 2 levels when booted or killed with a knife
- Gun Game: fixed earning a level when killing yourself with the HK69. Downgrades a level instead

- Weapons: SR8 - tweaked damages (%): (Groin, Butt) from (97, 90) to (100, 97)
- Weapons: FR-F1 - tweaked damages (%): (Groin, Butt) from (70, 70) to (77, 74)
- Weapons: PSG1 - tweaked damages (%): (Groin, Butt) from (70, 70) to (75, 70)
- Weapons: M4A1, LR300, G36 - tweaked damages (%): (Groin, Butt) from (37, 33) to (33, 31)
- Weapons: DE - tweaked damages (%): (Groin, Butt) from (45, 41) to (42, 40)
- Weapons: MP5K - tweaked damages (%): (Groin, Butt) from (25, 22) to (24, 22)
- Weapons: UMP45 - tweaked damages (%): (Groin, Butt) from (36, 32) to (33, 31)
- Weapons: AK103 - tweaked damages (%): (Groin, Butt) from (41, 34) to (39, 35)
- Weapons: Negev - tweaked damages (%): (Groin, Butt) from (25, 22) to (24, 22)
- Weapons: Beretta - tweaked damages (%): (Groin) from 25 to 24
- Weapons: reduced P90's muzzle flash #219
- Weapons: added back the P90 as a secondary weapon
- Weapons: tweaked P90's damages, spread and recoil
- Weapons: tweaked Magnum's damages
- Gear menu: added a "close" button at the bottom-right corner
- Gear menu: swapped the "secondary weapon" and "grenade" boxes
- Gear menu: fixed a crash when trying to select a secondary weapon while having no primary weapon #221
- Gear menu: fixed P90 being selected as primary disabling the Benelli as a secondary #229
- Gear menu: fixed being able to have no items at all. Also fixed a bug where your whole gear would reset if you clicked somewhere outside the list of weapons on the menu. #213
- Gun Game: added a smooth transition between weapons when leveling up
- Gun Game: fixed knife kill not demoting a level #225
- Gun Game: fixed the gametype showing up as "UNKNOWN" in the server browser #215
- Gun Game: fixed having a delay before being able to shoot after a level up #224
- Gun Game: added more ammo to the HK69 in hardcore mode
- Instagib: fixed TOD50's positioning #216
- Instagib: removed the movement penalty indicator for the TOD50 #216
- Instagib: the TOD50 now has infinite ammo #216
- Instagib: showing the number of bullets in red if the weapon isn't ready 
- UI: capitalized prefix-less map names in the server browser #215
- UI: added cg_scopeFRF1 to customize FRF1's scope type #232
- UI: Added the ability to use custom crosshairs
- Chat: added /map and /devmap to the auth-rcon commands
- Chat: fixed a buffer overflow on /me and /chat messages #210
- Rcon: new command: forceall <team> <destination> to force all players from a team to join another team
- Rcon: new command: kickall <team> <reason> to mass kick teams or all players from a server
- Rcon: extended the players command with more information
- Misc: Removed the "missing sound" beep #246
- Misc: If dmaHD is disabled, don't show its settings #245
- Misc: Added a 'Device' menu setting. #245
- Misc: Updated the credits menus #205
- Misc: repackaged the game

- Menus: gear selection menus overhaul
- Weapons: New sounds for the following weapons: Magnum, Benelli, Colt 1911, FR-F1, Mac 11, P90 and PSG1
- Weapons: fixed the reflection on the scopes of the FR-F1, SR8 and PSG1
- Weapons: fixed the "empty ammo" sound not being triggered #256
- Match mode: fixed substitute status not being applied consistently after a map change #6
- Server: fixed not being able to change g_gravity's value through the mapcycle.cfg file #263
- Bots: fixed bots shooting at dead players #242
- Engine: use libcurl version 4 by default instead of v3
- Misc: new blue/red/neutral flag designs
- Misc: fixed tag goggles overlay not being visible to spectators. #262
- Misc: fixed team chat not working #265
- Misc: fixed custom func_wall / func_rotating_door not working properly in LMS gametype #259
- Misc: defaulted sv_floodprotect to 2

- Gameplay: fixed incorrect assists counting #271
- Maps: added ut4_mykonos_a17 and ut4_paris to the official pk3
- Maps: removed AbbeyCTF, Ambush, Commune, Company, Crossing, Harbortown, Horror, Maya, Prague_v2, Snoppis, Toxic and Tunis from the game pack.
- Engine: added 64bit support on OSX. Removed 32bit builds (< OSX 10.6) #52
- Engine: added OpenBSD support #51
- Engine: added r_noborder to remove the game's window borders #283
- Engine: added r_centerWindow to center the window when not in full screen. Defaulted to 1. When set to 0 with r_noborder, use vid_xpos and vid_ypos to set your window in a custom position
- Engine: fixed chat messages disappearing when being sent at the moment of your death #261
- Engine: added the ability to switch between console tabs with MOUSE1 (next tab) and MOUSE2 (prev tab)
- Engine: fixed bots using slots reserved for private clients
- Weapons: DE: butt -2pts of damage
- Weapons: Beretta: updated full damage table
- Weapons: Negev & M4A1 & LR300 & AK103 & G36: updated groin/butt damages
- Weapons: SR8 & PSG1 & Knife: updated damage table
- Weapons: COLT1911: reduced recoil. Torso/Vest +3pts of damage
- Weapons: Glock: updated full damage table
- Weapons: Mac 11: updated full damage table. Increased the fire rate a bit
- Weapons: FN P90: updated full damage table
- Weapons: FR-F1: updated full damage table
- UI: added a box on the main menu to display announcements
- UI: fixed the server browser displaying the wrong number of bots #273
- UI: fixed the gear getting reset when switching to the team selection menu #272
- UI: new controls menu dedicated to item binds (drop kevlar, drop flag, toggle laser, toggle nvg) #264
- UI: hide the team select buttons in non team gamemodes #275
- UI: fixed the Benelli icon overlapping its box in the gear selection menu #282
- UI: added cg_autopickup to options #252
- Gun Game: show the winner on the scoreboard at the end of the game #274
- InstaGib: added a callvote option to set g_instagib
- InstaGib: disabled in Jump Mode and Gun Game
- Misc: fixed hands and gun models glitching out when repeatedly setting cg_fov to an incorrect value #291
- Misc: fixed an issue with ut_weaptoggle when holding two secondary weapons #290

- Gameplay: fixed a regression with ut_weaptoggle #297
- Instagib: fixed random client crashes when playing INSTAGIB #234
- Instagib: fixed TOD50's odd recoil movement. #316
- Instagib: fixed being able to switch/drop the TOD50 before its cooldown end time #322
- Engine: swapped MOUSE1 and MOUSE2 for the console tabs switch
- Engine: fixed in_mouse 1 not toggling console tabs
- Weapons: fixed some fps drops due to high poly LODs of the benelli and the p90

- See the full release notes here: http://www.urbanterror.info/support/244-4-3-release-notes/


Beta 4.2.023 [19.01.2015]

- Fixed strat time causing early match termination
- Fixed flag return message colour #176
- Fixed negative team scores #177
- Added s_alttabmute CVAR to control sound when game is in background. Values are: '1' for Mute (default) or '0' to keep sounds playing when game is in background. (Windows only)


Beta 4.2.022 [20.12.2014]

- New cvars to modify the text size: cg_msgSize and cg_chatSize
- Servers now issue a DNS lookup for the master server on map change
- Game clients now check for other master servers when the main one is down
- Randomized team join when all factors are equal (when the scores and numbers of players were equal, you would always be placed on the red team)
- New commands accessible through ref access: swap, pause, reload, restart, nextmap, cyclemap, map, exec, veto
- Added a g_refNoExec cvar to control referee access to the exec command
- Added primary, secondary, sidearm, grenade, and bomb arguments to ut_weapdrop #157
- Added a bot indicator and filter in the server browser menu
- Added "(next: map)" to the cyclemap vote string when g_nextmap is set
- Updated g_stratTime to not cut into play time
- Added cg_leftHand
- Improved the team scores visual in HUD
- Disabled non-numeric characters being used for colour codes (this means '^a' is not a colour anymore, but you can now use the caret in chat)
- Enabled the percent (%) character for use in chat
- Enabled the semicolon (;) character for use in chat
- Added IRC-style /me command (works in chat as well)
- Added flag drop bind to the menus #124
- Added filter bar in the server browser menu
- Reorganized the "General Settings" panel and added a "Meter Settings" panel
- Added detection for vote keys #17- 
- Enhanced dropped bomb visibility on the minimap #155
- Fixed defusing player status shown as dead #149
- Improved flood protect limitations: its value is the number of commands you can perform per second #154
- Fixed a swap command issue #150
- Fixed g_maxGameClients not working properly #146
- Fixed g_ctfUnsubWait which never had worked properly #158
- Fixed missing textures on some SPAS hits #160
- Fixed gear menu showing outdated gear when using gear binds #159
- Fixed team scores not appearing until the scoreboard is opened
- Fixed the CI message displayed on map end for subs #113
- Fixed the multiple bomb carriers in blue team issue #148
- Fixed missing cvar g_nextCycleMap #53
- Fixed the wrong time being displayed on scoreboard #47
- Fixed server command overflows during timeouts (also fixes huge demo sizes during timeouts) #163
- Fixed stupid radio menu behaviour - now only the 0-9 binds will be suppressed #3
- Suppressed hit logging if target is frozen or god #164
- Fixed reversed score order when Blue team wins #170
- Fixed missing Freeze Tag label for g_gametype votes #172
- Fixed $crosshair not working properly in some cases (and also allowed chat variables to be used when dead) #166
- Fixed most custom maps not appearing in the vote menu #167
- Fixed an exploit when spectating the referee #173

Beta 4.2.021 [15.11.2014]

- Updated text with new font (Roboto) and drop shadow
- Decreased font sizes around the HUD
- Revamp of the mini scoreboard and team overlay
- Updated netgraph
- Updated the player health and damage area. There's now a health percentage indicator (toggleable with cg_drawhealth)
- Improvement of the item and weapon select boxes
- Enhancement of the "3, 2, 1, Go" beep on warmup countdown
- Added cvar: cg_countdownSound to disable the "3, 2, 1, Go" beeps
- Updated the timers - right aligned and new timer and hotpotato icons
- Highlighted map names in orange if they need to be downloaded (in the server browser menu)
- Added $hp chat var
- Updated chat variable substitution. Variable names that are not recognized by the server will not be consumed (you can now type $100)
- Updated the vote HUD element
- Used Team Survivor walls in Freeze Tag
- Added forcesub rcon command
- Added forcecaptain rcon command
- Combined red and blue wave timers if they're equal
- Added cg_showbullethits 3
- Added ability to use "all" with the forceteam command
- Added swap rcon command to swap two players
- Fixed spawn arrangement on Docks #100
- Fixed a missing texture on Ricochet #110
- Fixed the occasional timeout flights #114
- Fixed status of defusing players being set to "FRZN" #115
- Made dropped bomb yellow on the minimap #82
- Fixed cumulative g_inactivity timer #41
- Fixed blurry ammo icons
- Fixed speedometer and accelerometer positioning when cg_hudWeaponInfo allows it
- Fixed speedometer overlapping weapon info
- Fixed helmet being rendered on top of NVG shader
- Fixed "x team wins" not using the right skin name #132
- Fixed bomb being lost to the void #11
- Fixed first shot accuracy in perfect conditions #134
- Changed LEADER to LEAD on the scoreboard status in FTL #138
- Fixed C&H flags not being counted on timelimit is hit
- Fixed skin readme text positioning #136
- Fixed skin selection menu starting empty #118
- Unlocked cl_pitchspeed #139
- Changed "Enemies: x" to "Players: x" in Jump mode

Beta 4.2.020 [30.09.2014]

- Fixed flag taken sound not playing #5 #14
- Fixed ThawOutStarted log spam
- Cleaned up disconnected thaw targets #90
- Added completion for forcesub, goto, load, save, and timeout #46
- Reset player stamina when frozen #94
- Added keycatcher for radio UI #3
- Fixed scoreboard showing "kills" instead of "points" for the blue team #70
- Fixed scoreboard/miniscoreboard showing thawed players as dead #70 #92
- Changed scoreboard status to FRZN for frozen players
- Restored flags on gear change #11
- Fixed frozen players' hitboxes #88
- Added a bar for players who are being thawed out #89
- Moved the thaw progress bar down #91
- Reset the match state when swapteams is called #98
- Set the player's leg model to crouched if frozen in a position where they can't uncrouch #99
- Made frozen players' arrows flash cyan on the minimap
- Fixed live player counting for Freeze Tag #92
- Added a puff of snow for freezing, thawing, and melting
- Fixed bots timing out if bot_pause is 1
- Fixed frozen players taking environmental damage #106
- Fixed login button drawing #71
- Fixed players showing up as frozen when the round starts #111
- Added countdown sounds for pre-game timers
- Fixed frozen players' helmets not showing #64
- Fixed stats menu not working when dead or spectating #39
- Fixed give server crash #40
- Allowed gravity to affect frozen players (this also allows them to be booted)
- Allowed frozen players to be shot to prolong their frozen state

Beta 4.2.019 [14.09.2014]

- New gametype - Freeze Tag (#10) - new CVARs g_thawTime and g_meltdownTime - new log lines 
- New map ut4_prominence 
- New map ut4_killroom 
- New g_stratTime CVAR - strategy time at round start in Team Survivor and BOMB modes 
- Fixed hotpotato timer not stopping on timeout 
- Fixed crash when using map and devmap server commands 
- Fixed a "round end" message loop happening when only one player is connected in FFA gametype 
- Fixed the flag capture time bug in jump mode 
- Fixed a crash in the demos ui page 
- Fixed a possible crash on map load on OSX 
- Fixed a "signal 6" crash on OSX 10.9 
- Fixed the copy/paste causing engine crash on Unix systems 
- Fixed malformed reply to the /ignore command #10 
- Fixed ut_weaptoggle grenade malfunction when having two types of grenades #4 
- Added a flood protection on weapon mode change #32 
- Fixed callvote kick bug where another player could be kicked 
- Fixed client number for callvote server log messages 
- Fixed callvote map unpredictability and server log messages 
- Fixed some HUD elements being displayed while the client was paused #36 
- Added a client info cvar named authl containing player's auth name when authenticated #35 
- Unlocked the download speed of map packs #44 
- Fixed dmaHD entering an infinite loop on certain maps #34 
- Made the reconnect command work across a client restart #40 
- Fixed the forcesub broadcast message #50 
- Fixed bomb plant time crashing the server #52 
- Fixed tell command not targeting the correct user #19 
- Fixed medkit icon not appearing or randomly flickering #17 
- Fixed third person mode persisting in sub #43 
- Fixed Client 0 getting the kill on certain bleed outs #78 

Beta 4.2.018 [25.01.2014]
 
- New g_gear restriction code. It now uses weapon/item letters so you can disable whatever weapon or item you want.
- Changed the medic badges back to the caduceus.
- Solved FPS drops introduced in 016/017 client.
- Fixed the issues with auth_owners.
- Fixed the "auth string output overrun" issue.
- Solved 'callvote map' problem where results can be unpredictable.
- Fixed client number in callvote server log entry.
- Fixed callvote kick bug.
- More checks for pure servers.
 
Beta 4.2.017 [17.12.2013]
 
- Fixed teambalancer-skin bug
- Fixed chat overflow bug (was overflowing on the team overlay)
- Fixed the flag capture time
- New cvar: cg_drawFlagCaptureTime (0: no time shown, 1: time in seconds, 2: time in seconds and milliseconds)
- All UrT executables are now compatible with older CPUs
- dmaHD sound system is on by default on the UrT executables
- Fixed mousewheel scrolling of console
- dmaHD: Fixed annoying clicks/echoes with some weapon sounds
- dmaHD: Re-introduced all the old mixers (CVAR: dmaHD_mixer)
- Autobalance turned off by default

Beta 4.2.016 [16.11.2013]

- Fixed the bug in the Auth System that appeared since 4.2.015 where sometimes lag in authentication could lead to use the account name of the previous player on the same slot
- Fixed the "badinfo" issue (many thanks to Jacepriester)
- Animation config updates
- New Dr. Pink and Dr. Blue player skins
- Correctly disable inactivity timer when g_inactivity is set to 0
- Ability to set skins per team using cg_skinfixed0|1
- Increased minimum value of com_hunkmegs and made the error message Hunk_Alloc failed on... more understandable
- Updated Mac11 sounds
- Fix for specularity on SR8 (very noticeable on bolt cap)
- Fixed lagometer position on CTF when using Wave Respawns
- Enhanced cg_speedo CVAR: will display client speed using (1) UPS: Quake units per second, (2) KPH: Kilometers per hour, (3) MPH: Miles per hour
- Fixed killsound not being played upon HE Grenade kill and bleed out
- New sniper crosshair: cross-dot (cg_scopeSR8|cg_scopePSG|cg_scopeG36 4)
- Fixed skeetshoot map reloaders: fix target_give not resetting state after execution
- New crosshair: cg_drawCrosshair 14 (simple cross Quake 3 style). Available in UI menu
- Fixed respawn timer being shown after map restart
- Added 0 padding in asset download time left and server list refresh time
- Added sound on weapon mode change
- Added accelerometer configurable with cg_accelero 0|1|2 and UI menu
- Added cg_accelSize CVAR to tune dedicated accelerometer size
- Fixed bots being kicked from the server for teamkilling
- Added TeamBalancer. Can be controller with g_autobalance CVAR (0 = disabled, 1 = balance every minute, 2 = every 2 minutes, etc)
- Added g_noVest CVAR for Jump Mode: is set to 1 removes the Vest from all the players
- Added client respawn event to game log: ClientSpawn: <slot>
- Fixed impossibility to kick zombie clients off the server
- Fixed connection to full server resulting in Server is for low pings only
- dmaHD engine forced to 44Khz 16-bit stereo output
- Increased command buffer from 64KiB to 128KiB for players with large config files
- Added separate Windows executable for non-SSE2 processors
- Fixed substitute flag being resetted upon map change
- Correctly update client team overlay when /forcesub command is executed
- Added menu items in sound menu for configuring dmaHD
- Added more in-built r_mode graphics modes for wide screen monitors
- Added new wide resolutions in graphics menu
- Increased chat area width and message area width
- Hide timelimit from HUD if there are no valuable info to be displayed
- Fixed inactivity timer kicking local client thus causing all the players to be disconnected
- Added flag capture time. New log string: "FlagCaptureTime: <player id>: <time in milliseconds>"
- Major overhaul of dmaHD sound system 

Beta 4.2.015 [27.09.2013]

- New authentication protocol securized
- Fixed the alignment of a window texture on one of the buildings in the nonplayable area of Turnpike
- Fixed respawn protection hits being displayed in Jump Mode
- g_shuffleNoRestart - possibility not to restart a map after shuffle
- g_inactivityAction - defines what to do with inactive player (0 - kick, 1 - move to spec)
- Increased Colt spread
- Fixed 1911 whiteout bug
- Re-timed 1911 reload animation
- Decreased the specular effect on the colt1911 and darkened the current texture
- Decreased the specular effect on the SPAS12
- Updated Mac11 sounds
- Reduced Mac11 spread
- Improved ut_itemuse (supports string arguments now, e.g. "ut_itemuse nvg")
- Fixed wave respawn timers not showing in freecam
- Enhanced QVM load fail message ("VM_Create failed on UI" and "Invalid game folder")
- Added support for Console and UI fields pasting on Linux and Mac OSX (CTRL+V)
- Improved FFA/LMS spawn selection system
- Added cg_noci which disables the "Connection Interrupted" message when set to 1 (mostly for demos)
- Added [b]cg_cleanFollow[/b] which disables some of the instructions displayed when following players
- Added Match Mode Ragequit protection (on a paused game, when an entire team disconnect from the server, reset match status and clear the pause)
- Display the current nextmap upon g_nextmap callvote
- Do not reset scores when going substitute
- Removed [b]racejump[/b] CVAR: using only racefree for solo modes
- Changed the vests and helmets for the SWAT and Red Dragons to 4.1 solid colours
- Changed the vests for Free team to dark grey
- [b]cg_exposeBots 0/1[/b] - visual bot identification (name transparency, ping ---)
- Disable bind execution when radio UI is opened
- [b]cg_drawMapLocation 0/1[/b] (configurable in minimap settings UI) - constantly displays current map location near health bar 
- Allow walljumping without actually jumping before (falling) - 4.1 behavior - eg. turnpike window stairs to wc jump
- Changed colours to team names in the player set up menus eg: orange is now Fugitives
- Enabled missing radio calls in Jump mode and enabled UI radio menu
- Correctly stop Jump timers on Timelimit Hit and map restart
- Added missing log lines for VotePassed and VoteFailed (for external bots)
- Added cg_killsound CVAR: will play a local sound when the hit enemy is killed
- New damage values for Groin (97%) and Butt (90%) when using SR8
- Added a new map by Nounou called ut4_ghosttown_RC4


Beta 4.2.014 [14.07.2013]

- Fixed cg_ghost not working properly
- Fixed map autocomplete with many maps
- Optional new compressed pure list format for servers with many maps (sv_newpurelist)
- Removed command /maplist: it's causing lags if the server has a lot of maps
- Disabled dmaHD by default
- Correctly lock g_stamina to be changed only in Jump Mode
- IP banlist '*' wildcards and fix for '0' in address
- Fixed mouse cursor shows up with some of the in_mouse settings 
- Fixed Vote kick which was inconsistent and buggy
- Fixed player being forced to spectator on a new level
- Fix broken timers after swaproles
- Fixed broken wave respawn timer after paused game
- Fixed Colt animation mismatch
- Tuned up Glock specs
- Remove dropped items and corpses during TS warmup

Beta 4.2.013 [30.06.2013]

- Fixed the seam on the back of the SR8
- Fixed the doors near the pillars and some z-fighting on Turnpike
- Fixed missing skin on team swaps
- Restore previous behaviour of armband colour for enemy team
- Fixed no step sound mode Jump mode when landing on a normal surface and g_nodamage is enabled
- Fixed /ignore and /ignorelist commands
- Added new command /maplist which will display all the maps available on the server
- Added partial substring matching for client/map searching
- Added visual player count in scoreboard for both free and spectator teams
- Removed g_ghostPlayers CVAR. Feature moved clientside: cg_ghost 0/1
- Updated UI password filter's labels in the server browser: zUrT42_0009_2013_06_03a
- Renamed CVAR: g_maxWallJumps -> g_walljumps
- Renamed CVAR: cg_showFunstuff -> cg_funstuff
- Renamed CVAR: g_allowFunstuff -> g_funstuff
- Merged g_noStamina and g_regainStamina into g_stamina: 0 = default stamina, 1 = regain stamina, 2 = infinite stamina
- Renamed CVAR: g_allowForceSkins -> g_skins
- Renamed CVAR: g_maxJumpRuns -> g_jumpruns
- Removed SERVERINFO flag from g_cahTime
- Fixed SPAS hits being displayed after player death
- Added missing BOMB defuse autoradio sound
- Added new hitlocations: Groin, Butt, Leg Upper Left, Leg Upper Right, Leg Lower Left, Leg Lower Right, Foot Left, Foot Right
- Updated damage table according to the new hit locations
- Fixed some char cases in in-game messages
- Added goto and allowgoto commands for Jump Mode (can be disabled with g_allowgoto 0)
- Added permanent position saving in Jump Mode
- Added Ingram Mac11 (submachine gun) and Colt1911 (sidearm)
- Added a new skin set based on the Droogs from A Clockwork Orange (it is #12)
- Fixed bug allowing players to defuse bomb with a live nade in hand
- Fixed bug showing hits causing 0% damage with the spas
- Added cg_chatSound, (2 = all chat sounds, 1 = just vote sounds, 0 = no chat sounds)
- Removed cg_sfxteambands (unused cvar)


Beta 4.2.012 [19.04.2013]

- Medic and bleeding timing improved
- Fixed the armbands on race 1 and 3 of the Cavalry skins
- Fixed the clipping issues on Prague v2
- Increased the brightness inside the office on Turnpike
- Fixed callvote kick bug
- Fix for missing skins on startup
- Added funstuff with new cvars (g_allowfunstuff, cg_showfunstuff and  funfree for FFA game modes (uses red team funstuff only))

Beta 4.2.011 [06.04.2013]

- Fixed g_maxWallJumps CVAR slowing down walljumps (need QA test)
- Improved g_noStamina. Was causing some glitches (only in Jump Mode)
- Fixed BombDefuse display message
- Fix teamoverlay colors for cg_drawTeamOverlay 2/3/4
- Added Mouse Wheel support for in-game server browser
- In-game server list scrolling is now noticed also by a sound
- Fixed server list scrolling to the top after adding a server to the favorite list
- Added Cavalry skin set
- New hit reporting for SPAS (multiple hits and players)
- Fixed Glock sound
- Fixed funny death animation
- Prague V2 - Updated with HD assets and routes
- Fixed connecting to GTV
- Fixed player names' colours in chat and radio chat messages
- Added markers of legacy team in chat
- Changed orange team name to 'Fugitives'
- Fixed colour typo in auth console message
- Fixed instant medic upon multiple hits
- Torso has priority over arms in hit detection
- Allow instant skin selection during demo playback
- Fixed timer alignment in round based modes when using round limits
- Updated the lighting in Turnpike so that it is closer to the 4.1 lighting

Beta 4.2.010 [22.03.2013] 
- Added g_maxWallJumps CVAR for Jump Mode only. 
- Preloading radio sounds and misc sounds to avoid client freezes on first playback. 
- Fixed the ClientJumpTimerStopped log event that was returning a time of 0 secs. 
- Fixed negative enemy counter in mini scoreboard in FFA/LMS gametypes. 
- Fixed UI cursor displayed during leve loading. - Fixed big jump maps loading failure. 
- Fixed ut_weaptoggle behavior. 
- Not checking bots inactivity timers anymore. 
- Added /ignore and /ignorelist commands. 
- Fixed CAH miniscoreboard. 
- Fixed Jump Run timer not displayed correctly while spectating a player. 
- Fixed invalid player DEAD/ALIVE status in miniscoreboard. 
- Disabled auth account check for bots to avoid auth-reject when auth_notoriety > 0. 
- Don't have g_teamAutoJoin affect bot's team. 
- Fixed spectator being switched from follow to free after map_restart when following a client. 
- Fixed server browser 'Auth' and 'Password' filters. 
- Added g_maxJumpRuns CVAR for JUMP mode only (available when g_matchMode is 1). 
- Changed some JUMP in-game messages. 
- New log format for Jump mode entities actions. 
- Fixed a bug in save and load command (player view angles are now reset correctly). 
- Fixed blue armband showing on red team players minimap arrows - Updated the Glock sounds. 
- Fixed a wall that you could be shot through in Turnpike. 
- Added client-side skin forcing.
- Added six new skin sets. 
- New player setup menus.   

Beta 4.2.009 [21.12.2012]
- Updated ut4_ramelle's tunnels, removed some plants in the water, removed some buildings in the non-playable area and added some vis blocking to improve fps.
- Updated scoreboard.
- Fixed jump timer colors display while watching a player from spectators.
- Fixed armband vertical alignment in scoreboard.
- Fixed miniscoreboard not updating player status after a player respawns.
- Fixed player bandage while healing close to walls.
- Fixed ut_weaptoggle
- Enhanced cg_autopickup 0. It now pickup just the item the player is aiming at.
- Fixed g_flagReturnTime being ignored.
- Enhanced RCON UI menu. Fixed some graphic bugs and added new features.
- Updated the FFA/LMS spawns in ut4_uptown.
- Fixed "header" warning message for the mirror1.tga.
- Added Glock 
- Added new Spas icon.
- Fixed a bug in Stats UI menu.
- Optimized QVM.
- Added new entity ut_jumpcancel to cancel a player run and reset the run timer.
- New version of ut4_jumpents test map with new ut_jumpcancel entity.
- Jump mode: colored ways
- Description: Added option to set color to jump ways. Using "color" key for jump_start, you specify color 0-8, same as for console ^codes. When not specified, white is used and everything looks like before. Colors are used when telling player name of the way and for best time shown on score board. This makes it easy to see which way players are currently on and best times are for. There is updated ut4_jumpents.pk3 in my dir, hard way is magenta, easy way yellow.
- Fixed blood when shooting walls, uses UrtHD sparks now and looks just as cool.
- Fixed jump timer >1 hour bug.
- Added Glock to ut_weaptoggle.
- Fixed UI ingame select gear not being validated when pressing ESC.
- Fixed the "server is for low pings only" issue


Beta 4.2.008 [03.12.2012]
Fixed the server lag crash issue.
- Fixed the client crash when selecting a weapon.
- Potentially fixed the FPS issue.
- Player model animations updated.
- Fixed the SPAS which was causing excessive bleeding.
- Fixed the Auth System logout UI bug.
- New skins for FFA, LMS and Jump gametypes.
- New /racejump and /racefree cvars.
- New color for FFA and LMS HUD.
- Fixed Eagle's cable car.
- Fixed FFA UI scoreboard bug.
- Fixed SPAS gear bug.
- Defaulted player armband to light purple in JUMP mode when set to g_armband 1.
- Fixed a bug in callvote kick UI menu.
- Enhanced kill display, new options cg_drawKillLog 3|4|5 available, added to UI menu.
- Fixed punctuation and some spelling in kill display.
- New images for the player setup menu.
- New player setup menus for the Free and Jump teams.
- Added player's login to the scoreboard.
- Fixed a bug in the "smite" command help text.
- Changed the player bar color in the scoreboard for FFA, LMS (Green) and JUMP (Purple) to match the HUD color.
- Added fog to the water in ut4_ramelle.
- Added a workaround to reduce flag cap spamming in Jump Mode, sounds and messages are shown only to the flagcarrier.
- Added a cvar ui_modversion which displays the current mod version in the game menu.
- Reduced the range of the cvar r_primitives.
- Added run timer and best timer in the scoreboard for jump mode.
- Added jump mode timers.


Beta 4.2.007 [16.11.2012]
- Updated the Hit Mesh.
- Updated Linux updater binaries (GUI and command line): improved compatibility with older distributions.
- Updated the OSX engine to catch up with the 006 update for Windows and Linux.
- Fixed g_noStamina being used in other gametypes than Jump.
- Fixed "ut_itemdrop flag" in Jump mode.
- Fixed cg_autopickup 0 bug.
- Fixed g_gear change server message.
- Fixed regain stamina bug on damaged player.
- Fixed a bug where the stamina would drain while walking around crouched.
- Fixed credit UI bug.
- Fixed callvotes and votes for spectators.
- Removed medic icon on radio calls for Jump mode and Last Man Standing.
- Added waiting time display before you can call another vote.
- Added the autocomplete client command (TAB).
- Added "callvote map" and "nextmap" check for the specified map to be loaded on the server.


Beta 4.2.006 [09.11.2012]
- New gametype, Jump Mode g_gametype 9.
- Fixed the autoradio bug in Bomb Mode.
- Fixed the "Last Man Standing" gametype description in the in-game menu.
- LMS round winner is now logged.
- Fixed incorrect time display for players connecting to a game during pause in match mode.
- Fixed floating player name while using cg_crosshairnamestype 0.
- Fixed flag captures being added to the score during warmup time of CTF matchmode, also for the second half of a match.
- Updated model and skin for SPAS.
- Updated model and skin for DE.
- Updated skin for Red Dragons' playermodel's hand.
- Updated camo for blue team.
- Updated icons for medic calling, bomb planting and bomb defusing.


Beta 4.2.005 [03.11.2012]
- Updated skins.
- Fixed the ledge climb animation.
- Fixed CTF scores bleeding through warmup into game.
- Fixed the server crash issue.


Beta 4.2.004 [28.10.2012]
- fixed the "all servers full" server browser issue.
- fixed the mute command, it can handle temp muting now.
- tweaked the stamina drain.
- the bleed rate is proportional again to how many times you get shot.
- updated player model skins.


Beta 4.2.003 [12.10.2012]
- fixes crouch popping 
- fixes turtling (crouch that allows the player head to be on their thigh)
- fixes kick vote bugs
- fixes coloured names
- adds FFA/LMS overlay 

	
Beta 4.2.002 [03.10.2012]
- Fixed the server crash issue.
- Fixed the login page in the game menu.
- Fixed the authentication system, including the auth issue on linux x86_64 systems.
- Fixed the server log line truncate when the lines have more than 1024 chars.
- Fixed arm bands rgb, custom colored armbands should work again.
- Fixed the bleedout bug.
- Fixed hits, shooting in the knees is no longer registered as a vest hit.
- Fixed cg_drawKillLog 0 now only shows hits.
- Fixed the helmet no longer becomes "white" on the map Sanctuary.
- Fixed the medic bug, it goes as fast as intended now.
- Fixed the "killsss" typo that was showing in the FFA scoreboard.
- Fixed 100% cpu usage dedicated servers.
- Fixed the "Quake3-UrT_Logitech_Game_Recognition.reg" file for players with Logitech mouses.
- Fixed the size of the G36.
- Fixed the Nuke, server admins can nuke players again; /rcon nuke <playername/id>.
- Fixed the kick vote.
- Updated the maps Kingdom, Raiders and Casa. You should not get stuck anymore, also no more hiding inside rocks.
- Updated the SPAS12 so it has 20 pellets instead of 11 and adjusted the damage accordingly.
- Added back a laser to the AK103, like how it was in 4.1.
- Added a mapcycle.txt file for servers.
- Default /rate raised to 16000 instead of 3000.
- Potentially fixed the FPS issue.
- Auth-ban and the bans on our website are now fully functional.
- Updated the /rcon auth whois command to show more information.


Beta 4.2.001 [03.08.2012] (date has changed to day/month/year)
- new hit detection
- new character 3rd person animations
- new game mode: Last Man Standing (LMS) g_gametype 1
- new Authentication system
- new demo format ( .urtdemo )
- new Auto-Updater for the game
- updated the maps Casa, Mandolin, Kingpin and Kingdom
- new maps: Raiders, Cascade, Bohemia
- Follow The Leader bug, a subbed player can be chosen as a leader
- Server Listing - Misrepresented Gametypes Error
- Allowed Voting - Load up Time Dependency
- Mini map - Subbed players seeing Active Players
- Dropping nades/Going to Spectator
- Ready Command Role Swap Command Discontinuity.
- potentially fixed 999'ers hold up the game in TS
- colour tags don't shorten maximum server host name in server browser.
- fixed breathing sound when the game is paused
- stamina regeneration frozen when the game is paused
- fixed hotpotato time after a pause
- sr8 drop exploit fixed
- voting rcon exploit fixed
- weapon reloading/switching bug fixed
- going on a ladder with an armed nade will now put the pin back in
- enable booting when bomb held
- no throwing last knife
- fixed g_teamautojoin when going to spectator
- callvote kick/clientkick now enforces a reason as an additional argument
- reload button to cycle backwards in spectator mode
- fix for the masters
- locked r_intensity, cg_physics and r_smp
- demo automatically starts recording when joining a game that has already started (with g_matchmode 1 and cg_autoRecordMatch 1)
- you can "steal" the captain status when his connection is interrupted
- when a team mate requests a medic his name flashes on the mini scoreboard
- demo stops recording at the end of a map (with g_matchmode 1 and cg_autoRecordMatch 1)
- added cg_drawKillLog 0/1/2 (0 = no kill log ; 1 = old log like in 4.1 ; 2 = new log: player 1 [Weapon] player 2)
- added g_ctfUnsubWait, if set to 1 someone who unsub in wave CTF mode will wait the next wave to spawn
- added /rcon smite <player> command, instantly kill a player 
- added /forcesub command (for captains in match mode), force a player of our team to become a substitute
- added g_allowChat 3 - allow only the captains to talk during a match (only when both teams are ready)
- added cg_demoFov, it allows to change the fov from 70 to 140 when watching a demo
- updated the UI
- updated the cfg files
- fixed team mate healbar with short names (eg. a dot)
- callvotes are now logged in the server logs
- selective weapon/item pickup (+button7) (see README-cg_autoPickup)
- increased the maximum number of demos
- fixed weapon selection bug where the last weapon chosen was disappearing when selecting a team
- fixed map arrows size on big maps
- fixed the hands when holding a G36
- now draw the name of the guy who planted the bomb
- the SPAS has now 8 bullets instead of 6
- Download percentage overflow fixed.
- Fixed throwing nade/switching weapon bug.
- Locked cl_guidServerUniq.
- Disabled radio binds for muted players.
- Radio binds are now logged server-side.
- Added server filters for passworded servers and servers with the Authentication activated.
- Hot potato are now logged server-side.
- Callvotes and votes are now logged server-side.


Beta 4.1
============
[22.12.2007]
-Working IP ban system
-Duplicate name protection (the trade of is that you can't use spaces in your name anymore though)
-Removal of white skins
-New/updated maps
-Updated UI and default settings
-/rcon players command, returning map/score and per player: name, team, score, ping, IP
-No votes within first 60 seconds of a map
-Fixed hit bug when crouching and moving
-Several spawn locations fixed
-Negev reload exploit fixed
-Power slide physics exploit fixed
-TDM scoreboard not updating fixed
-in-game browser now remembers your sorting preferences
-Short names won't mess up the healtbar anymore
-A problem with blood (fps bug?) fixed
-sr8 gets 5 bullets again, but unzooms when getting hit with 15% damage
-spas does less damage. Knockback when getting hit by it is lower.
-ump does more damage
-psg back to 8 bullets and chest hits bleed out
-some changes to the log files
-allowdownload cvars locked
-demonames changed to YYYY_MM_DD instead of YYYY_DD_MM
-removed 'parsing xxx.menu' spam from console


Beta 4.0
===========
[04.01.2007]
4.0 Notable Changes
====================
* No longer depends on any Quake 3 Arena assets.
* New player models/skins
* New player animations
* New hitdetection
* Ingame Stats
* Banning using a banlist.txt (IP-based)
* Powerslide introduced
* Goomba Stomping introduced
* Hot Potato Feature introduced
* Vote system overhauled
* Menus overhauled
* New weapon skins (Spas/G36)
* Sprinting is faster now
* Hitsound
* Being able to set the next map introduced
* Muting of players introduced
* Veto'ing of votes introduced
* Player armbands introduced
* Funstuff introduced
* Maps updated and added - from minor tweaks to complete overhauls (see map list for new maps)
* Tac-Goggles overhauled
* Damage Values updated
* UMP now has 30 bullets instead of 25 and a spammode instead of burst. 3 bullets, very quickly in a row each time you shoot.
* Spas fires quicker, but has less bullets
* Negev is like a mp5k with 90 bullets now, no more stamina reduction.
* Bullets now penetrate arms/legs to hit head/torso if they're in the way.
* New Frozen Sand introduction graphics
* protection versus the name 'all'.
* Players can't look around while game is paused anymore
* Added ability to become captain when old captain is 999.
* TK auto-kick message updated
* Loading screen progress indicator
* NVG look changed


4.0 Cvars/Commands
==================
General
* com_hunkmegs now defaults at 256
* gamename = q3ut4
* g_modversion = 4.0

Client side
* Overbrightbits/MapOverBrightBits/fastsky/lightmap/muzzleflash locked
* FPS capped at 125 
* Position of text when using cg_drawcrosshairnamestype 1 changed to not colide with team overlay
* 'raceblue' and 'racered' instead of 'race'
* 'cg_hitsound' turns on/off hitsound
* 'funred' and 'funblue' to set funstuff.
* 'cg_rgb' sets your armband/minimap/scoreboard color, if server allows it

Server side
* Server now echos when changing certain cvars, which it didn't do before (bombexplodetime for example)
* Removed/shortened cvars from infostring to decrease chance of 'info string length exceeded' warnings
* 'mute' to mute a clientnumber
* 'veto' to let a vote fail
* addip/removeip to ban/unban IP addresses. Can also use clientnumber to ban someone.
* g_hotpotato sets number of minutes of stand-off before hotpotato kicks in (0=off)
* g_allowvote values changed. Check http://www.urbanterror.net/allowvote_calc.html
* g_nextmap lets you set the next map
* g_armbands added. 0=let player decide armband color 1=force red/blue 2=assign random color to players
* g_redwaverespawndelay changed to g_redwave and g_bluewaverespawndelay to g_bluewave
* g_survivorroundtime = g_roundtime now
* g_captureandholdtime changed to g_cahtime
* g_surivorrounddelay = gone


4.0 Map List
=================
ut4_abbey
ut4_abbeyctf
ut4_algiers
ut4_ambush - Masheen
ut4_austria
ut4_casa
ut4_crossing - Masheen
ut4_dressingroom
ut4_elgin
ut4_firingrange - Hybridesque
ut4_mandolin - Null
ut4_prague
ut4_riyadh
ut4_ramelle
ut4_sanctuary - Sinny
ut4_snoppis
ut4_thingley
ut4_tombs
ut4_toxic - Duf Knien
ut4_turnpike
ut4_uptown


==============================
3.x Dev Cycle Release History
==============================

Beta 3.7
============
[07.11.2004]

Beta 3.6
============
[05.16.2004]

Beta 3.5
============
[05.15.2004]

Beta 3.4
============
[03.16.2004]

Beta 3.3
============
[02.13.2004]

Beta 3.2
============
[01.16.2004]

Beta 3.1
============
[10.07.2004]

Beta 3.0
============
[08.09.2003]


3.7 Features
============
* Boot is now available with Beretta and DE and grenades
* Sr8 damage to waist and groin equalized at 80%
* Knife damage increased
* ut_timenudge - lets you swap ping for a smoother world view. Useful for people who are having hitting issues/jerky other
player issues. If not,leave it on 0. Range (0-50ms) 
* walljumping - easier to do now esp. for hpbs. The 3 jump limiter was slightly broken, meaning it wasn't working as nicely
in 3.6 as it was during 3.5 qa testing. Fixed now.
* walljumping - cannot walljump off other players
* walljumping - cannot walljump off of low ledges
* cg_autoscreenshot - check if thats behaving right please.
* player rendering - player angle changes were not smooth before, now they are.
* new options for cg_drawteamoverlay 0 1 2 3 
    - 0 is none
	- 1 is both teams displayed
	- 2 is just your team, smaller, and the alive count of the other team
	- 3 is only yourself and the alive counts of your team and the other team
	and
* cg_drawteamoverlayscores 0 1  which turns off the scores from the above options
* g_deadchat 0/1/2 only works in matchmode
     0 dead can talk to only dead or sub
     1 is the default, dead can pester their own team
     2 means the dead can pester everyone
     - specs are always locked out however
* /restart unreadies teams correctly
* you have to ready up again after 1/2 time
* removed the bobby rotation of portal cameras


3.5 Features
============
* New cg_scopering (enabled by default) shows a ring on the sr8 crosshair scope reflecting MP
* ut_itemdrop now accepts "kevlar","silencer","helmet","flag","nvg"
*** forgotten feature *** if you put maptoggle on 0 you can bind a key to button12 (like bind j +button12) that'll only
display the minimap so long as its held down
* new nvg effects cg_nvg 0-8 changes colour
* new walljump physics
* legshots dont slow you so much 
* running with low stamina doesnt slow you so much
* Have to have the knife selected to boot (can boot team mate if FF is on)
* Crouch is sticky in air - i.e. if you crouch while jumping you stay crouched until you land


3.4 Features
============
* g_swaproles 0/1 - defaults to On - at Intermission, teams are swapped, map starts up again with a warmup
* g_maxrounds N - 0 for off, have to have it off to use the timelimit
* cg_autoscreenshot to accept a value of 2 now to only take shots during matchmode
* New bomb mode rules removed.
* g_survivorroundtime now accepts real numbers like 1.5 for 1:30 worth of time.
* Changed the g_teamnameRed and g_teamnameblue to not be latched anymore
* Changed intermission not to look around anymore
* Made TDM use TS spawns if no TDM spawns around
* modified the UI to show 1/2 time scores on the scoreboard
* if it somehow makes it to 1/2 time without either team readying a ready up in the second half resets the match
* personal scores are kept between first and second half unless a restart is called in which case the personal scores are
cleared but the match starts at the second 1/2
* Improved pause text 
- "Pausing" appears at the top of the screen
- by who (red/admin/blue)
- whether it's a timeout or pause
* Pause and resume have countdowns eg: "Resuming in 9 seconds" etc which are in the middle of the screen


3.3 Features
============
New Bomb Mode rules
    - 2 points for red on successful plant
    - 2 points for blue for stopping red from planting by killing all of red before they plant
    - 1 point for red for killing all blue but not planting
    - 1 point for blue for defusing the bomb
    - 0 points for a draw

* g_bombRules 0/1 - Cvar control for old and new bomb rules 
    - 0 = old rules
    - 1 = new rules and is on by default

Kicking enabled in FFA

Graphic display in lagometer when antiwarp is affecting you. (antiwarp indicated by black lines in lagometer)


3.2 Features
============
g_antiwarp 0/1
	- It's turned off by default as it's still fairly experimental, and a little controversial. It stops warpers. But
	to the person actually warping it feels like packetloss.

g_antiwarpTol 50
	- It's the MS tolerance before g_antiwarp decides that you're a warper. Most players have well under 20ms, but
	severe warpers (ie.uploading/downloading) are over 50 most of the time. Recommended you just leave it on 50, but
        set it can be tunedslightly lower (40, or maybe 30) if there are certain persistant people who still try and get
        past this.

g_gear 0
	- g_gear is a server-side option that allows you to disable certain weapons from spawning with players. It's a bit
	field (like g_allowvote), so you pick what combinations you want by summing the relevant bit values. 
		They are:
		1  No Grenades
		2  No Snipers (psg1 or sr8)
		4  No Spas
		8  No Pistols
		16 No Autos (primary or secondary)
		32 No Negev
	
		-So, if you wanted to run a pistol only server, you'd remove everything else. 
		1+2+4+16+32 = 55
		g_gear 55 = Pistols Only.
		- Clients are notified when g_gear is changed as to what is allowed, (as well as when joining a server).
		- Known Issue: The actual loadout screens wont prevent you from selecting disallowed weapons, you'll just
		  never spawn with them.

Voting on g_gear
	- g_gear can be disallowed/allowed for voting by the bit value "32" in g_allowvote.

Throwing Knives
	- The ability to throw knives is back.

CAH Flags Reset
	- The flags set back to neutral when the round time is up and a sound is played to alert you.

Laser available on more weapons
	- Laser is now available on the AK103 and the Imi Negev

Laser does 10% recoil reduction as well as 40% spread reduction


3.1 Features
============
* cg_hitmessages 2   =   new damage reporting system that gives you the actually amount of damage in a percentage format 
* colours allowed in team chats now
* chats show as yellow in the console.
* cg_showbullethits 2 
* Shows the % damage dished out on each shot
* Shows the % health left to bastard who killed you
* Fix to the ent->think bug that was causing the bomb to disappear on the new Abbey2


3.0 Features
============
Bomb mode.
New and updated player skins.
New weapon, IMI Negev.
New G36 model.
Match mode.
New menus.
New radio messages.


3.7 Bug Fixes
=============
* Water crouch bug fixed
* Adjustment to the antilag code
* team overlay refreshes properly except flag returns (the point doesn't show until you hit tab)
* cg_autoscreenshot fixed so that 1 takes screenshots in pub and matchmode and 2 only in matchmode
* server degradation dealt with but it is still recommended that you restart dailly (q3 needs restarting within 24 days but
  we found degradation started after only 15 hours)
* Fixed some clips on Casa

 
3.6 Bug Fixes
=============
* Fixed ammo exploit
* Fixed TS spawns on Casa
* Replaced missing texture in Casa


3.5 Bug Fixes
=============
* quick weapon swap bug fixed
* reload anim bug fixed
* q3 crash with no soundcard fixed
* disappearing flag bug fixed 
* teams now unreadyd on /restart
* Fixed crouch animation when jumping which corrects ARIES alignment for better hit detection
* Fixed ent->think error that was causing the bombsite to disappear
* Fixed g_swaproles 
* Fixed swapteams 
* cg_autoscreenshot 1 is fixed so it takes screenshots in matchmode
* modifed: month_day has been swapped for day_month in autoscreenshot text
* Fixed double bomb
* Modified the bomb blast
* Can't jump plant anymore
* Fix for low ammount of spawns (multiple repeating spawn death) bug
* Changed our antilag code to use doubles, not floats


3.3 Bug Fixes
=============
* Ingame browser fixed
* Antiwarp adjusted so you can ledgeclimb properly


3.2 Bug Fixes
=============
* Timer fixed
* Sub no longer drops bomb/flag when disconnecting or unsubbing
* Sub no longer creates ghosts
* Spectator no longer takes bomb/flag when disconnecting


3.1 Bug Fixes
=============
* Fixed in-game browser to recognize Bomb Mode
* Fixed button binding bug in Menus
* Increased Info string length
* Removed tracers from SPAS
* Prevented bomb plant in water
* Fixed bomb animation bug
* Fixed autoscreenshot going off during demo playback
* fixed matchmode demos goofing up
* AntiWallhack code removed to improve FPS
* bigger bounding box for flag so you shouldn't be able to jump over it now
* Most of the GTV issues fixed.
* bombplant and zoom/injured fixed 


Beta 3.2 Maps
=============
ut_precinct
ut_oz
ut_pg2-27


Beta 3.0 Maps List
==================
ut_27 - 3.0 example map (for mappers).
ut_abbey2
ut_algiers
ut_commune2
ut_casa
ut_crenshaw

ut_docks
ut_druglord3
ut_filtration
ut_golgotha2
ut_mines
ut_nimrod
ut_offshore
ut_revolution
ut_ricochet
ut_riyadh
ut_rommel
ut_sanc
ut_sands
ut_siberia
ut_streets2
ut_swim
ut_turnpike
ut_twinlakesv2
ut_uptown
ut_village2


Beta 3.0 Overview by Dracostian
===============================
Please see the included overview.txt file.


New cvars and commands overview
===============================
Server:
g_bombExplodeTime 
    Number of seconds until bomb explodes after being planted.

g_bombDefuseTime
    Number of seconds it takes to defuse the bomb.

g_waveRespawns
    Set to 1 to enable wave respawns.

g_redWaveRespawnDelay, g_blueWaveRespawnDelay
    Configures respawn delay for each team when wave respawns are enabled.

g_followStrict
    This replaces g_followForced and g_followEnemy, set to 1 to enable strict spectating rules, mostly applies to matches
    spectators are not effected, only team players.

g_matchMode
    Set to 1 to enable match mode.

g_pauseLength
    Admin pause length in seconds; set to -1 for infinite.

\pause
    Admin command to pause game; call again to un-pause.

\forceready
    Admin command to force team to ready status.

\forceteamname
    Admin command to force team name, syntax: \forceteamname <red/blue> <name>

g_timeouts
    Number of allowed timeouts per map.

g_timeoutLength
    Timeout length in seconds, minimum 3 seconds, maximum 300 seconds.

\swapteams
    Admin command to swap teams.

\shuffleteams
    Admin command to randomize teams.

\map_restart
    Admin command to do a 'soft' restart, will reset scores and times without reloading map.

\reload
    Admin command to do a 'hard' restart, will reload map completely; use for things like sticking latch cvars
    (g_gametype, g_matchMode, etc..) values.


Client:
\captain
    In match mode type this to become team captain.

\ready
    Captains use this command to ready the teams.

\teamname
    Captains can use this command to set team names; syntax: \teamname <name>

\timeout
    Captains can call timeout during a match using this command.

\sub
    In match mode type this to become a team spectator.

cg_physics
    Set to 1 to enable frame rate independent physcis; jump same distances regardless of your fps.

cg_optimize
    Set to 1 to enable optimized client code, will increase fps on low end CPUs.

ut_weaptoggle bomb
    New toggle command for use in Bomb mode.

cg_drawCrosshair
    Five new crosshairs: 9, 10, 11, 12 and 13

cg_hudWeaponInfo
    Configures the visual display of your weapon information; weapon name, number of rounds/clips, weapon mode.
    Valid range: 0 to 2.

cg_scopeG36, cg_scopePSG, cg_scopeSR8
    Configures the scope type for the scope-able weapons, valid range 0 to 3.

cg_crosshairNamesType
    Switches between different crosshair name types, valid range 0 to 3.

cg_crosshairNamesSize
    Changes crosshair names size.

\recorddemo
    Starts a demo recording, demo name includes map name, gametype and team names when in match mode.

cg_autoRecordMatch
    Set to 1 to enable auto demo recording on match start.

\race
    Selects model type, valid range 0 - 3.

cg_drawFps
    Set to 1 to enable 'true' fps, 2 for old fps calculation.

\ut_radio
    Now accepts custom strings; syntax: \ut_radio <x> <y> <optional string>

cg_autoRadio
    Now accepts another configuration settings, set 0 to turn off all auto-radio calls, set 1 to turn off Grenade! calls
    but keep all the other calls and set 2 to enable everything.

And the real reason why people play Urban Terror 3.0:
    \breakout_play
    \breakout_reset
    \breakout_pause
    \breakout_left
    \breakout_right

Vote system:

g_allowVote no longer takes 0, 1 or 2 as its value. You can now configure it to except different vote groups, those groups

are:

1:
reload
restart
map
nextmap
kick
swapteams
shuffleteams
g_friendlyFire
g_followStrict

2:
g_gametype
g_waveRespawns

4:
timelimit
fraglimit
capturelimit

8:
g_respawnDelay
g_redWaveRespawnDelay
g_blueWaveRespawnDelay
g_bombExplodeTime
g_bombDefuseTime
g_survivorRoundTime
g_captureScoreTime
g_warmup

16:
g_matchMode
g_timeouts
g_timeoutLength
exec

beta 3.2 adds
 
32:
g_gear


Note that the group numbers are a power of two. To configure your server for allowing the first group to be vote-able,
set g_allowVote to 1. If you wish to allow several groups to be vote-able, add their numbers and set g_allowVote with
result, for example groups 1 and 4, set g_allowVote to 5 (1 + 4). If you wish to enable full voting on your server, set
g_allowVote to 63 (1 + 2 + 4 + 8 + 16 + 32).


Beta 2.6a
============
[01.17.03] 

Changes From 2.6 to 2.6a (weapon patches)
 
Bug Fixes:
*  Voting Fixed
*  Black screens fixed
*  Disapearing Flag on flag holder lag out disconnection fixed
*  Null ent->think crashes fixed (other "rare" crashes still present!)
 
Changes:
*  Clearscores command removed 
*  Black fading screen removed (noone liked it anyway)
*  Direct Team changing in TS/FTL doesn't clear your score, Changing from team to spectator
   to team does thought.
*  Min rate now 2500, Max rate 25000
*  cl_maxpackets min now 20, max 42
*  snaps min 20 max 40
 
* plus lots of other things that we've forgotten about :)
 
Weapon Changes
 
* AK103: Damage lowered, Spread and movement pentily lowered
* Beretta: Spread increased, knockback increased
* Desert Eagle: Nothing!
* G36: Damage increased, Rate of fire slowed, Movement Pentily lowered, Kickback from
firing lowered
* LR300: Damage increased Movement Pentily lowered
* MP5k: Damage lowered, range lowered.
* PSG-1: Damage increased, VITAL HITS REMOVED (apart from head), kickback and reload
time increased, Movement Pentily Lowered.
* SPAS-12: Damaged almost Halfed!, Rate of fire slowed (more to come in 2.6b!)
* UMP: Nothing!
* Sr-8: Damage Decreased!, After firing Screen doesn't automatically zoom in anymore!!
 
Please be Aware that there are still bug issuses within the code, we are currently
working towards that and major/importantproblems will be addressed in 2.6b!
 

Twentysevens Note: Before you read this and have a heart attack at all the"lowered"'s, 
this is actually the fastest paced,and most balanced, release of UrT during the 2.x
series. The balance was decided upon by leading members of the clan community, and we
respectfully thank them for all their hard work.
 
Twentysevens Note Part II:   TIMMAH RAWKS. 
(ref, Tim is DensitY)


Beta 2.6
============
[11.09.02] [Nov 09 2002]

Quick Note
==========

	Thanks to Apoxol, who did an amazing amount of work on betas 
	2.0-2.3 and continues to provide sage advice from his cushy 
	new job with Ravensoft.

	Beta 2.6 welcomes a new coder to the team: Density, who has provided
	TwentySeven a considerable amount of assistance through this development
	cycle. 


Features:
	Newly update team player skins
	Replaced M4 with the ZM LR300ML
	Kalashnikov AK-103 added
	New UMP45 model
	Implemented mini-map now displays players, flags and radio calls
	included cg_mapsize
	included cg_mapalpha
	included cg_maparrowscale
	included map arrowalpha
	included cg_mappos
	ut_metro added
	ut_mines added
	ut_twinlakes added
	ut_turnpike added
	ut_reykjavik added
	new shake effect when grenades explode
	hold insta-arm HEs too long for a good time
	added slap and bigtext commands for server admins
	added cg_SpectatorShoutcaster
	added "headshot" with select weapons
	/com_blood now toggles gore effects
	

Modifications:
	Team Survivor code completely rewritten
	/matchready added for teams to "warm up"
	/g_casualtieswins rule add
	improved helmet
	all weapons tweaked
	increased Movement pen for PSG
	new UMP45 skin
	new G36 skin
	new Beretta skin
	new knife skin
	new SPAS skin
	updated SR-8 model
	ut_riyadh updated
	ut_docks updated
	ut_uptown updated
	user interface changes
	callvote now includes matchready, matchstart
	callvote to turn friendlyfire on/off

	ability to kick bots from botmenu
	added the AK to the primary weapon menu
	flash grenade less intense when looking away
	grenades no longer disappear when thrown through doors
	rotating door code improved, players don't stick
	ARIES hit detection values changed
	precipitation on terrain added (snow and rain)
	updated sounds
	rewritten netcode
	added $crosshair function
	increased boot detection
	sv_fps limited to 20
	max_packets limited to 42
	callvote now includes 'matchready'
	added SID logo (ROQ) to replace id logo
	
Bug Fixes:	
	reduced the movement penalty
	Improved knife hit detection
	Fixed flickering bodies in FTL mode
	Fixed bug with Spas where it fired pellets behind a player
	bug with changing teams while dead in CTF/TDM/CAH modes resulting in black screen.
	warmuptime/g_survivourrounddelay code
	Nades through floors
	bug with blood Particles
	corpses fading too long
	Fixed FTL leader code
	g_followForced 1 only applies to Ghosts now (not spectators)
	fixed incorrect zoomed crosshair in ghost/spectator mode
	exploding monkey no longer throws shit
	made blue minimap icon darker
	fixed minimap
	callvotes win system fixed
	fixed losing of Hud and weapon in spectator mode when following someone
	Now displaying more correct pings in ghost mode/follow mode
	fixed non clearing of clientside entities between TS/FTL
	fixed CTF game.log logging

Known Issues:
	no logging for CAH game mode
	spawns still need a little more work
	$gametime not working in TS/FTL
	blood particles give a a small fps hit
	
Misc Notes
==========
	Even with eight months of recoding, tweaking, modifying and testing, there
	will be times gamers encounter bugs and problems, with Urban Terror,
	Quake 3 or PunkBuster related. We are not perfect, but we are dedicated
	to our software and have made every attempt to fix the problems as they
	presented themselves during the development cycle.

	If you happen to have unfortunate luck and run into problems, take the
	time to check the manual, FAQ and forums, before dropping the F-bomb on
	the development team. We are here to support and assist the community
	through their problems and have been since Beta 1. We are usually around
	the forums and IRC on a regular basis if you have problems. The community
	is very good when it comes to assisting gamers in the problems they 
	encounter.

	Last but not least, remember to have fun and enjoy playing Urban Terror.
	The development team enjoys working on Urban Terror and supporting the
	community. We are all friendly and enjoy the support gamers continue
	to give us. So, enjoy Beta 2.6 and thank you for your continued support.

	-Oswald
	

Beta 2.5
============
[02.23.02] [Feb 23 2002]

Notes on 2.5
============

2.5 is primarily a bug fixing release for 2.4.  

The weapons have been slightly tweaked to make some of the more devastating weapons a bit 
more balanced.  The MP5K became a lot more powerful than we intended with the hit bug gone
because with its rate of fire it was getting a LOT of headshots.  We understand people's
feelings about the weapons, but we felt that getting 2.5 out so the server issues could 
be dealt with was very important.

I am also aware that LPBs can feel like they get hit "behind a wall" by a HPB.  In 2.3 and 
before the netcode did a check to see if a HPB's shot would be disallowed because the 
LPB had gone behind a wall before the HPB fired off their shot.

In upgrading the netcode, I didn't re-implement this feature.  Some people may notice it and
feel ripped off.  You are not, in fact, being ripped off by it.  If you seem to get hit
behind a wall it's because you were not behind a wall when the HPB saw you.  I beleive this
is balanced by the fact that a LPB can spot a HPB before the HPB sees them, and often
the reaction time leads to the HPB getting killed before he fires off a shot.  Normally
the LPB will win in any "surprise" situations.

I'll add in the wall check for 2.6 if people feel the wall issue is a huge problem. For now
I want people to know that it's not giving anyone an unfair advantage, it just feels odd.

Server admins please leave master2 in your server.cfg open and DO NOT assign it a master
server, as by default will send a heartbeat to the Urban Terror Master Server. If you have
master2 assign, just move that master server to something other than server2.

Fixes:
 * client info was being corrupted by new team skins code; fixed
 * large amounts of data going to the server added in 2.4 removed (less server lag)
 * problem with bots fixed (the 999 bug)
 * follow enemy now works correctly with the /follow command
 * cg_deferPlayers now works correctly
 * unlocked r_gamma
 * added 4 new lock cvars
 * added small delay on zoomin that prevents snipers from gaining full 
   accuracy immediately; this is to stop script exploits that let people 
   fire accurately while unzoomed

Features:
 * added environmental lighting to decals and particle effects
 * helmet now more effective

Changes to weapons:
 * there have been NO changes to damage of any weapons in this release
 * MP5 spread and movement penalty increased
 * UMP45 spread and movement penalty increased
 * G36 movement penalty reduced (more accurate when running)

 
Known Issues
============

There were a few things we didn't get a chance to fix, but are aware of:

 * weapons are not totally balanced (see above)
 * LPBs can apparently get hit behind walls (see above)
 * cg_bobup and cg_bbpitch cvars locked to their default values
   and cannot be set to 0.  People who are used to setting these
   to 0 (like Vynnski :) will notice the bob is back until 2.6
 * weapons sometimes seem to revert to burst mode for some people
 * hand skin can sometimes be wrong until respawn if you change skins

Beta 2.4
==============
[02.08.02] [Feb 08 2002]

Quick Note
==========

	Thanks to Apoxol, who did an amazing amount of work on betas 
	2.0-2.3 and continues to provide sage advice from his cushy 
	new job with Ravensoft.

	Beta 2.4 welcomes three new coding talents: TwentySeven, Iain and Thaddeus

	Thanks also to Neil from the Q3 Antilagged mod for some extra advice
	on fixing a few small bugs in the UrT netcode, and to RR2D02 from
	Q3F who was kind enough to give me his cvar locking code. 	

	 - dokta

Bug Fixes:	
	Fixed a bug that let spectators trigger some entities
	Some particles were spawning at the wrong position: fixed
	CTF was reporting incorrect team flag being returned
	Chopper in sands now a smooth ride 
	Crouching over a grenade kills you	
	Fixed bugs that nerfed the kick
	Improved knife hit detection
	ARIES fixes: better accuracy, esp. on ladders
	Fixed netcode for LPBs
	Fixed team bandage bug that let you bandage faster if you changed weapons
	Fixed reload bug that let you reload faster
	Fixed bug that was causing CTF flags to disappear in no drop zones (ut_paradise water)
	Can shoot timed out players (999 bug)
	Dropped grenades no longer removed if you can't pick them up
	Fixed 1.31 point release intermittent freezing bug
	Made team survivor spawning more random
	Fixed a small bug that was preventing item changes after respawn on some maps
	Prevented player corpses from kicking living ones :)

Modifications:
	Increased duration of flash gren effect
	Decreased SPAS damage
	Increased M4 spread
	Crouching reduces grenade damage less
	New NVG Effect
	Improved weapon sounds
	Improved impact marks

Features:
	Smoke grenades
	Volumetric laser scope in fog and smoke
	New laser dot FX
	Instant arm mode for grenades
	Snipers now inaccurate when not zoomed
	Locked a number of potential cheat cvars
	Can save teammates by smothering grenades (crouch on them as they go off)
	Improved blood effects
	Quake 2-style CTF scoring
	Medic icon if you call for a medic
	UI for selecting team skins
	

Note on netcode
===============

The netcode in 2.4 is essentially the same netcode that Apoxol developed in an earlier 
release of Urban Terror.  While we did use the public domain code released by the Q3
anti-lagged mod, that code is very similar to the original UT code, as Apoxol and Neil
spent some time working through various issues with each other.  The result is a synthesis
of Urban Terror specific netcode (to account for ARIES) and anti-lagged mod netcode.

The main advantage in the 2.4 netcode is better calculation of latency for players with low
pings.  In other words, LPBs should see the greatest difference in accuracy in 2.4.

The netcode does *not* do hit detection on the client-side and does not affect prediction
of player positions.  What it does is calculate hit detection on the server using player
data that simulates what the client would have seen on their screen at the time they shot.

The netcode also does *not* predict impact effects.  If you fire at a wall and you have a high
ping there will still be a delay between firing and impact.  Beta 3.0 may have client side
impact effects added in as an option for those HPBs who like to pretend they have cable ;)


Beta 2.3
==============
[08.10.01]

Bugs fixed:
	- Unnecessary setting of a few cvars on ever frame
	- Fixed "bad player movement angle"

New stuff:
	- ut_alleys by BotKiller
	- ut_austria by Tub
	- ut_casa by SweetnutZ
	- ut_riyadh by dotEXE
	- ut_rommel by Bar-B-Q
	- ut_pressurezone by Gerbil!
	- ut_uptown by BattleCow
	- ut_village by Tub [updated by Legomanser and NRGizeR]
	- ut_swim [updated version]
	- ut_sands [updated version]
	- ut_abbey [updated version]


Beta 2.2
==============
[07.13.01]

Bugs fixed:
	- Invisible player bug
	- Spawning without knife bug
	- Team DM spawns further apart now
	- cg_sfxVisibleItems no longer hides your own laser or silencer or medkits
	- Fixed bug that would cause pressing reload to not work sometimes
	- Shooting cancels out your respawn protection so make your first shot count
	- cg_autoRadio now functions as originally designed
	- Extra ammo now gives 3 more shells to the hk69
	- Safety measure added to ensure kills, deaths, and times are cleared after a survivor map change
	- sv_fps now properly capped to prevent crashes at startup


Beta 2.1
==============
[07.10.01]

New stuff:
	- ut_echo command added to replace the standard echo command.
	- Added joystick option to the menus
	- Added the "dot" crosshair
	- Added grenade support to ut_weaptoggle
	- New cvar cg_autoRadio [0/1]: Disables/Enables the playing of radio messages such as "fire in the hole"
	- New cvar cg_scopeRGB [<red>,<green>,<blue>,<alpha>]: Controls the color of the inner crosshairs of the sniper
          scope, defaulted to black
	- New cvar cg_scopeFriendRGB [<red>,<green>,<blue>,<alpha>]: Controls the color of the inner-crosshairs of the sniper
          scope when over a friendly target
	- New cvar cg_zoomWrap [0/1]: Disbles/Enables wrapping when zooming. When on the zoom commands will wrap around from
          max to min and min to max
	- New cvar cg_sfxVisibleItems [0/1]: Disables/Enables visible items/weapons on players. Setting this to zero will
          increase FPS but remove visible kevlar, guns on players backs, etc.
	- New cvar g_failedVoteTime [<seconds>]: number of minutes that must pass before someone can vote after calling a failed
          vote
	- New cvar g_teamkillsForgetTime [<seconds>]: number of seconds that must pass before team kills are forgiven.
          This allows admins to control how many kills per minute for team killing is allowed.
	- New cvar g_initialWarmup [<seconds>]: number of seconds of warmup time after a new map cycles. This allows people to
          join the server before the game starts. 
	- New cvar g_flagReturnTime [<seconds>]: number of seconds before a flag returns after being dropped
	- Overhauled the ut_weaptoggle command. Now understands primary, secondary, sidearm, grenade and knife and works with a
          single parameter. 
	- Included weapon ID in the log message for hits

HK69 Tweaks:
	- Ammo lowered to 4 shells 
	- Can no longer select grenades when the hk69 is chosen
	- damage to distance ratio changed from linear to a curve
	- Grenade made larger
	- Grenade bounce sound more identifiable

Bugs fixed:
	- ARIES issues resolved
	- Bots should no longer cause quake3.exe to crash
	- Players will no longer be dumped onto the spectator team during intermission
	- Helicopter should now make noise when playing online
	- Players will no longer spawn inside each other causing them to get stuck
	- Time in scoreboard should no longer be incorrect
	- Can no longer switch teams in a survivor game to come back to life
	- Helicopter will now kill you if you stand underneath it when its landing
	- Extra scoring removed from CTF and FTL gametypes. No more scores of 150+
	- Spectating someone using NVG's should now work properly
	- cg_drawtimer 1 should now should the proper time value in survivor games
	- Leadership is no longer transferred during the round the leader dies in FTL, this prevents someone else from
          reaching the goal besides the original leader.
	- Size of greade models increased to help increase grenade visibility
	- Shooting grenades from the helicopter should now work properly
	- When spectating another player their team color should now appear in the hud rather than the players original team
          color
	- $leader now works as originally intended
	- Few death messages cleaned up to be a bit more politically correct 
	- Errors in ANTI-LAG code resolved. This should help increase successful hits when using cg_nobulletpredict 0
	- Player model no longer dissapear if you zoom in third person follow
	- Snow should now fall in swim as originally intended
	- Can now pick up weapons immediately after dropped by a dead guy (used to be a 2 second delay)
	- startorbit command was cheat protected
	- Should no longer get -1 kills for switching teams
	- Fixed the message being broadcast to the server logs
	- Player names with the "<" and ">" characters in them should now work properly
	- Zoom out command now wraps around to fully zoomed if not-zoomed when the command is issued
	- Can no longer shoot through thin walls, doors, or glass by getting close to it and shooting 
	- Can now fly around as a spectator if your the only one in the map and g_followForced is set to 1
	- Spectators in free float mode should now stop moving rather than constantly drifting really slow
	- Crouching under water no longer alters view height
	- Dashes in names now show up in the scoreboard when in 640x480
	- Scoreboard now sorted by # of kills then kill to death ratio
	- Fixed a ledge climb odditiy which would cause a studdering sort of effect when jumping at a ledge but not pressing
          forward
	- Sprinting no longer works when walking
	- In-game system menu now reports the proper state of compressed textures
	- Ghosts can no longer call votes
	- cg_drawStatus removed to ensure scoreboard is never blank
	- Can no longer press the hotkey for menu items in the gear selection that are disabled
	- Laser sight should now be alot closer to the crosshair with cg_nobulletprediction set to 0. The code was actually
          backwards which is why setting it to 1 made it better in 2.0
	- Should no longer receive the "Default_Team_Model/skin" error
	- Height in which falling damage occurs has been raised
	- Log rolling should now pad log #'s less than 1000 with zeros rather than spaces
	- Turning off ejecting shells in the menu now works properly
	- Dropping a shotgun no longer results in a loss of ammo when picked back up
	- cg_crosshairRGB, cg_crosshairFriendRGB, cg_scopeRGB, and cg_scopeFriendRBB now support commas as separators. 
	- Observers can no longer drop weapons
	- A disonnected flag carrier will no longer take the flags with them
	- View no longer pivots to show you who killed you
	- Can no longer vote for the first minute after a map cycle.
	- Movement accuracy modified to help prevent small position adjustments from destroying your accuracy
	- no longer look at you killer when your killed
	- $gametime and $roundtime can no longer be negative 
	- players on the spectator team can no follow either team when g_followenemy is set to 0
	- Can no longer select armor piercing rounds (was not intended to allow you to)
	- thrown knives, kicking, and knife hits should be easier to get now when online
	- Should no longer see a laser sight when you dont actually have one selected
	- After waiting for players to join in a survivor game the map will restart so everyone i

Beta 2.0
==============
[06.01.01]

New Stuff:
	- BRAND NEW CODE (To many new features to list, but here is a few)
	- Radar for certain gametypes.
	- Mini-Scoreboard
	- Bullets passing through glass 
	- Climbing down ladders issue 
	- Added: MP5K, M4, FlashBang, and HE Grenade, Male/Female Models
	- Implemented: New UI art, New Hit Detection system
	- ARIES hit detection system
	- Anti Lag System


Beta 1.27
==============
[12.21.00]

Bugs fixed:
	- Urban terror 1.27 now compatible with Quake 3 Arena 1.27 point release
	- Guns tweaked for more intense gameplay
	- Shotgun issues addressed: faster reload, faster rate of fire, more damage
	- Players no longer get stuck after warmup
	- Fixed blood spurts
	- Fixed missing hit sound underwater
	- No more kicking during warmup
	- Fixed bad obituary logging (games.log)
	- Spectators can no longer use radio
	- Cant change name if not alive
	- No more pause after reload before you can shoot
	- Can now see enemies names if you put your crosshair on them
	- Weapons switch a bit faster
	- Removed q3 announcer (prepare to fight)
	- No longer lose frag when switch teams
	- New grenade explosion effects (match radius better and some smoke)
	- Grenade timer reduced (grens arm sooner)
	- Can no longer zoom while spectating
	- Dead status now shows in non-team survivor mode
	- Can no longer spectate dead people
	- Zoomfov cheat disabled
	- Can now heal your teammates again (see manual)
	- Door opening direction can now be controlled by player movement direction
	- Spectator score bug fixed
	- First round of a new map always has a 20 second warmup time to allow people to join


Beta 1.2
==============
[10.16.00]

Bugs fixed:
	Sounds:
		- Double knife sound on swing is fixed.
		- Head shot noise now plays relative to the player that got hit, not to the player who shot
		- New sounds:
			- Weapons sounds redone
			- NVGs on/off sound added
			- Laser on/off sound added
			- Vest hits sound
			- Klinks for falling shells
			- New pain sounds
			- Lots of other cool sounds

	Models:
		- Models forced to UT models only
		- Only the UT models show up for selection in the user interface
		- Hand models no longer get tossed onto the ground when you die
		- Added new "trooper" model and skins
		- Changed default teamplay models to make them more clearly different

	Teamplay:
		- Spawn in teamplay now uses standard deathmatch spawnpoints and chooses them randomly to mix up teamplay
                  games a bit
		- Only be able to kick enemies except in team damage mode (fixed)
		- Bullets should not hit team members in non-ff mode.
		- Fixed issue with frags of -1 when joining a team when the round has already started
		- Fixed display of which team won to report correctly 
		- When map cycles everyone starts game in spectator mode
		- Teammates name and health now appears in bottom right when you put your cursor on them
		- Teammates health now shows in scoreboard if they are alive
		- Capture limit now works for team survivor mode (capture limit is the number of team wins)
		- Added team wins to scoreboard
		- Moved team win message to the center of the screen
		- Fixed radios to work properly in team games

	Miscellaneous:
		- Amended arenas.txt to allow selection of UT maps
		- All command names changed to "ut_*"
		- Players can run through each other during warmup to reduce clipping problems (players getting stuck in each
                  other)
		- Frags dont reset when you manually change the map (fixed)
		- Players should not lose a frag when they die due to bleeding (fixed)
		- Spectators no longer win the game if they are there at the end of a round
		- You can fall through glass (eg: on ricochet)
		- Glass fragment sizes determined by the size of the pane being broken
		- Glass shaders added to shattered fragments for more realistic-looking fragments
		- Rotating doors now always open away from the player
		- Rotating doors no longer reverse if blocked, but continue movement when blockage is removed
		- Spectators and ghosts can now look straight down
		- Gun now dissapears and reappears correctly on ledgeclimb
		- Ghosts can now cycle though the alive players using the fire button
		- View bobing on crouch reduced
		- Crouch speed reduced
		- Intermission time now 15 seconds
		- New cleaner scoreboard look
		- Removed triangles above teammates heads
		- Removed talk bubbles above talking players heads
		- Dead players can no longer talk to alive players in team games
		- Dead players and spec players now have it indicated in their name
		- Made warmup timer flash red and yellow while counting down
		- Separated chat messages from information messages and color coded the chat messages for teams
		- Added current zoom level and fire mode to the hud, removed print messages
		- Ghosts can no longer open doors
		- Ladder speed increased
		- Ledge climb is much smoother now
		- Fixed bug that would zoom you out if you fell a little
		- Added bot support
		- Fixed time display in score for teamplay games to reflect total time
		- Selected bots highlighted in interface screen

	Weapons and Combat:
		- Made "close" range to within 4m (128 units) of player
		- Reduced and capped bleedrates
		- Weapon modifications
			- Range damage sensitivity now works on a sliding scale
			- UMP does more damage close than at range
			- G36 now does more damage at range than UMP, but less when close
			- Beretta does less damage
			- Shotgun now hurts a lot more, has decreased reload time
			- Beretta made less accurate
			- Accuracy gets worse the longer you fire weapon (bursts are better)
			- Alt fire mode does not actually decrease spread anymore (since bursts do) but you
			  still get a benefit from using it because it helps you by shooting off 1 shot (burst)
			  The new spread/fire time system makes the old way fo doing alt fire obsolete
			- Completely rewrote the recoil system
		- Reduced accuracy of sniper rifle when player is moving
		- Decreased grenade splash radius
		- Implemented new damage system
			- All hits are now reported properly (leg shots now work)
			- Headshots harder to get
			- More accurate detection of location
		- Reduced knockback on weapons
		- Grenades now arm after 2.5 seconds, explode on impact with anythign after that
		- Grenades that hit players full on do damage and knockback but do not explode
		- PSG-1 scope blacked out around the edge
		- G36 when zoomed has crosshairs like PSG1
		- Now shows the text "bandaging" on the screen while bandaging
		- Added smoke that comes out of gun barrels.  This can be turned off by turning of brass ejection
		- Now reports whether you hit someone in kevlar or not
		- Kevlar now becomes less effective the more it is shot
		- Can now reload, bandage, and change fire mode immediately after shooting
		- Weapon reload sounds and cock sounds now consitantly play
		- Weapon change animation is now alot smoother looking
		- Drop weapon (ut_drop) now works and is configurable in the bind menu
		- Bandaging can now be cancelled by pressing the fire button
		- Bandaging time is now dependent on how fast your bleeding
		- Knife no longer uses ammo when just swinging it
		- Can now select a weapon that has no ammo so you can drop it
		- Weapon selection now shows the weapon icon instead of the text
		- Knife speed increased to allow nice and fast hack and slash
		- Only 2 primary weapons can be picked up now
		- Brass now ejects from the correct location on the gun
		- Shotgun now reports hit locations and does damage properly
		- Fixed reload problem that caused it to reload instantly and not show it on the last clip

	Items:
		- Laser sight improves aim only when on
		- Night vision shaders modified to add a static effect overlay and look more realistic
		- If player disconnects with laser on the laser entity is now removed from the world

	Network:
		- Only primary weapon(s) dropped on frag to minimise network traffic (beretta and knife not dropped)
		- Fixed prediction bug that cause a delay when shooting

	Cvars:
		- Intermission time was turned into a cvar
		- Warmup time can be set through a cvar


1.2 Known Issues:
	- Console commands (including binds to opendoor, etc, which run console commands cause
	  Urban Terror to crash on Macs :(  1.3 will fix this, with the Id 1.25 point release
	- Bots sometimes get stuck if two bots are on opposite sides of a door
	- Bots don't know they can smash breakable objects
	- Round time still ticks down when waiting for players
	- sometimes players still get stuck on ledge climb
	- sometimes players still get stuck on round start


Beta 1.1
==============
[8.21.00]

Bugs fixed:
	- Sped up ump45
	- Slowed down spas
	- Slowed down psg1
	- Increased spread on spas
	- Took out delay on zoom console commands since they are all client-side
	- Allow all weapons ro reset zoom (even weapons without zoom so that zoom status can be reset on re-spawn)
	- Damage of 30 or greater from a fall causes leg damage, not 20 (as per beta 1.0)
	- Removed neck damage - adjusted other zones to compensate
	- Made psg1 sniper rifle do much more damage
	- Made the g36 do less damage
	- Made the ump45 do more damage
	- Made the spas do a bit less damage
	- Added reload time for spas shotgun and grenade launcher 
	- Made bandaging take 3.5 seconds instead of 3
	- Added a text message for bandaging and reloading
	- Made the psg1 and g36 de-zoom on reload
	- Made the psg1 and g36 de-zoom on bandage
	- Set the gameversion to q3ut in g_local.h
	- Removed delay between weapon fire and weapon reload (you can now reload right after firing)
	- Removed delay between weapon fire and bandage (you can now bandage right after firing)
	- Fixed fov (changing the var now has no effect)
	- Fixed gamespeed (the g_speed var now has no effect)
	- Removed the machinegun and gauntlet register on map load
	- Removed the machinegun default when editing your player settings (this is the weapon that the player holds on the
          left)
	- Made it so you could hear other weapons firing, even if you didnt have the weapon. (hahah, silly bug, surprised
          noone noticed!)
	- Removed the delay on triggering the firemode (bind a key to firemode for everyone who has yet to check it out)
	- Completely re-did the alternate fire modes. it now uses a click-fire system (every click, means a bullet is shot).
	- Added a text message for firemode change
	- Added a random radio sound when bandaging
	- New scoreboard
	- Single death system
	- Fixed bug in open door (crash)
	- Remove Free For All text after each round
	- Only display "XXX has entered" on the first time, not every round
	- Remove requirement to press button at intermission
	- If you join the game in singledeath mode too late, you come in dead
	- Remove the spawn effect
	- Color coded teamplay scoreboard
	- Remove the voice effects for scoreboard position
	- Remove awards
	- Ghosts and spectators are now noclip
	- Moved team select menus to normal q3 menus
	- Moved weapon select menus to normal q3 menus
	- Moved item select menus to normal q3 menus
	- Damage due to bleeding no longer jerks screen
	- Recoil adjustments (always move up)
	- No longer Shoots to the upper right of crosshair
	- Semi-automatic adjustments for prediction
	- Added underwater sounds
	- Replaced headshot sound
	- Bandolier gives 2 extra clips instead of one
	- Items start as on and activated
	- Fixed bullet hole shader in /scripts/xxbullets.script
	- Made items turn on automatically when spawning
	- Fixed tigoggles linux crash
		- Weapon animation system overhauled for more acurate animations
		- Bullets work under water
		- Knife slashing animation plays more than once now
		- No randomness on recoil
		- Made weapons on ground larger to look more realistic
		- Animations and sounds play properly on ladders

1.1 Known Issues:
	- Sometimes your weapon doesn't re-appear when bandaging. the work around is to change weapons
	- The Macintosh bug still remains


Beta 1.0
==============
[8.5.00]

- Weapons: UMP, H&K 69, Knife, Spas 12, PSG1 Sniper Rifle, Berreta, G36
- Custom maps: Hotel, Streets2, TrainYard, MBase, Swim
- Radio Commands
- Secondary Fireing Systems


Former/Inactive FrozenSand, LLC/Silicon Ice Development Members:
========================

-Apoxol
-Bar-B-Q
-Basilisk
-BattleCow
-Bittar
-BotKiller
-CGmonkey
-CrazyButcher
-Cricel
-CrystalMesh
-Density
-DickDastardly
-Dokta8
-Dracostian
-Dragonne
-EarthQuake
-FearMe
-Fenix
-Flash
-Flux
-FreakStorm
-Gerbil!
-GottaBeKD
-Iain
-Jaker
-MajkiFajki
-Meaty
-Miles
-NrGizer
-Nitro
-Odd
-Preacher
-Queenbee
-Sir Chumps
-Smachine
-SweetNutz
-Thaddeus
-TTimo
-TwentySeven
-WetWired
-.EXE
-Wu