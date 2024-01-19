#!/bin/bash

# Launch a per-user nss-tlsd process, with caching.
# Part of the SBo nss-tls build, by B. Watson, WTFPL licensed.
# Other distributions use systemd to launch this when a user logs
# in, we have to have users launch it from e.g. .bash_profile. This
# wrapper script simplifies the setup.

# Note that launching the user daemon isn't required, but since the
# system daemon doesn't do caching for security reasons, the user
# daemon might help performance a bit.

# Using setsid --fork here prevents this script from hanging around
# waiting for nss-tlsd to exit.

if [ -x /usr/sbin/nss-tlsd ]; then
  [ -e ~/.cache/nss-tlsd.sock ] || setsid --fork /usr/sbin/nss-tlsd -c &>/dev/null &
fi

exit 0
