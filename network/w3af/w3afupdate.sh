#!/bin/sh

set -e

( cd /opt/w3af
  svn up >> /var/log/w3afupdate.log 2>&1
)
