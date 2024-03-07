% GLULXE-GLKTERMW(1) 0.6.1 | SlackBuilds.org
% Andrew Plotkin, John Goerzen
% March 2024

# NAME

glulxe-glktermw - execute Glulx interactive fiction

# SYNOPSIS

**glulxe-glktermw** *filename* [ *options* ]

# OVERVIEW

**glulxe-glktermw** executes Glulx-format interactive fiction games, which
typically end with .ulx, .gblorb, .glb, .blorb, or .blb. **glulxe-glktermw**
can work with only a terminal.

The only required parameter is the filename of the game to
play. The remaining parameters are all optional, and come
from the glktermw library.

If you have **glulxe-remglk** and/or **glulxe-cheapglk** executables,
these support extra options. Currently these don't have man pages, but
you can run them with **-help** to see the options.

Further information can be found in /usr/doc/glulxe-0.6.1/README.md.
Note that the **-singleturn** example requires **glulxe-remglk**.

# OPTIONS

Game options (note: double dash, **-\-**). *NUM* options can be any number.

**-\-undo** *NUM*
:  Number of undo states to store.

**-\-rngseed** *NUM*
:  Fix initial RNG if nonzero.

**-\-profile** *filename*
:  Generate profiling information to a file.

**-\-profcalls**
:  Include what-called-what details in profiling. (Slow!)

Library options (note: single dash, **-**). *BOOL* options can
be *yes* or *no*, or no value to toggle.

**-width** *NUM*, **-height** *NUM*
:  Sets the screen width or height.  Normally automatically determined.

**-ml** *BOOL*
:  Enables or disables the message line (default "yes").  This is the bottom line
   of the screen.
   
**-revgrid** *BOOL*
:  Reverse text in grid (status) windows (default "no").

**-historylen** *NUM*
:  Sets the number of commands to keep in the history for each window (default 20).

**-border** *BOOL*
::  Whether or not to force one-character borders between windows.
   The default turns on borders unless the game switches them off.
   Setting to "yes" forces them on at all times, or "no" forces them
   off at all times, ignoring the game's request.
   
**-defprompt** *BOOL*
:  Provide defaults for file prompts (default "yes").

**-precise** *BOOL*
:  Whether to use more precise timing for timed input (default "no").

**-version**
:  Display Glk library version.

**-help**
:  Display command-line help.

# ABOUT

glulxe was written by Andrew Plotkin <erkyrath@eblong.com> and can be found at
<https://www.eblong.com/zarf/glulx/>.  glktermw was written by Andrew Plotkin <erkyrath@eblong.com>
and Alexander Beels <arb28@columbia.edu> and can be found at
<https://www.eblong.com/zarf/glk/index.html>.

This manpage was written for Debian by John Goerzen <jgoerzen@complete.org> based
on information in the above locations. It was updated for glulxe-0.6.1 by B. Watson <urchlay@slackware.uk>.
