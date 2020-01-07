As of mame-0.215, it's no longer possible to compile mame with Slack
14.2's gcc-5. mame-0.214 is the last version that can be built, so this
SlackBuild is stuck at that version.

However, if you're willing to go beyond stock Slackware, it's possible
to build newer versions of mame. There are gcc-9.2.0 packages for 14.2
here:

http://slackware.uk/slackware/unsupported/gcc-9.2.0-for-Slackware-14.2/

Make sure you read the README, then download the gcc-9.2.0 and
gcc-g++-9.2.0 .txz packages for your architecture (you won't need the
other languages such as fortran and go). Before installing them, remove
your stock gcc and gcc-g++ packages with:

# removepkg gcc gcc-g++

(You don't have to remove the other languages such as gcc-fortran here)

Install the gcc packages you just downloaded:

# installpkg gcc-*9.2.0*.txz

Then you can download the newer mame source from:

https://github.com/mamedev/mame/releases/

You want the source code (filename such as mame0217.tar.gz). Save the
file in the same directory as the SlackBuild, cd into that directory,
then build mame with a command such as:

VERSION=0.217 ./mame.SlackBuild

...where VERSION matches the mame source you just downloaded (with a
dot after the 0, as shown above). If all goes well, you should have a
shiny new mame package in /tmp, which you can install with installpkg
or upgradepkg.

After the build finishes, you should revert your gcc and g++ packages
back to the standard Slackware ones. You can do this with:

# removepkg gcc gcc-g++
# slackpkg install 'gcc-*'

Notes:

- Do not ask for help with this via the SlackBuilds.org mailing list. If
  you run into problems, you can contact me (B. Watson, yalhcru@gmail.com)
  directly via email, or on Freenode IRC as user Urchlay.

- I may not test every mame release with gcc-9.2.0. 0.217 definitely
  works, future releases *probably* will. When Slackware 15.0 is
  released, things should get back to normal.

- The README for this build states that mame compiles require around
  3.5GB in /tmp. For 0.217, this number is more like 4.5GB.

- There is an llvm-8.0.1 in 14.2's /extra. Although the mame documentation
  claims that this version of llvm is supported, I can't get mame to
  compile with it.
