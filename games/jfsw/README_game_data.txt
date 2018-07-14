For the full version, you can copy SW.GRP from:

- An installed copy of the DOS game.
- The "swinst" directory of the install CD.
- Download the game from GoG.com, free of charge (account creation
  required). See: https://www.gog.com/game/shadow_warrior_complete
- Download the game from Steam.
- Simply install the jfsw_registered_data package from SBo.

Copy the SW.GRP file to "/usr/share/games/jfsw/sw.grp".

To get the in-game music working, see README_music.txt.

The game engine checksums the files in /usr/share/games/jfsw/, so the
filenames aren't really critical... except that they *must* be lowercase
(game fails to start otherwise).

jfsw can also play Wanton Destruction (WT.GRP), the expansion pack to
Shadow Warrior that was originally developed in the 90s but never released
commercially. In 2005, it was released as a freeware download. To play
this version of the game, install jfsw_wanton_destruction.

Possible .grp files:
Registered sw.grp:  47536148 bytes, md5sum 9d200b5fb4ace8797e7f8638c4f96af2
"Alternate" sw.grp: 47536148 bytes, md5sum 92006f69a15ffa5f48b7dcd07b75fda9
Shareware sw.grp:   26056769 bytes, md5sum dafeec1b83bd31edc6dafffc9a75bdb8
Wanton Destruction wt.grp: 48698128 bytes, d0f8dc0718127ca480abf14f3a9508c2

If you have the "alternate" (hacked? pirated?) version of sw.grp, it
differs by only a few bytes. jfsw will refuse to "see" it because the
checksum doesn't match. You can convert it to the version jfsw expects,
by running these commands (in bash or zsh) in the directory with the
file in it:

echo -ne '\x2f\x2f\x30\x2f\x30\x2f\x2f\x2f\x2f\x33\x36\xa6\x32\x33\x31\x30' | \
          dd of=sw.grp conv=notrunc bs=1 seek=39170528
echo -ne '\x30\xa4\x31\x31\x30\x30\x30\x30\x31\x31\x30\x30\x30\x31\x31\x31' | \
          dd of=sw.grp conv=notrunc bs=1 seek=39170544

The above may look like gibberish but it does work! Afterwards,
double-check the length and md5sum of sw.grp. It should match the
Registered version, above.
