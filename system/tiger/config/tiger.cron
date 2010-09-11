#
# Regular cron jobs for the tiger package
#
# Configuration file
DEFAULT=/etc/default/tiger
#  default setting, overriden in the above file
NICETIGER=10
#
0 * * * *      root    test -x /usr/sbin/tigercron && { [ -r "$DEFAULT" ] && . "$DEFAULT" ; nice -n$NICETIGER /usr/sbin/tigercron -q ; }
