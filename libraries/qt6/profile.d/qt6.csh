#!/bin/csh
# Environment path variables for the Qt package:
if ( ! $?QT6DIR ) then
    # It's best to use the generic directory to avoid
    # compiling in a version-containing path:
    if ( -d /usr/lib@LIBDIRSUFFIX@/qt6 ) then
        setenv QT6DIR /usr/lib@LIBDIRSUFFIX@/qt6
    else
        # Find the newest Qt directory and set $QT6DIR to that:
        foreach qtd ( /usr/lib@LIBDIRSUFFIX@/qt6-* )
            if ( -d $qtd ) then
                setenv QT6DIR $qtd
            endif
        end
    endif
endif
set path = ( $path $QT6DIR/bin )
