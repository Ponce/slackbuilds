#!/usr/bin/make -f

MCS = gmcs
TARGET = Nini.dll
KEYFILE = Nini.snk

SOURCES = Source/AssemblyInfo.cs \
          Source/Config/*.cs \
	  Source/Ini/*.cs \
	  Source/Util/*.cs

DEFINES = -define:MONO_2_0 \
          -define:STRONG
	  
REFERENCES = -r:System.dll \
             -r:System.Xml.dll

all: $(TARGET)

$(TARGET): $(KEYFILE) $(SOURCES)
	mkdir -p build
	$(MCS) -target:library -out:build/"$@" \
	$(DEFINES) $(REFERENCES) -keyfile:$(KEYFILE) $(SOURCES)

