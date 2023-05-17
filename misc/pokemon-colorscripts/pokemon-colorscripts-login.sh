#!/bin/sh
# Print a random pokémon for interactive shells:

case $- in
*i* )  # We're interactive
  echo
  pokemon-colorscripts -r
  echo
  ;;
esac
