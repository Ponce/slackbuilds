
Notes for using SlackBuilds.org csh package:

This csh build conflicts slightly with Slackware's tcsh package. The
easiest way to use this is to "removepkg tcsh" before installing csh. If
you want to do this, you can skip the next section.


Installing csh and tcsh together
--------------------------------

It's possible for csh to coexist with tcsh, with a few caveats:

The shell is installed as /usr/bin/csh to avoid conflicting with
Slackware's own tcsh package (which makes /bin/csh a symlink to tcsh). If
you want to make /bin/csh point to the real csh, you have two choices:

1. remove the /bin/csh symlink before installing the csh package:
     # rm -f /bin/csh
   The /bin/csh symlink will get created when csh is installed.

2. adjust the symlink manually after csh installation:
     # rm -f /bin/csh
     # ln -s ../usr/bin/csh /bin/csh
   This works the same way as e.g. the /usr/bin/vi symlink, which points
   to either elvis or vim.

If you have both csh and Slackware's tcsh installed, and you remove csh,
you'll want to reinstall tcsh to clean up afterwards.

Removing tcsh while csh is installed should be perfectly OK.

Installing/upgrading tcsh when csh is already installed is probably a
bad idea. Remove csh first, install tcsh, then install csh.

As far as I know, nothing in Slackware depends on tcsh, so if you
mess things up, you won't break your OS. You can always put things
back to Slackware's default state by removing both csh and tsch, then
reinstalling tcsh.


Using csh as a login shell
--------------------------

If you want to use csh as a login shell, be aware that Slackware's
shipped /etc/csh.login (from the etc package) contains tcsh-specific
code, which prevents the /etc/profile.d/*.csh scripts from running. This
won't prevent you from logging in, but your environment won't be set up
correctly, you'll see "[: No match." errors, and your prompt won't show
your username, hostname, current directory as tsch does.

To fix this, you can replace /etc/csh.login with the /etc/csh.login.new
installed with the csh package. It behaves the same as the original,
for tcsh, and has conditional code to make csh behave correctly.

  # cp /etc/csh.login /etc/csh.login.orig   # back up original just in case
  # mv /etc/csh.login.new /etc/csh.login

If you don't want to replace Slackware's csh.login, just rm
/etc/csh.login.new and forget about it.


Other notes
-----------

You should read the man page for csh. Also
/usr/doc/csh-$VERSION/paper.(txt|pdf) is a good intro to the C shell for
beginning users. Also, if you're an experienced tcsh user, you might
re-read the NEW FEATURES section in tcsh's man page (it describes the
tcsh features you won't find in csh).

NEVER make csh the default shell for the root account! In fact, it's
probably a bad idea to ever change root's default shell on any Linux or
UNIX system, especially a third-party one that isn't shipped with the OS.

The man page for csh states that "Words can be no longer than 1024
characters", but this build of csh increases the limit to 8192 (actually,
BUFSIZ as defined in stdio.h). This was done so Slackware's profile.d
scripts will work correctly (particularly coreutils-dircolor.sh).
