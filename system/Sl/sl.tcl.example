#
# runtime configuration file for sl (http://www.PracticalThought.com/sl/)
#



# 1. override variables

# turn off color
#set COLORIZE 0

# if your terminal supports Unicode characters, use them
set I18N(...) "\u2026"

set SWITCH(title) 1	;# turn on prettyname
set SWITCH(nosfx) 1	;# once you know it's audio or video, don't care what arcane file format it is
set SWITCH(prefix) 3	;# turn on prefix elision

# if your terminal supports 256 colors, these may be preferable
# For other color codes, see colortest (http://www.vim.org/scripts/script.php?script_id=1349).
array set STYLE {
    file ";38;5;28"  dir ";38;5;20"
    relrec,file ";38;5;202" relrec,dir ";38;5;202"
    warning ";38;5;196"
    post ";38;5;232"
}


# add names to highlight or not show at all
#append NOTABLE {|TODO$|notes|TOSORT}
#append IGNORE {|^(tmp|old|obsolete|ignore|bkup)$}

#set K 1000; # set K/M/G/T size suffixes to base 10 vs base 2

# set TIME(recent) [expr $TIME(DAY)*2]

#set COLSEP 4
#set NAMEMIN 1000; # turn off name shortening

# see supporting files like C .h and .o
#set SWITCH(ignore) 2

# consider .xml a document, not data
#set EQ(.xml) doc

# some Linux file systems do not update atime, so turn off to avoid stale information
#set SWITCH(relread) 0

# L10N
set I18N(file) fecho



# 2. per file hook to override properties
# startup file gets tuple for each file fully loaded with data, just before display, to modify as he pleases
proc perfile {dir tuple} {
    global EQ

    # a. unpack
    lassign $tuple tail sfx type group sortkey  style pre display warning post  size mtime atime


    # b. your changes here

    # example: negate dir reclassification
    if {$type=="directory"} {set group "dir"}

    # example: show #lines of selected file
    if {$tail=="sl" && $type=="file"} {
	append post " [lindex [exec wc sl] 0]l"

    # example: on Ant build.xml, show date and number of last build (<buildnumber /> task)
    } elseif {$tail=="build.xml" && [file readable [set f "$dir/build.number"]]} {
	set fid [open $f]; set txt [read $fid]; close $fid
#puts $txt
	regexp {build.number=(\d+)} $txt all num
	if {$num!=""} {append post " #$num"}
	append post "[reltime [file mtime $f]]"
    }

    # example: auto search for filename matching regexp and highlight (show in black on magenta background)
    #if {[regexp -nocase {license|password} $tail]} {set style ";30;46"}

    # example: local naming convention that puts date at start of file in form yyyymmdd-filename,
    #  but problematic for sorting by Tcl lsort -dictionary, so reformat
    regsub {^(19|20)(\d\d)(\d\d)(\d\d\D)} $sortkey {\1\2.\3.\4} sortkey
    regsub {^(19|20)(\d\d)(\d\d\D)} $sortkey {\1\2.\3} sortkey


    # c. repack
    return [list $tail $sfx $type $group $sortkey  $style $pre $display $warning $post  $size $mtime $atime]
}



# 3. redefine procs

#proc vc {} ...

# turn off series construction
#set SWITCH(series) 0

# change how names are shortened
#proc shorten {txt w} {}

# classify dir as plain dir, not audio/video and not separate uppercase/lowercase
#proc classifydir {dir tail l} {return "dir"}

# change evaluation of what constitutes a distinctive file for -only
#proc distinctive {tuple} {return 1}
