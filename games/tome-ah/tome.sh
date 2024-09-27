#!/bin/sh
GAMES_TOME=/usr/share/games/tome-ah/bin
case $(basename $0) in
  tome-ah-gcu)
    exec ${GAMES_TOME}/tome-gcu "$@"
    ;;
  tome-ah-gtk2)
    exec ${GAMES_TOME}/tome-gtk2 "$@"
    ;;
  tome-ah-x11)
    exec ${GAMES_TOME}/tome-x11 "$@"
    ;;
  esac
