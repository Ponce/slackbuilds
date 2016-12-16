Jul 25 1999, 09:29:46
bin2iso V1.9b - Converts RAW format (.bin) files to ISO/WAV format
               Bob Doiron, ICQ#280251

Linux port by Owen: mxu@cae.wisc.edu

Check for updates at http://users.andara.com/~doiron

Usage: bin2iso <cuefile> [<output dir>] [-[a]wg] [-t XX] [-i] [-nob]
or   : bin2iso <cuefile> -c <binfile>

Where:
   <cuefile>    - the .cue file that belongs to the .bin file to
                  be converted
   <output dir> - the output directory (defaults to current dir)
   -nwg         - indicates that audio data found in the track
                  'gaps' shouldn't be appended to the audio tracks
   -awg         - looks for non-zero data in the 'gaps', if found
                  then gaps are appended to audio tracks. Looks
                  for more than 1/2 of a sector of non-zero values
                  (588 values),
   -t XX        - Extracts the XX'th track.
   -i           - Performs the conversion 'in place'. Meaning it
                  truncates the binfile after each track is
                  created to minimize diskspace requirements.
                  [not valid with -t]
   -nob         - Doesn't use overburn data past 334873 sectors.
                  This of course presumes that the data is not
                  useful.
   -c           - Attempts to create a <cuefile> from an existing
                  <binfile>


---------------------------------------------------------------------
NOTE: This is a work in progress!

So far I beleive it handles MODE1, MODE2 and AUDIO tracks.

Since I have little exposure to .bin files, and little expertise in 
CD formats, I can't guarantee this will work for all .bin's.

so... TEST the output before burning. Use Winimage on the ISO files  
and a wave player on the WAVs.

If you do run into trouble, send me the following info:
- .cue file
- command line used
- the screen output 
- directory listing of source and files created (with sizes)
and I'll fix it up.

Revision History 

v1.9b
 - Oops.. was no way to turn writegap off: 
   changed -wg option to -nwg

v1.9a
 - Fixed bug in extracting single track
 - changed code to default to writing gap data because of the way 
   easycd pro writes the table of contents for the cd

v1.9
 - revamped internally allowing me to do add some functionality...
   Added a -i option to allow converting a bin using a little diskspace
   as possible. !NOTE! This is destructive to the original .bin
 - No longer barfs on PREGAP lines...
 - Added a -awg option that checks for non-zero data in the gaps between 
   audio tracks and turns on the -wg feature if it finds more than half
   a sector of non-zero values.
 - Added a -nob option that ditches overburn data. I haven't tested this,
   but rumour has it that some cd players can't access data over 74.XX 
   minutes. I'm not sure if I beleive this, but I put the option in in
   case I get a chance to try it. (so far untested!)

v1.8b
 - modified the audio gap detection scheme for creating cue files...
   Now it may detect extra gaps, but they are easily removed by editing
   the cuefile. Before it would sometimes not detect gaps, so I think
   this is better.

v1.8
 - Added the ability to create a cuefile from a binfile.
   (assumes MODE1/2352, MODE2/2352 or AUDIO tracks)
 - Added ISO track numbering for cd's with more than one data track

v1.7
 - Made the reads/writes happen in 4Meg chunks... should speed things up 
   when read from and writing to the same disk. (less head thrashing)
 - Added Mode2/2336: When this type of track is encountered, it converts
   it to the trusty Mode2/2352 track we're used to. (Burn with EasyCD
   or open with WinImage)
   Or, if you like, you can rename the output from a .iso to a .bin and then 
   edit the cue file track type from MODE2/2336 to MODE2/2352 to burn with 
   cdrwin.

v1.6
 - Added a '-wg' command switch to make bin2iso append pregap sectors to the
   last wav file. Useful because some cd's have music in the pregaps.
   Note: most TAO burning leaves 2 second gaps between songs, so if you copy
         a copy, then don't use the -wg option. If you do use it, then the 
         audio track will grow by 2 seconds.

v1.5
 - Fixed parsing of the filename from the cue file. (handles spaces etc)
 - Added progress display
 - Detects a single track, mode2 bin which can be burnt as is.
 - Verifies data tracks (checks the mode and frame sequence)

v1.4
 - fixed bug that occured when tracks had no pregap index
 - parsing of .bin filename out of .cue file now ditches path info
 - fixed bugs in [<output dir>] parsing. (trailing '\' or ':')

v1.3
 - first release to public

Suggested programs:
WinImage - for viewing ISO images
EasyCD Pro 2.11 (020) - for burning ISO or Mixed mode ISO/WAV
                         (rumour is that creator doesn't always burn the 
                          images as is, sometimes screws long filenames
                          or burns a mode2 iso in mode1 form, etc, etc)
Nero - Burning Rom    - For burning AUDIO disks because it allows changing 
                        the gap size on my sony928e.

!DO NOT USE! Easy CD Creator for burning mode2/2352 images. You'll get a coaster.
                   

TROUBLESHOOTING

Don't know of any problems right now. Let me know.
