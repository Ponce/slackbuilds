#!/bin/sh

rm -f /usr/bin/claude
ln -sf /usr/lib64/node_modules/@anthropic-ai/claude-code/cli.js /usr/bin/claude
