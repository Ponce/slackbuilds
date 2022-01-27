Gameplay changes from the original:

- Included J.R. "Bob" Dobbs and Slackware logo playfields. The Slackware
  logo came from http://www.slackware.com/~msimons/slackware/grfx/
  and the Dobbs image was scanned from the cover of "The Book of the SubGenius"
  and was taken from
  http://briarfiles.blogspot.com/2009/11/featured-pipe-smoker-fictional-jr-bob.html

- Only have the game "insult" the player when he dies. The original
  code popped up a pretty much constant stream of insults the whole
  time, which was *very* distracting and totally pointless.

Porting changes from the original:

- Use /var/games for the high score file, instead of the current directory.

- Use /usr/share for the data files, instead of the current directory.

- Minor compile/linking fixes (see the SlackBuild).

- Use a Makefile rather than scons. The SConstruct no longer works with
  recent versions of scons.
