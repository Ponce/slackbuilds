
To avoid conflicting with Slackware's elvis and vim packages, this build
installs binaries to /opt/ex-vi/bin and man pages to /opt/ex-vi/man,
along with a script in /etc/profile.d to prepend these paths to PATH and
MANPATH. If you *really* want, you can replace the /usr/bin/vi symlink
(that normally points to elvis or vim), but it shouldn't be necessary.

After installing, either log out & back in, or "source
/etc/profile.d/ex-vi.sh". To temporarily disable the scripts, remove
their execute bits. Users can always set PATH and MANPATH in their own
dotfiles, of course.

In visual mode (vi or :vi from ex), ex-vi has compiled-in values for
the maximum terminal size, in columns and rows. This build will support
terminals up to 320x200 characters by default. If you get 'Terminal too
wide' errors, make your terminal as large as possible and rebuild ex-vi
from within it, with a command like:

TUBECOLS=$COLUMNS TUBELINES=$LINES ./ex-vi.SlackBuild

Exceeding the maximum line height just means vi will ignore the extra
lines at the bottom of the screen. Note that increasing these values
causes vi to use more memory, but on a fairly modern system it shouldn't
be too much. If you're building for a memory-poor system (embedded, or old
hardware), you could save memory with e.g. TUBECOLS=80 TUBELINES=25 or so.

If you *really* need to run vi without 'Terminal too wide', you can
export e.g. COLUMNS=80 in the environment, and vi will only use part of
the terminal. The COLUMNS variable gets reset whenever an X terminal is
resized (at least for most X terminal emulators).

Thanks to zacts on Freenode IRC ##slackware for pointing out the terminal
size limitation.
