#!/bin/csh
# Environment path variables for the Qt package:
if ( ! $?QT5DIR ) then
    # It's best to use the generic directory to avoid
    # compiling in a version-containing path:
    if ( -d /usr/lib@LIBDIRSUFFIX@/qt5 ) then
        setenv QT5DIR /usr/lib@LIBDIRSUFFIX@/qt5
    else
        # Find the newest Qt directory and set $QT5DIR to that:
        foreach qtd ( /usr/lib@LIBDIRSUFFIX@/qt5-* )
            if ( -d $qtd ) then
                setenv QT5DIR $qtd
            endif
        end
    endif
endif
set path = ( $path $QT5DIR/bin )
