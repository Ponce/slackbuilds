# Makefile for klick, by B. Watson (urchlay@slackware.uk). Part of
# SlackBuilds.org build for klick.

# Wrote this because the SConstruct for klick no longer works in
# modern scons, and I'm way better at Makefiles than I am at scons.

# This is the bare minimum needed to build klick. There are no clean
# or install targets, and there's no dependency info for headers.

PROJ=klick
VERSION=0.14.2

TERMINAL=yes
OSC=no
RUBBERBAND=no
SLKCFLAGS=
PREFIX=/usr
SHARE=$(PREFIX)/share/$(PROJ)

SRCS=src/audio_chunk.cc src/audio_interface.cc src/audio_interface_jack.cc src/audio_interface_sndfile.cc src/klick.cc src/main.cc src/metronome.cc src/metronome_jack.cc src/metronome_map.cc src/metronome_simple.cc src/options.cc src/position.cc src/tempomap.cc

LIBS:=$(shell pkg-config --libs jack samplerate sndfile)
FLAGS:=$(shell pkg-config --cflags jack samplerate sndfile)

ifeq ($(TERMINAL),yes)
SRCS+=src/terminal_handler.cc
DEFS+= -DENABLE_TERMINAL
endif

ifeq ($(OSC),yes)
SRCS+=src/osc_interface.cc src/osc_handler.cc
LIBS+= $(shell pkg-config --libs liblo)
FLAGS+= $(shell pkg-config --cflags liblo)
DEFS+= -DENABLE_OSC
endif

ifeq ($(RUBBERBAND),yes)
LIBS+= $(shell pkg-config --libs rubberband)
FLAGS+= $(shell pkg-config --cflags rubberband)
DEFS+= -DENABLE_RUBBERBAND
endif

DEFS+= -DHAVE_SNDFILE_OGG -DNDEBUG -DDATA_DIR='"$(SHARE)"' -DVERSION='"$(VERSION)"'
CXXFLAGS=-fpermissive $(SLKCFLAGS) $(DEFS) $(FLAGS)

OBJS=$(SRCS:.cc=.o)

all: $(PROJ)

$(PROJ): $(OBJS)
	$(CXX) -o $(PROJ) $(OBJS) $(LDFLAGS) $(LIBS)

$(OBJS): $(SRCS)
