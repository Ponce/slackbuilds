# By Giuseppe Borzi' - my first sed scriptfile
# cancels lines after the proglogue
# Modified by Pablo Santamaria for section 3 of manual pages
1,/END\ PROLOGUE/!d
1,/END\ PROLOGUE/{
# defines and print the title
/^\*DECK/{
s/^\*DECK *\(.*\)/.TH \1 3/
p
s/.*/.SH SYNOPSIS/
}
s/^ *//
# The hell !
/^C\*\*\*BEGIN PROLOGUE/{
# convert to lowercase for use in NAME
y/ABCDEFGHIJKLMNOPQRSTUVWXYZ/abcdefghijklmnopqrstuvwxyz/
# append next line
N
s/^c\*\*\*begin prologue *\([a-z0-9]*\)\nC\*\*\*PURPOSE *\(.*\)/\1 \\- \2/
t nosubsidiary
s/\nC\*\*\*SUBSIDIARY//
N
s/^c\*\*\*begin prologue *\([a-z0-9]*\)\nC\*\*\*PURPOSE *\(.*\)/\1 \\- \2/
:nosubsidiary
h
# print NAME heading
s/.*/.SH NAME/
p
# retrieve original line from hold space and rewrite
x
}
# cancels END PROLOGUE
s/^C\*\*\*END PROLOGUE.*//
# change each C*** to a roff section heading
s/^C\*\*\*/.SH /
# builds headings formed by two or more words
/\.SH ROUTINES CALLED/{
h
s/\(\.SH ROUTINES CALLED\).*/\1/
p
x
s/\.SH ROUTINES CALLED *\(.*\)/\1/
}
/\.SH REVISION HISTORY  (YYMMDD)/{
h
s/\(\.SH REVISION HISTORY  (YYMMDD)\).*/\1/
p
s/\(\.SH REVISION HISTORY  (YYMMDD)\).*/.PD 0/
p
x
s/\.SH REVISION HISTORY  (YYMMDD) *\(.*\)/\1/
}
/\.SH COMMON BLOCKS/{
h
s/\(\.SH COMMON BLOCKS\).*/\1/
p
x
s/\.SH COMMON BLOCKS *\(.*\)/\1/
}
/\.SH SEE ALSO/{
h
s/\(\.SH SEE ALSO\).*/\1/
p
x
s/\.SH SEE ALSO *\(.*\)/\1/
}
# builds headings formed by one word
/\.SH/{
h
s/\(\.SH *[A-Z]*\).*/\1/
p
x
s/\.SH *[A-Z]* *\(.*\)/\1/
}
# strip initial C and eventually spaces
s/^C  *//
s/^C$//
# this is Y2K compliant !
/[0789][0-9][01][0-9][0-3][0-9]/i\
.P
}
