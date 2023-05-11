#!/bin/sh
# Print a random pokemon for interactive shells:

case $- in
*i* )  # We're interactive
  echo
  pokemon-colorscripts -r
  echo
  ;;
esac
