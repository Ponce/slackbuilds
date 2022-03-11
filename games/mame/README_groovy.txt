GroovyMAME, also known as GroovyUME, is a fork of MAME/UME with
greater emphasis on CRT monitor support, in order to provide smoother
gameplay with less input lag than using regular MAME on an LCD screen.

GroovyMAME has a discussion forum:
http://forum.arcadecontrols.com/index.php?board=52.0

GroovyMAME used to be provided as a patch against the standard MAME
sources, until its author made it a proper fork on github. This
SlackBuild supports patching the MAME sources with the GroovyMAME
changes from github.

To build with GroovyMAME, export GROOVY=yes in the environment. The
resulting mame package will mention GroovyMAME in its slack-desc
(which you will see when you install it).

If you get an error that says there is no GroovyMAME patch for this
version of MAME, that means that I updated mame.SlackBuild before the
GroovyMAME author made a release based on that version of MAME (or,
it means you're trying to build a newer MAME by setting VERSION in the
environment). You can check for a release at:

https://github.com/antonioginer/GroovyMAME/releases

If there's no release matching your MAME version, you're out of luck.
Wait until there is one.

If there *is* a new release, you have two choices:

1. Wait until I update the GroovyMAME patch. I can't guarantee that
   I'll always do this in a timely manner. Please don't email and
   bug me about this: I maintain over 700 SlackBuilds, and I try to
   have a life outside of that, too.

2. Run mame.SlackBuild with GROOVY=update in the environment. This
   will attempt to create a GroovyMAME patch for the MAME version
   you're building, if the GroovyMAME author has done a release. If
   you get a "can't find GroovyMAME release" error, that means there
   isn't one yet, so you'll have to wait a few days. If you know for
   a fact that there *is* a release, it means there's probably a bug
   in my mkgroovy.sh script (in which case, please do contact me by
   email, so I can fix it).

Note that GROOVY=update requires the SlackBuild to access the Internet
(which SlackBuilds normally don't do). Specifically, it runs "curl"
as the root user, and downloads a JSON file and the actual diff (if
found) from https://api.github.com. If you don't trust this, you can
instead run the mkgroovy.sh script (found in the same directory as the
SlackBuild) as a non-root user, and copy the resulting .diff to the
SlackBuild directory.

If you have multiple gm*.diff files that match the MAME version, the
script will try to use the one with the highest GroovyMAME version
number. If it picks the wrong one, remove the ones you don't want
to use.

NOTE: I don't currently own any CRT monitors that work on a PC, so I
can't actually test the GroovyMAME enhancements.
