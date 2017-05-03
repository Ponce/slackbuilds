#!/bin/sh
cd /usr/lib/nikto
exec /usr/bin/perl nikto.pl "$@"
