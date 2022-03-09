#!/bin/sh

if [ "$1" = "--help" -o "$1" = "-h" ]; then
    PYTHONPATH=$PYTHONPATH:/opt/luxcorerender-2.6 python3 \
	      /opt/luxcorerender-2.6/pyluxcoretools.zip \
	      help
  exit
fi

PYTHONPATH=$PYTHONPATH:/opt/luxcorerender-2.6 python3 \
	  /opt/luxcorerender-2.6/pyluxcoretools.zip "$@"
