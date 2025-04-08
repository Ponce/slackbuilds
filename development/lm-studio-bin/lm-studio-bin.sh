#!/bin/bash
cd /opt/lm-studio-bin || exit 1
LD_LIBRARY_PATH=/opt/lm-studio-bin:$LD_LIBRARY_PATH ./lm-studio --no-sandbox
