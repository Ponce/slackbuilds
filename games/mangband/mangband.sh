# #!/bin/sh

GAMES_MANGBAND=/usr/share/games/mangband

if [ ! -e ${HOME}/.mangband ]; then
  mkdir -p ${HOME}/.mangband

  # Make a copy of the lib directory for the user
  cp -R ${GAMES_MANGBAND}/lib ${HOME}/.mangband/

  # Server configuration files
  cp ${GAMES_MANGBAND}/mangband.cfg ${HOME}/.mangband/

  # Create an account file
  #touch ${HOME}/.mangband/mangband.acc

  # Create links for running the server in ${HOME}/.mangband
fi

cd ${HOME}/.mangband

# Point $MANGBAND_PATH to the local lib directory
export MANGBAND_PATH=${HOME}/.mangband/lib

case $(basename $0) in
  mangband)
    exec ${GAMES_MANGBAND}/mangclient "$@"
    ;;
  mangbandd)
    exec ${GAMES_MANGBAND}/runserv "$@"
    ;;
  esac
