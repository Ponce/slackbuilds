# 20240916 bkw: this may end up in the template, so explanation:
#
# The "man -k", "apropos", and "whatis" commands in Slackware's
# man-db rely on a database of man pages, that gets built nightly by
# /etc/cron.daily/man-db, which runs the mandb command. This means any
# man pages installed by SBo packages should get added to the database
# within 24 hours of the time they're installed.
#
# Well and good, except it doesn't always work: if the timestamps on
# the /usr/man/man* directories in the package are older than the last
# time the cron job ran, then the next time it runs, mandb will see
# that the timestamp is older than the database, and will not search
# for new man pages. In fact, when this happens, the man pages *never*
# get added to the database.
#
# If you only ever install packages right after building them, you
# won't have this problem. However, if you install an older package
# you built yesterday (last week, etc), its /usr/man/man* timestamps
# will be older than the man database...
#
# It's easy enough to avoid the problem. Duncan Roe came up with the
# idea for this on the mailing list: Touch the man directories in the
# doinst.sh script for any build that installs man pages. The new
# man pages will get added to the database the next time the cronjob
# runs.
#
# It does *not* mean that "man -k" will be able to find newly
# installed man pages *immediately* after installing a new
# package... but then, as pointed out by KB_SBo (aka King Beowulf)
# on the mailing list, "locate" can't find the new files immediately
# either (it updates nightly, same as mandb), and nobody complains
# about that.

[ -d usr/man ] && find usr/man -type d -exec touch {} +
