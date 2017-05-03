#!/bin/sh
cd /usr/lib64/nikto
exec /usr/bin/perl nikto.pl "$@"
