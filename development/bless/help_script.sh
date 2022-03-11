#!/bin/sh

# Script that loads help for Bless. Modified by B. Watson for
# slackbuilds.org. Ditched all the gconf, yelp, gnome-help stuff
# and just use xdg-open for the HTML help in the user's default
# browser.

exec xdg-open /usr/doc/bless-@VERSION@/user/index.html
