Original behaviour in NextStep and OpenStep file viewer was that the first
file view window had no close button or titlebar. This tends to bug the
hell out of modern users, so this build includes an optional patch that
adds a title bar (with a disabled close button) to the first viewer.

This is strictly a cosmetic change... except if you run windowmaker,
it allows normal wmaker stuff (right-click menu with minimize, Move to,
Omnipresent, etc). Without a title bar, it's awkward or impossible to
do normal window operations, so the patch actually adds functionality.

By default, the patch isn't included in the build. To include it, set
TITLEBAR=yes in the environment, like so:

# TITLEBAR=yes ./fsviewer.SlackBuild

...or if you use sbopkg, set TITLEBAR=yes as a build option.
