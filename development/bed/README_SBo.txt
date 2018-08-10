These terminals and TERM settings were tested and work fine:

Terminal         TERM    Notes
---------------+-------+------------------------------------------------
Linux console  | linux | Default TERM setting.
rxvt           | rxvt  | Default TERM setting.
urxvt          | rxvt  | But *not* the default of "rxvt-unicode"!
xterm          | xterm | Or "xterm-color". Enable "meta sends escape",
               |       | or use Escape as the meta key.
xcfe4-terminal | xterm | Works, but e.g. Alt-F activates the terminal's
               |       | own "File" menu, so you have to use Esc-F for
               |       | bed's "File" menu. Default TERM setting.
konsole        | xterm | Default TERM setting.

See also the TERMINALS section of bed's man page.

Two quick things to test, the first time you start up bed:

F7 and F8 should switch between Ascii and Digit-Hex input modes in the
status bar at the bottom of the screen. If they don't, try running bed as
'TERM=rxvt bed' or 'TERM=xterm-color bed'. If this works, you can define
it as a shell alias in e.g. ~/.bash_profile. If you're launching bed
from the KDE or XFCE start menu, you can likely force TERM from within
bed's config file (~/.bedrc or /usr/lib64/bed-3.0.0/bedrc).

Alt-X should exit the program. If it doesn't (if it does nothing, or does
some other function like moving the cursor), try pressing Escape followed
by X. If this works, you can either use Escape instead of the Alt key for
all "Meta" commands, or else reconfigure your terminal. In xterm, this
can be done with the ctrl-leftclick menu (enable "Meta Sends Escape"),
or set xterm's metaSendsEscape and/or altSendsEscape resources to 'true'
in ~/.Xdefaults.

It should be possible to define a set of keybinds for bed that work with
any terminal and TERM, with "bed -k ~/.bedrc". No, I don't know what a
"stab" key is, either (just pick an otherwise-unused keystroke for it).
I also don't know why it asks you to press the various keys in a seemingly
random order... but it does work.
