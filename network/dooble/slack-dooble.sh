#!/usr/bin/bash

cd /opt/dooble || exit

export DOOBLE_TRANSLATIONS_PATH=./Translations
export QTWEBENGINE_DICTIONARIES_PATH=./qtwebengine_dictionaries

exec ./Dooble "$@"
