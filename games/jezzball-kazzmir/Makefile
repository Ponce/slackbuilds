PRGNAM=jezzball

SRCS=$(wildcard src/*.cpp)
OBJS=$(patsubst %.cpp,%.o,$(SRCS))

CXX=g++
OPTFLAGS=
CXXFLAGS=$(OPTFLAGS) -Wno-write-strings $(shell allegro-config --cflags) $(shell libpng-config --cflags)
LDFLAGS=$(shell allegro-config --libs) -ljpgalleg -lloadpng $(shell libpng-config --libs)

all: $(PRGNAM)

$(PRGNAM): $(OBJS)
	$(CXX) -o $(PRGNAM) $(OBJS) $(LDFLAGS)

$(OBJS): $(SRCS)
