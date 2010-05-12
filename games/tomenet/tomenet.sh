#!/bin/sh

GAMES_TOMENET=/usr/share/games/tomenet

if [ ! -e ${HOME}/.tomenet ]; then
  mkdir -p ${HOME}/.tomenet

  # Make a copy of the lib directory for the user
  cp -R ${GAMES_TOMENET}/lib ${HOME}/.tomenet/

  # Server configuration files
  cp ${GAMES_TOMENET}/tomenet.cfg ${GAMES_TOMENET}/forbidlist ${HOME}/.tomenet/

  # Create an account file
  touch ${HOME}/.tomenet/tomenet.acc

  # Create links for running the server in ${HOME}/.tomenet
  ln -s ${GAMES_TOMENET}/tomenet.server ${HOME}/.tomenet/tomenet.server
  ln -s ${GAMES_TOMENET}/evilmeta ${HOME}/.tomenet/evilmeta
fi

cd ${HOME}/.tomenet

# Point $TOMENET_PATH to the local lib directory
export TOMENET_PATH=${HOME}/.tomenet/lib

case $(basename $0) in
  tomenet)
    exec ${GAMES_TOMENET}/tomenet "$@"
    ;;
  tomnet.console)
    exec ${GAMES_TOMENET}/tomenet.console "$@"
    ;;
  tomenet.server)
    exec ${GAMES_TOMENET}/tomenet.server "$@"
    ;;
  accedit)
    exec ${GAMES_TOMENET}/accedit "$@"
    ;;
  evilmeta)
    exec ${GAMES_TOMENET}/evilmeta "$@"
    ;;
  esac