# remove symlinks, if they belong to us.

[ -e etc/timidity.cfg ] && \
  [ "$( readlink etc/timidity.cfg )" == "timidity/crude.cfg" ] && \
  rm -f etc/timidity.cfg

[ -e etc/timidity/timidity.cfg ] && \
  [ "$( readlink etc/timidity/timidity.cfg )" == "crude.cfg" ] && \
  rm -f etc/timidity/timidity.cfg
