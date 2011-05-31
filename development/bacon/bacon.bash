#!/usr/bin/env bash
#  ____         ____
# | __ )  __ _ / ___|___  _ __
# |  _ \ / _` | |   / _ \| '_ \
# | |_) | (_| | |__| (_) | | | |   --= A BASH BASIC-to-C converter =--
# |____/ \__,_|\____\___/|_| |_|
#
# Peter van Eerten - March 2009/April 2011. License: GPL version 3.
#
#---------------------------------------------------------------------------------------------------------------------
# CREDITS:
#   - James C. Fuller for endless testing and patiently pointing to many issues
#   - John Spikowksi for giving some hints to improve the language
#   - Vovchik for providing ideas, programs and hints
#
#---------------------------------------------------------------------------------------------------------------------
# GLOBAL INITIALIZATIONS
#---------------------------------------------------------------------------------------------------------------------

# Check BASH version
if [[ ${BASH_VERSINFO[0]}$((${BASH_VERSINFO[1]}+0)) -lt 32 ]]
then
    echo "ERROR: this is BASH version ${BASH_VERSION}. BaCon needs BASH 3.2 or higher to run!"
    exit 1
fi

# Set the extended globbing option in BASH
shopt -s extglob

# Version of BACON
declare -rx g_VERSION="1.0 build 22"

# Find 'grep' and other coretools
if [[ -z `which grep` || -z `which cat` || -z `which rm` || -z `which tr` || -z `which touch` || -z `which uname` ]]
then
    echo "ERROR: 'grep', 'cat', 'rm', 'tr', 'touch' or 'uname' not found on this system!"
    exit 1
fi

# Link flags
if [[ `uname` = "OSF1" || `uname` = +(*BSD*) ]]
then
    g_LDFLAGS="-lm"
else
    g_LDFLAGS="-lm -ldl"
fi

# Solaris
if [[ `uname` = +(*SunOS*) ]]
then
    g_LDFLAGS="$g_LDFLAGS -lnsl -lsocket"
fi

# Global constant for miniparsing
declare -rx g_PARSEVAR=`echo -e "\001"`

# Global to define '$'-replacement
declare -rx g_STRINGSIGN="__b2c__string_var"

# Global to define '"'-symbol
declare -rx g_DQUOTESIGN=`echo -e "\042"`

# Global to define '''-symbol
declare -rx g_SQUOTESIGN=`echo -e "\047"`

#-----------------------------------------------------------

function Print_Element
{
    local TARGET CHECK VAR

    # Determine target
    if [[ -n $g_FUNCNAME ]]
    then
	TARGET="$g_CFILE $g_HFILE"
    else
	TARGET=$g_HFILE
    fi

    # Check on string by reference variable
    VAR=`echo ${1%%\(*}`
    CHECK=`grep -E "char \*${VAR} = NULL;" ${TARGET} 2>/dev/null`

    # Check if var is string var
    if [[ "${1%%\(*}" = +(*${g_STRINGSIGN}*) || "${1%%\(*}" = +(*${g_DQUOTESIGN}*) || "${1%%\(*}" = +(*gettext*|*ngettext*) || -n ${CHECK} ]]
    then
	echo "__b2c__assign = ${1}; if(__b2c__assign != NULL) fprintf(stdout, \"%s\", __b2c__assign);" >> $g_CFILE
    else
	echo "fprintf(stdout, \"%s\", STR${g_STRINGSIGN}(${1}));" >> $g_CFILE
    fi
}

#-----------------------------------------------------------

function Handle_Print
{
    local FORMAT EXP LEN TOKEN LINE IN_STRING IN_FUNC CHAR ESCAPED

    IN_FUNC=0

    # If no argument, do nothing
    if [[ "$1" != "PRINT" ]]
    then

	# Get expression without ;
	if [[ -z ${1##*;} ]]
	then
	    let LEN="${#1}"-1
	    EXP="${1:0:$LEN}"
	else
	    EXP="${1}"
	fi

	# If there is FORMAT/format argument
	if [[ "$EXP" = +(* FORMAT *) ]]
	then
	    FORMAT=${EXP##* FORMAT}
	    echo "fprintf(stdout, ${FORMAT%%;*}, ${EXP%%FORMAT *});" >> $g_CFILE
	else
	    # Start miniparser, convert spaces
	    LINE=`echo "${EXP}" | tr " " "\001"`
	    TOKEN=
	    LEN=${#LINE}

	    # Get the characters
	    until [[ $LEN -eq 0 ]]
	    do
		CHAR="${LINE:0:1}"
		case $CHAR in
		    ",")
			if [[ $IN_STRING -eq 0 && $IN_FUNC -eq 0 ]]
			then
			    Print_Element "${TOKEN}"
			    TOKEN=
			    CHAR=
			    ESCAPED=0
			fi;;
		    "\\")
			ESCAPED=1;;
		    "\"")
			if [[ $ESCAPED -eq 0 ]]
			then
			    if [[ $IN_STRING -eq 0 ]]
			    then
				IN_STRING=1
			    else
				IN_STRING=0
			    fi
			fi
			ESCAPED=0;;
		    "(")
			if [[ $IN_STRING -eq 0 ]]
			then
			    ((IN_FUNC=$IN_FUNC+1))
			fi
			ESCAPED=0;;
		    ")")
			if [[ $IN_STRING -eq 0 ]]
			then
			    ((IN_FUNC=$IN_FUNC-1))
			fi
			ESCAPED=0;;
		    *)
			ESCAPED=0;;
		esac
		# Convert back to space
		if [[ "${CHAR}" = "${g_PARSEVAR}" ]]
		then
		    TOKEN="${TOKEN} "
		else
		    TOKEN="${TOKEN}${CHAR}"
		fi
		let LEN=${#LINE}-1
		LINE="${LINE: -$LEN}"
	    done
	    Print_Element "${TOKEN}"

	    # If line ends with ';' then skip newline
	    if [[ -n ${1##*;} ]]
	    then
		echo "fprintf(stdout, \"\n\");" >> $g_CFILE
	    fi
	fi
    else
	echo "fprintf(stdout, \"\n\");" >> $g_CFILE
    fi

    # Flush buffer
    echo "fflush(stdout);" >> $g_CFILE
}

#-----------------------------------------------------------

function Handle_Input
{
    # Local variables
    local CHECK VAR TARGET STR LINE LEN IN_STRING IN_FUNC CHAR ESCAPED

    IN_FUNC=0

    # Check if we have an argument at all
    if [[ "$1" = "INPUT" ]]
    then
	echo -e "\nERROR: empty INPUT at line $g_COUNTER in file '$g_CURFILE'!"
	exit 1
    fi

    # Determine target
    if [[ -n $g_FUNCNAME ]]
    then
	TARGET="$g_CFILE $g_HFILE"
    else
	TARGET=$g_HFILE
    fi

    touch $TARGET

    # Start miniparser to see if we need to print something, convert spaces
    LINE=`echo "${1}" | tr " " "\001"`
    VAR=
    LEN=${#LINE}

    # Get the characters
    until [[ $LEN -eq 0 ]]
    do
	CHAR="${LINE:0:1}"
	case $CHAR in
	    ",")
		if [[ $IN_STRING -eq 0 && $IN_FUNC -eq 0 ]]
		then
		    Print_Element "${VAR}"
		    VAR=
		    CHAR=
		    ESCAPED=0
		fi;;
	    "\\")
		ESCAPED=1;;
	    "\"")
		if [[ $ESCAPED -eq 0 ]]
		then
		    if [[ $IN_STRING -eq 0 ]]
		    then
			IN_STRING=1
		    else
			IN_STRING=0
		    fi
		fi
		ESCAPED=0;;
	    "(")
		if [[ $IN_STRING -eq 0 ]]
		then
		    ((IN_FUNC=$IN_FUNC+1))
		fi
		ESCAPED=0;;
	    ")")
		if [[ $IN_STRING -eq 0 ]]
		then
		    ((IN_FUNC=$IN_FUNC-1))
		fi
		ESCAPED=0;;
	    *)
		ESCAPED=0;;
	esac
	# Convert back to space
	if [[ "${CHAR}" = "${g_PARSEVAR}" ]]
	then
	    VAR="${VAR} "
	else
	    VAR="${VAR}${CHAR}"
	fi
	let LEN=${#LINE}-1
	LINE="${LINE: -$LEN}"
    done

    # Remove spaces in variable
    VAR=`echo ${VAR}`

    # Check type of var, string?
    if [[ "${VAR}" = +(*${g_STRINGSIGN}*) ]]
    then
	if [[ ${VAR} != +(*\[*\]*) ]]
	then
	    STR=${VAR%${g_STRINGSIGN}*}
	    CHECK=`grep -E "char \*${STR}${g_STRINGSIGN} = NULL;" ${TARGET}`
	    if [[ -z $CHECK ]]
	    then
		echo "char *$VAR = NULL;" >> $g_HFILE
	    fi
	fi

	# Translate function to C function
	echo "__b2c__counter = 1; do{ memset(__b2c__input__buffer, '\0', $g_BUFFER_SIZE);" >> $g_CFILE
	echo "__b2c__assign = fgets(__b2c__input__buffer, $g_BUFFER_SIZE, stdin);" >> $g_CFILE

	# Make sure internal var is copied to var of program
	echo "$VAR = (char*)realloc($VAR, ($g_BUFFER_SIZE+1)*__b2c__counter*sizeof(char));" >> $g_CFILE
	echo "if(__b2c__counter == 1) strncpy($VAR, __b2c__input__buffer, $g_BUFFER_SIZE);" >> $g_CFILE
	echo "else strncat($VAR, __b2c__input__buffer, $g_BUFFER_SIZE); __b2c__counter++;" >> $g_CFILE
	echo "} while (!strstr(__b2c__input__buffer, \"\n\") && strlen(__b2c__input__buffer));" >> $g_CFILE
	# Cut off last newline
	echo "if (strlen(__b2c__input__buffer)) $VAR[strlen($VAR)-1]='\0';" >> $g_CFILE
    # Var is numeric or stringarray
    else
	# Variable may not be array, these should be defined with DECLARE
	if [[ "${VAR}" != +(*\[*\]*) && "${VAR}" != +(*.*) ]]
	then
	    # Not declared? Assume long
	    CHECK=`grep -E "DIR|FILE|int|long|float|double|char|void|STRING|NUMBER|FLOATING" $TARGET | grep -E " $VAR,| $VAR;|,$VAR,|,$VAR;| $VAR=" | grep -v " noparse "`
	    if [[ -z $CHECK ]]
	    then
		echo "long $VAR;" >> $g_HFILE
		CHECK="long "
	    fi
	else
	    CHECK=`grep -E "DIR |FILE |int |long |float |double |char |void |STRING |NUMBER |FLOATING " $TARGET | grep -E " ${VAR%%\[*}" | grep -v " noparse "`
	fi

	# Translate function to C function
	echo "memset(__b2c__input__buffer, '\0', $g_BUFFER_SIZE); __b2c__assign = fgets(__b2c__input__buffer, $g_BUFFER_SIZE, stdin);" >> $g_CFILE

	# Make sure internal var is copied to var of program
	if [[ "$CHECK" = +(*double *) || "$CHECK" = +(*float *) || "$CHECK" = +(*FLOATING *) ]]
	then
	    echo "$VAR = atof(__b2c__input__buffer);" >> $g_CFILE
	elif [[ "$CHECK" = +(*long *) || "$CHECK" = +(*NUMBER *) ]]
	then
	    echo "$VAR = atol(__b2c__input__buffer);" >> $g_CFILE
	else
	    echo "$VAR = atoi(__b2c__input__buffer);" >> $g_CFILE
	fi
    fi
}

#-----------------------------------------------------------

function Handle_For
{
    # Local variables
    local FROM TO TMP VAR STEP CHECK TARGET

    # Get the variablename without (surrounding) spaces
    VAR=`echo "${1%%=*}" | tr -d "\040"`; TMP=`echo "${1#*=}"`

    # Do we have a STRING var?
    if [[ "${VAR}" = +(*${g_STRINGSIGN}*) ]]
    then
	echo -e "\nERROR: variable in FOR statement at line $g_COUNTER in file '$g_CURFILE' cannot be string!"
	exit 1
    fi

    # Check if TO is available
    if [[ "$TMP" != +(* TO *) ]]
    then
	echo -e "\nERROR: missing TO in FOR statement at line $g_COUNTER in file '$g_CURFILE'!"
	exit 1
    fi

    # Get the starting and ending value
    FROM=`echo "${TMP%% TO *}"`
    TO=`echo "${TMP##* TO }"`

    # Check if there is a STEP
    if [[ "$TO" = +(* STEP *) ]]
    then
	STEP="${TO##* STEP }"
	TO="${TO%% STEP *}"
    else
	STEP=1
    fi

    # Determine target
    if [[ -n $g_FUNCNAME ]]
    then
	TARGET="$g_CFILE $g_HFILE"
    else
	TARGET=$g_HFILE
    fi

    touch $TARGET

    # Variable may not be array, these should be defined with DECLARE
    if [[ "$VAR" != +(*\[*\]*) && "$VAR" != +(*.*) ]]
    then
	# Declare variable if not done yet, assuming long
	CHECK=`grep -E "DIR|FILE|int|long|float|double|char|void|STRING|NUMBER|FLOATING" $TARGET | grep -E " $VAR,| $VAR;|,$VAR,|,$VAR;| $VAR=| ${VAR%%\[*}\[|,${VAR%%\[*}\[" | grep -v " noparse "`
	if [[ -z $CHECK ]]
	then
	    echo "long $VAR;" >> $g_HFILE
	fi
    fi

    # Translate function to C function
    if [[ "${STEP}" = +(*-*) ]]
    then
	echo "for($VAR=$FROM; $VAR >= $TO; $VAR+=$STEP){" >> $g_CFILE
    else
	echo "for($VAR=$FROM; $VAR <= $TO; $VAR+=$STEP){" >> $g_CFILE
    fi
}

#-----------------------------------------------------------

function Handle_While
{
    # Check if DO is available
    if [[ "$1" != +(* DO) ]]
    then
        Parse_Equation "${1}"
    else
        Parse_Equation "${1% *}"
    fi
    echo "while(${g_EQUATION}){" >> $g_CFILE
}

#-----------------------------------------------------------
# $1: name of ASSOC variable
# $2: name of index
# $3: actual value to assign
# $4: recursion level

function Relate_Recurse
{
    local CTR REL LVL

    # Check endless recursion
    LVL=$4; ((LVL+=1))
    if [[ $LVL -gt $g_RELATE_CTR ]]
    then
	echo -e "\nERROR: Endless recursion in RELATE statement at line $g_COUNTER in file '$g_CURFILE'!"
	exit 1
    fi

    # Now add relation
    CTR=0

    while [[ $CTR -lt $g_RELATE_CTR ]]
    do
	if [[ ${g_RELATE[${CTR}]} = +(${1}*) ]]
	then
	    REL=${g_RELATE[${CTR}]##* }
	    echo "if(__b2c__${REL}_exist(${2} == NULL) __b2c__${REL}__add(${2};" >> $g_CFILE
	    if [[ "${REL}" = +(*${g_STRINGSIGN}*) ]]
	    then
		echo "__b2c__${REL}_exist(${2}->value = realloc(__b2c__${REL}_exist(${2}->value, (strlen($3)+1)*sizeof(char));" >> $g_CFILE
		echo "strcpy(__b2c__${REL}_exist(${2}->value, $3);" >> $g_CFILE
	    else
		echo "__b2c__${REL}_exist(${2}->value = $3;" >> $g_CFILE
	    fi
	    Relate_Recurse ${REL} ${2} ${3} ${LVL}
	fi
	((CTR+=1))
    done
}

#-----------------------------------------------------------

function Handle_Let
{
    # Local variables
    local VAR CHECK TMP TARGET LEN STR CTR REL PTR

    # Check if there is an asignment at all, if not exit
    if [[ "$1" != +(*=*) ]]
    then
	echo -e "\nERROR: could not parse line $g_COUNTER in file '$g_CURFILE'!"
	exit 1
    fi

    # Determine target
    if [[ -n $g_FUNCNAME ]]
    then
	TARGET="$g_CFILE $g_HFILE"
    else
	TARGET=$g_HFILE
    fi

    touch $TARGET

    # Get the variablename without surrounding spaces
    VAR=`echo ${1%%=*}`; TMP=${1#*=}

    # Check if var is string var, exclude RECORD elements
    if [[ "${VAR}" = +(*${g_STRINGSIGN}) && "$VAR" != +(*.*) ]]
    then
	STR=${VAR%${g_STRINGSIGN}*}
	CHECK=`grep -E "char \*${STR}${g_STRINGSIGN} = NULL;" ${TARGET}`
	if [[ -z $CHECK && $g_PROTOTYPE != +(* ${STR}${g_STRINGSIGN}[ ,\)]*) ]]
	then
	    echo "char *$VAR = NULL;" >> $g_HFILE
	fi
    # Assume number, exclude RECORD and ASSOC elements
    elif [[ "$VAR" != +(*\[*\]*) && "$VAR" != +(*.*) && "$VAR" != "ERROR" && "$VAR" != +(*\(*\)*) ]]
    then
	CHECK=`grep -E "DIR|FILE|int|long|float|double|char|void|STRING|NUMBER|FLOATING" $TARGET | grep -E " $VAR,| $VAR;|\*$VAR |,$VAR,|,$VAR;| $VAR=| ${VAR%%\[*}\[|,${VAR%%\[*}\[" | grep -v " noparse "`
	if [[ -z $CHECK && $g_PROTOTYPE != +(* ${VAR}[ ,\)]*) ]]
	then
	    if [[ "$TMP" = +(*.*) && "$TMP" != +(*$g_DQUOTESIGN*) ]]
	    then
		echo "double $VAR;" >> $g_HFILE
	    else
		echo "long $VAR;" >> $g_HFILE
	    fi
	fi
    fi

    # Check if there is associative array assignment
    if [[ "${VAR}" = +(*\(*\)) ]]
    then
	STR=${VAR#*\(}
	echo "if(__b2c__${VAR%%\(*}_exist(${STR} == NULL) __b2c__${VAR%%\(*}__add(${STR};" >> $g_CFILE
	if [[ "${VAR%%\(*}" = +(*${g_STRINGSIGN}*) ]]
	then
	    echo "__b2c__${VAR%%\(*}_exist(${STR}->value = realloc(__b2c__${VAR%%\(*}_exist(${STR}->value, (strlen($TMP)+1)*sizeof(char));" >> $g_CFILE
	    echo "strcpy(__b2c__${VAR%%\(*}_exist(${STR}->value, ${TMP});" >> $g_CFILE
	else
	    echo "__b2c__${VAR%%\(*}_exist(${STR}->value = ${TMP};" >> $g_CFILE
	fi
	# Check for relations
	Relate_Recurse "${VAR%%\(*}" "${STR}" "${TMP}" "-1"

    # Do we have a STRING variable or STRING array?
    elif [[ "${VAR}" = +(*${g_STRINGSIGN}*) && "${VAR}" != +(*\[*${g_STRINGSIGN}*\]*) ]]
    then
	echo "__b2c__assign = (char*) strdup ($TMP); ${g_WITHVAR}${VAR} = (char*)realloc(${g_WITHVAR}${VAR}, (strlen(__b2c__assign)+1)*sizeof(char));" >> $g_CFILE
	echo "strcpy(${g_WITHVAR}${VAR}, __b2c__assign); free(__b2c__assign);" >> $g_CFILE
	# Also check if string var already is used for IMPORT, if so, perform dlopen again
	PTR=`echo $VAR | tr -d [:punct:]`
	CHECK=`grep -i "void\* __b2c__dlopen__pointer_$PTR;" $g_CFILE`
	if [[ -n $CHECK ]]
	then
	    echo "__b2c__dlopen__pointer_$PTR = dlopen($VAR, RTLD_LAZY);" >> $g_CFILE
	fi
    else
	echo "${g_WITHVAR}${1};" >> $g_CFILE
    fi
}

#-----------------------------------------------------------

function Handle_Open
{
    # Local variables
    local FILE MODE HANDLE TMP CHECK TARGET LABEL

    # Check if FOR is available
    if [[ "$1" != +(* FOR *) ]]
    then
	echo -e "\nERROR: Missing FOR in OPEN statement at line $g_COUNTER in file '$g_CURFILE'!"
	exit 1
    fi

    # Check if AS is available
    if [[ "$1" != +(* AS *) ]]
    then
	echo -e "\nERROR: Missing AS in OPEN statement at line $g_COUNTER in file '$g_CURFILE'!"
	exit 1
    fi

    # Get the file, mode and handle
    FILE=`echo "${1%% FOR *}"`
    TMP=`echo "${1##* FOR }"`

    MODE=`echo "${TMP%% AS *}"`
    HANDLE=`echo "${TMP##* AS }"`

    # Check if var is string var
    if [[ "${HANDLE}" = +(*${g_STRINGSIGN}) && $MODE != "MEMORY" ]]
    then
	echo -e "\nERROR: Variable for OPEN at line $g_COUNTER in file '$g_CURFILE' cannot be string!"
	exit 1
    fi

    # Determine target
    if [[ -n $g_FUNCNAME ]]
    then
	TARGET="$g_CFILE $g_HFILE"
    else
	TARGET=$g_HFILE
    fi

    touch $TARGET

    # Check if variable was declared
    if [[ "$HANDLE" != +(*.*) ]]
    then
	CHECK=`grep -E "DIR|FILE|int|long|float|double|char|void|STRING|NUMBER|FLOATING" $TARGET | grep -E " $HANDLE,| $HANDLE;|,$HANDLE,|,$HANDLE;| $HANDLE=| ${HANDLE%%\[*}\[|,${HANDLE%%\[*}\[" | grep -v " noparse "`
    fi

    # File or dir?
    if [[ $MODE = "DIRECTORY" ]]
    then
	if [[ -z $CHECK ]]
	then
	    echo "DIR *$HANDLE;" >> $g_HFILE
	fi
    elif [[ $MODE = "MEMORY" ]]
    then
	CHECK=`grep -E "char \*${HANDLE}" ${TARGET}`
	if [[ -z $CHECK ]]
	then
	    echo "char *$HANDLE;" >> $g_CFILE
	fi
	CHECK=`grep -E "long" $TARGET | grep "__b2c_mem_$HANDLE;" | grep -v " noparse "`
	if [[ -z $CHECK ]]
	then
	    echo "long __b2c_mem_$HANDLE;" >> $g_HFILE
	fi
    elif [[ $MODE = "NETWORK" || $MODE = "SERVER" ]]
    then
	if [[ -z $CHECK ]]
	then
	    echo "int $HANDLE;" >> $g_HFILE
	fi
    else
	if [[ -z $CHECK ]]
	then
	    echo "FILE* $HANDLE;" >> $g_HFILE
	fi
    fi

    # Convert to C syntax
    case $MODE in
	@(READING) )
	    echo "$HANDLE = fopen($FILE, \"r\");" >> $g_CFILE
	    echo "if($HANDLE == NULL){if(!__b2c__trap){ERROR = 2; if(!__b2c__catch_set) {fprintf(stderr, \"%s\n\", ERR${g_STRINGSIGN}(ERROR)); exit(ERROR);} if(!setjmp(__b2c__jump)) goto $g_CATCHGOTO;} }" >> $g_CFILE;;
	@(WRITING) )
	    echo "$HANDLE = fopen($FILE, \"w\");" >> $g_CFILE
	    echo "if($HANDLE == NULL){if(!__b2c__trap){ERROR = 2; if(!__b2c__catch_set) {fprintf(stderr, \"%s\n\", ERR${g_STRINGSIGN}(ERROR)); exit(ERROR);} if(!setjmp(__b2c__jump)) goto $g_CATCHGOTO;} }" >> $g_CFILE;;
	@(APPENDING) )
	    echo "$HANDLE = fopen($FILE, \"a\");" >> $g_CFILE
	    echo "if($HANDLE == NULL){if(!__b2c__trap){ERROR = 2; if(!__b2c__catch_set) {fprintf(stderr, \"%s\n\", ERR${g_STRINGSIGN}(ERROR)); exit(ERROR);} if(!setjmp(__b2c__jump)) goto $g_CATCHGOTO;} }" >> $g_CFILE;;
	@(READWRITE) )
	    echo "$HANDLE = fopen($FILE, \"r+\");" >> $g_CFILE
	    echo "if($HANDLE == NULL){if(!__b2c__trap){ERROR = 2; if(!__b2c__catch_set) {fprintf(stderr, \"%s\n\", ERR${g_STRINGSIGN}(ERROR)); exit(ERROR);} if(!setjmp(__b2c__jump)) goto $g_CATCHGOTO;} }" >> $g_CFILE;;
	@(DIRECTORY) )
	    echo "$HANDLE = opendir($FILE);" >> $g_CFILE
	    echo "if($HANDLE == NULL){if(!__b2c__trap){ERROR = 2; if(!__b2c__catch_set) {fprintf(stderr, \"%s\n\", ERR${g_STRINGSIGN}(ERROR)); exit(ERROR);} if(!setjmp(__b2c__jump)) goto $g_CATCHGOTO;} }" >> $g_CFILE;;
	@(MEMORY) )
	    echo "$HANDLE = (char*)$FILE; __b2c_mem_$HANDLE = $FILE;" >> $g_CFILE
	    echo "if(!__b2c__trap){__b2c__memory__check($HANDLE); if(ERROR) {if(!__b2c__catch_set){fprintf(stderr, \"%s\n\", ERR${g_STRINGSIGN}(ERROR)); exit(ERROR);} if(!setjmp(__b2c__jump)) goto $g_CATCHGOTO;} }" >> $g_CFILE;;
	@(NETWORK) )
	    # Network code
	    echo "if (strstr($FILE, \":\") == NULL) {ERROR = 10; fprintf(stderr, \"ERROR: %s: '%s'\n\", ERR${g_STRINGSIGN}(ERROR), ${FILE}); exit(ERROR);}" >> $g_CFILE
	    echo "strncpy(__b2c__data_client, $FILE, $g_BUFFER_SIZE); __b2c__host = strtok(__b2c__data_client, \":\"); __b2c__port = strtok(NULL, \":\"); __b2c__he = gethostbyname(__b2c__host);" >> $g_CFILE
	    echo "if (__b2c__he == NULL || __b2c__he->h_addr == NULL) {if(!__b2c__trap){ERROR = 11;if(!__b2c__catch_set){fprintf(stderr, \"%s\n\", ERR${g_STRINGSIGN}(ERROR)); exit(ERROR);} if(!setjmp(__b2c__jump)) goto $g_CATCHGOTO;} }" >> $g_CFILE
	    echo "$HANDLE = socket(PF_INET, SOCK_STREAM, 0);" >> $g_CFILE
	    echo "if ($HANDLE == -1) {if(!__b2c__trap){ERROR = 12;if(!__b2c__catch_set){fprintf(stderr, \"%s\n\", ERR${g_STRINGSIGN}(ERROR)); exit(ERROR);} if(!setjmp(__b2c__jump)) goto $g_CATCHGOTO;} }" >> $g_CFILE
	    echo "__b2c__to.tv_sec = $g_OPTION_SOCKET; __b2c__to.tv_usec = 0; setsockopt($HANDLE, SOL_SOCKET, SO_SNDTIMEO, &__b2c__to, sizeof(struct timeval));" >> $g_CFILE
	    echo "setsockopt($HANDLE, SOL_SOCKET, SO_REUSEADDR, &__b2c__yes, sizeof(int)); __b2c__addr.sin_family = AF_INET; __b2c__addr.sin_port = htons((long)atol(__b2c__port));" >> $g_CFILE
	    echo "__b2c__addr.sin_addr = *((struct in_addr *)__b2c__he->h_addr); memset(&(__b2c__addr.sin_zero), '\0', sizeof(__b2c__addr.sin_zero));" >> $g_CFILE
	    echo "__b2c__result = connect($HANDLE, (struct sockaddr *)&__b2c__addr, sizeof(struct sockaddr));" >> $g_CFILE
	    echo "if(__b2c__result == -1) {if(!__b2c__trap){ERROR = 13;if(!__b2c__catch_set){fprintf(stderr, \"%s\n\", ERR${g_STRINGSIGN}(ERROR)); exit(ERROR);} if(!setjmp(__b2c__jump)) goto $g_CATCHGOTO;} }" >> $g_CFILE;;
	@(SERVER) )
	    # Network code
	    echo "if (strstr($FILE, \":\") == NULL) {ERROR = 10; fprintf(stderr, \"ERROR: %s: '%s'\n\", ERR${g_STRINGSIGN}(ERROR), ${FILE}); exit(ERROR);}" >> $g_CFILE
	    echo "if(strcmp(__b2c__data_server, $FILE)) {strncpy(__b2c__data_server, $FILE, $g_BUFFER_SIZE); __b2c__host = strtok(__b2c__data_server, \":\"); __b2c__port = strtok(NULL, \":\"); __b2c__he = gethostbyname(__b2c__host);" >> $g_CFILE
	    echo "if (__b2c__he == NULL || __b2c__he->h_addr == NULL) {if(!__b2c__trap){ERROR = 11;if(!__b2c__catch_set){fprintf(stderr, \"%s\n\", ERR${g_STRINGSIGN}(ERROR)); exit(ERROR);} if(!setjmp(__b2c__jump)) goto $g_CATCHGOTO;} }" >> $g_CFILE
	    echo "__b2c__handle = socket(AF_INET, SOCK_STREAM, 0);" >> $g_CFILE
	    echo "if (__b2c__handle == -1) {if(!__b2c__trap){ERROR = 12;if(!__b2c__catch_set){fprintf(stderr, \"%s\n\", ERR${g_STRINGSIGN}(ERROR)); exit(ERROR);} if(!setjmp(__b2c__jump)) goto $g_CATCHGOTO;} }" >> $g_CFILE
	    echo "__b2c__to.tv_sec = $g_OPTION_SOCKET; __b2c__to.tv_usec = 0; setsockopt(__b2c__handle, SOL_SOCKET, SO_SNDTIMEO, &__b2c__to, sizeof(struct timeval));" >> $g_CFILE
	    echo "setsockopt(__b2c__handle, SOL_SOCKET, SO_REUSEADDR, &__b2c__yes, sizeof(int)); __b2c__addr.sin_family = AF_INET; __b2c__addr.sin_port = htons((long)atol(__b2c__port));" >> $g_CFILE
	    echo "__b2c__addr.sin_addr = *((struct in_addr *)__b2c__he->h_addr); memset(&(__b2c__addr.sin_zero), '\0', sizeof(__b2c__addr.sin_zero));" >> $g_CFILE
	    echo "__b2c__result = bind(__b2c__handle, (struct sockaddr *)&__b2c__addr, sizeof(struct sockaddr));" >> $g_CFILE
	    echo "if(__b2c__result == -1){if(!__b2c__trap){ERROR = 17;if(!__b2c__catch_set){fprintf(stderr, \"%s\n\", ERR${g_STRINGSIGN}(ERROR)); exit(ERROR);} if(!setjmp(__b2c__jump)) goto $g_CATCHGOTO;} }" >> $g_CFILE
	    echo "__b2c__result = listen(__b2c__handle, $g_MAX_BACKLOG);" >> $g_CFILE
	    echo "if(__b2c__result == -1){if(!__b2c__trap){ERROR = 18;if(!__b2c__catch_set){fprintf(stderr, \"%s\n\", ERR${g_STRINGSIGN}(ERROR)); exit(ERROR);} if(!setjmp(__b2c__jump)) goto $g_CATCHGOTO;} }" >> $g_CFILE
	    echo "strncpy(__b2c__data_server, $FILE, $g_BUFFER_SIZE); /* Restore data because of strtok */} __b2c__result = accept(__b2c__handle, NULL, 0);" >> $g_CFILE
	    echo "if(__b2c__result == -1){if(!__b2c__trap){ERROR = 19;if(!__b2c__catch_set){fprintf(stderr, \"%s\n\", ERR${g_STRINGSIGN}(ERROR)); exit(ERROR);} if(!setjmp(__b2c__jump)) goto $g_CATCHGOTO;} }" >> $g_CFILE
	    echo "$HANDLE= __b2c__result;" >> $g_CFILE;;
    esac
}

#-----------------------------------------------------------

function Handle_Readln
{
    # Local variables
    local CHECK VAR FROM TARGET STR

    # Check if FROM is available
    if [[ "$1" != +(* FROM *) ]]
    then
	echo -e "\nERROR: Missing FROM in READLN statement at line $g_COUNTER in file '$g_CURFILE'!"
	exit 1
    fi

    # Get the variablename without surrounding spaces
    VAR=`echo ${1%% FROM *}`

    # Get filedescriptor
    FROM=`echo ${1##* FROM }`

    # Check if var is string var
    if [[ "${VAR}" != +(*${g_STRINGSIGN}*) ]]
    then
	echo -e "\nERROR: Variable for READLN at line $g_COUNTER in file '$g_CURFILE' must be string!"
	exit 1
    fi

    # Determine target
    if [[ -n $g_FUNCNAME ]]
    then
	TARGET="$g_CFILE $g_HFILE"
    else
	TARGET=$g_HFILE
    fi

    touch $TARGET

    # Check if variable is declared
    if [[ ${VAR} != +(*\[*\]*) ]]
    then
	STR=${VAR%${g_STRINGSIGN}*}
	CHECK=`grep -E "char \*${STR}${g_STRINGSIGN} = NULL;" ${TARGET}`
	if [[ -z $CHECK ]]
	then
	    echo "char *$VAR = NULL;" >> $g_HFILE
	fi
    fi

    # Translate function to C function
    echo "__b2c__counter = 1; do{ memset(__b2c__input__buffer, '\0', $g_BUFFER_SIZE);" >> $g_CFILE
    echo "__b2c__assign = fgets(__b2c__input__buffer, $g_BUFFER_SIZE, $FROM);" >> $g_CFILE

    # Make sure internal var is copied to var of program
    echo "$VAR = (char*)realloc($VAR, ($g_BUFFER_SIZE+1)*__b2c__counter*sizeof(char));" >> $g_CFILE
    echo "if(__b2c__counter == 1) strncpy($VAR, __b2c__input__buffer, $g_BUFFER_SIZE);" >> $g_CFILE
    echo "else strncat($VAR, __b2c__input__buffer, $g_BUFFER_SIZE); __b2c__counter++;" >> $g_CFILE
    echo "} while (!strstr(__b2c__input__buffer, \"\n\") && strlen(__b2c__input__buffer));" >> $g_CFILE
    # Cut off last newline
    echo "if (strlen(__b2c__input__buffer)) $VAR[strlen($VAR)-1]='\0';" >> $g_CFILE
    # Cut off CR if available
    echo "if(strlen($VAR)>0 && $VAR[strlen($VAR)-1]=='\r') $VAR[strlen($VAR)-1]='\0';" >> $g_CFILE
}

#-----------------------------------------------------------

function Handle_Writeln
{
    # Local variables
    local VAR TO LINE LEN CHAR IN_STRING IN_FUNC ESCAPED

    # Check if TO is available
    if [[ "$1" != +(* TO *) ]]
    then
	echo -e "\nERROR: Missing TO in WRITELN statement at line $g_COUNTER in file '$g_CURFILE'!"
	exit 1
    fi

    # Get filedescriptor
    TO=`echo ${1##* TO }`

    # Start miniparser to see if we need to print something, convert spaces
    LINE=`echo "${1% TO *}" | tr " " "\001"`
    VAR=
    LEN=${#LINE}
    IN_STRING=0

    # Get the characters
    until [[ $LEN -eq 0 ]]
    do
	CHAR="${LINE:0:1}"
	case $CHAR in
	    ",")
		if [[ $IN_STRING -eq 0 && $IN_FUNC -eq 0 ]]
		then
		    # Check if var is string var
		    if [[ "${VAR%%\(*}" = +(*${g_STRINGSIGN}*) || "${VAR%%\(*}" = +(*${g_DQUOTESIGN}*) ]]
		    then
			echo "fprintf($TO, \"%s\", ${VAR});" >> $g_CFILE
		    else
			echo "fprintf($TO, \"%s\", STR${g_STRINGSIGN}(${VAR}));" >> $g_CFILE
		    fi
		    VAR=
		    CHAR=
		    ESCAPED=0
		fi;;
	    "\\")
		ESCAPED=1;;
	    "\"")
		if [[ $ESCAPED -eq 0 ]]
		then
		    if [[ $IN_STRING -eq 0 ]]
		    then
			IN_STRING=1
		    else
			IN_STRING=0
		    fi
		fi
		ESCAPED=0;;
	    "(")
		if [[ $IN_STRING -eq 0 ]]
		then
		    ((IN_FUNC=$IN_FUNC+1))
		fi
		ESCAPED=0;;
	    ")")
		if [[ $IN_STRING -eq 0 ]]
		then
		    ((IN_FUNC=$IN_FUNC-1))
		fi
		ESCAPED=0;;
	    *)
		ESCAPED=0;;
	esac
	# Convert back to space
	if [[ "${CHAR}" = "${g_PARSEVAR}" ]]
	then
	    VAR="${VAR} "
	else
	    VAR="${VAR}${CHAR}"
	fi
	let LEN=${#LINE}-1
	LINE="${LINE: -$LEN}"
    done

    # Write last element to file
    if [[ "${VAR%%\(*}" = +(*${g_STRINGSIGN}*) || "${VAR%%\(*}" = +(*${g_DQUOTESIGN}*) ]]
    then
	echo "fprintf($TO, \"%s\n\", ${VAR});" >> $g_CFILE
    else
	echo "fprintf($TO, \"%s\n\", STR${g_STRINGSIGN}(${VAR}));" >> $g_CFILE
    fi
    echo "fflush($TO);" >> $g_CFILE
}

#-----------------------------------------------------------

function Handle_Getbyte
{
    # Local variables
    local POS FROM SIZE TARGET CHECK

    # Check if FROM is available
    if [[ "$1" != +(* FROM *) ]]
    then
	echo -e "\nERROR: Missing FROM in GETBYTE statement at line $g_COUNTER in file '$g_CURFILE'!"
	exit 1
    fi

    # Get the variablename without surrounding spaces
    POS=`echo ${1%% FROM *}`

    # Get filedescriptor
    FROM=`echo ${1##* FROM }`

    SIZE=

    # Check if SIZE is available
    if [[ "$1" = +(* SIZE *) ]]
    then
	SIZE=${FROM##* SIZE }
	FROM=${FROM%% SIZE *}
    else
	SIZE=1
    fi

    # Determine target
    if [[ -n $g_FUNCNAME ]]
    then
	TARGET="$g_CFILE $g_HFILE"
    else
	TARGET=$g_HFILE
    fi

    touch $TARGET

    # Declare variable if not done yet, assuming long
    if [[ "$POS" != +(*.*) ]]
    then
	CHECK=`grep -E "DIR|FILE|int|long|float|double|char|void|STRING|NUMBER|FLOATING" $TARGET | grep -E " $POS,| $POS;|,$POS,|,$POS;| $POS=| ${POS%%\[*}\[|,${POS%%\[*}\[" | grep -v " noparse "`
	if [[ -z $CHECK ]]
	then
	    echo "long $POS;" >> $g_HFILE
	fi
    fi

    # Translate function to C function
    echo "if(!__b2c__trap){__b2c__memory__check((char *)$POS); if(ERROR) {if(!__b2c__catch_set){fprintf(stderr, \"%s\n\", ERR${g_STRINGSIGN}(ERROR)); exit(ERROR);} if(!setjmp(__b2c__jump)) goto $g_CATCHGOTO;} }" >> $g_CFILE
    echo "__b2c__counter = fread((void*)$POS, sizeof($g_OPTION_MEMTYPE), $SIZE, $FROM);" >> $g_CFILE
}

#-----------------------------------------------------------

function Handle_Putbyte
{
    # Local variables
    local VAR TO SIZE POS

    # Check if TO is available
    if [[ "$1" != +(* TO *) ]]
    then
	echo -e "\nERROR: Missing TO in PUTBYTE statement at line $g_COUNTER in file '$g_CURFILE'!"
	exit 1
    fi

    # Get the variablename without surrounding spaces
    POS=`echo ${1%% TO *}`;

    # Get filedescriptor
    TO=`echo ${1##* TO }`

    SIZE=

    # Check if SIZE is available
    if [[ "$1" = +(* SIZE *) ]]
    then
	SIZE=${TO##* SIZE }
	TO=${TO%% SIZE *}
    else
	SIZE=1
    fi

    # Translate function to C function
    echo "if(!__b2c__trap){__b2c__memory__check((char *)$POS); if(ERROR){if(!__b2c__catch_set){fprintf(stderr, \"%s\n\", ERR${g_STRINGSIGN}(ERROR)); exit(ERROR);} if(!setjmp(__b2c__jump)) goto $g_CATCHGOTO;} }" >> $g_CFILE
    echo "__b2c__counter = fwrite((void*)$POS, sizeof($g_OPTION_MEMTYPE), $SIZE, $TO);" >> $g_CFILE
}

#-----------------------------------------------------------

function Handle_Getfile
{
    # Local variables
    local VAR FROM SIZE TARGET STR

    # Check if FROM is available
    if [[ "$1" != +(* FROM *) ]]
    then
	echo -e "\nERROR: Missing FROM in GETFILE statement at line $g_COUNTER in file '$g_CURFILE'!"
	exit 1
    fi

    # Get the variablename without surrounding spaces
    VAR=`echo ${1%% FROM *}`

    # Get dirdescriptor
    FROM=`echo ${1##* FROM }`

    # Determine target
    if [[ -n $g_FUNCNAME ]]
    then
	TARGET="$g_CFILE $g_HFILE"
    else
	TARGET=$g_HFILE
    fi

    touch $TARGET

    # Translate function to C function
    echo "__b2c__dir = readdir($FROM);" >> $g_CFILE

    # Check if variable is declared
    STR=${VAR%${g_STRINGSIGN}*}
    CHECK=`grep -E "char \*${STR}${g_STRINGSIGN} = NULL;" ${TARGET}`
    if [[ -z $CHECK && "$VAR" != +(*\[*\]*) && "$VAR" != +(*.*) ]]
    then
	echo "char *$VAR = NULL;" >> $g_HFILE
    fi

    # Always realloc VAR to correct size, maybe it was resized somewhere else
    echo "if(__b2c__dir != NULL) {$VAR = realloc($VAR, (strlen(__b2c__dir->d_name)+1)*sizeof(char));" >> $g_CFILE
    # Make sure internal var is copied to var of program
    echo "strcpy($VAR, __b2c__dir->d_name); $VAR[strlen(__b2c__dir->d_name)] = '\0';}" >> $g_CFILE
    echo "else {$VAR = realloc($VAR, sizeof(char)); $VAR[0] = '\0';}" >> $g_CFILE
}

#-----------------------------------------------------------

function Handle_Receive
{
    # Local variables
    local CHECK VAR FROM TARGET STR CHUNK SIZE

    # Check if FROM is available
    if [[ "$1" != +(* FROM *) ]]
    then
	echo -e "\nERROR: Missing FROM in RECEIVE statement at line $g_COUNTER in file '$g_CURFILE'!"
	exit 1
    fi

    # Get the variablename without surrounding spaces
    VAR=`echo ${1%% FROM *}`

    # Get filedescriptor
    FROM=`echo ${1##* FROM }`

    # Check for optional chunksize
    if [[ $FROM = +(* CHUNK *) ]]
    then
	CHUNK=${FROM##* CHUNK }
	FROM=${FROM%% CHUNK *}
    else
	CHUNK=$g_BUFFER_SIZE
	SIZE=
    fi

    # Check for optional return variable
    if [[ $CHUNK = +(* SIZE *) ]]
    then
	SIZE=${CHUNK##* SIZE }
	CHUNK=${CHUNK%% SIZE *}
    else
	SIZE=
    fi

    # Determine target
    if [[ -n $g_FUNCNAME ]]
    then
	TARGET="$g_CFILE $g_HFILE"
    else
	TARGET=$g_HFILE
    fi

    touch $TARGET

    # Variable may not be array, these should be defined with DECLARE
    if [[ -n $SIZE && "$SIZE" != +(*\[*\]*) && "$SIZE" != +(*.*) ]]
    then
	# Declare variable if not done yet, assuming long
	CHECK=`grep -E "DIR|FILE|int|long|float|double|char|void|STRING|NUMBER|FLOATING" $TARGET | grep -E " $SIZE,| $SIZE;|,$SIZE,|,$SIZE;| $SIZE=| ${SIZE%%\[*}\[|,${SIZE%%\[*}\[" | grep -v " noparse "`
	if [[ -z $CHECK ]]
	then
	    echo "long $SIZE;" >> $g_HFILE
	fi
    fi

    # Check if string variable, and if so, if declared
    if [[ "${VAR}" = +(*${g_STRINGSIGN}) ]]
    then
	STR=${VAR%${g_STRINGSIGN}*}
	CHECK=`grep -E "char \*${STR}${g_STRINGSIGN} = NULL;" ${TARGET}`
	if [[ -z $CHECK ]]
	then
	    echo "char *$VAR = NULL;" >> $g_HFILE
	fi
	echo "$VAR = (char*)realloc($VAR, ($CHUNK+1)*sizeof(char)); memset($VAR, '\0', sizeof(char)*($CHUNK+1));" >> $g_CFILE
    fi

    # Translate function to C function
    if [[ -z $SIZE ]]
    then
	echo "if(recv($FROM, (void*)$VAR, $CHUNK, 0) < 0) {if(!__b2c__trap){ERROR = 14;if(!__b2c__catch_set)" >> $g_CFILE
	echo "{fprintf(stderr, \"%s\n\", ERR${g_STRINGSIGN}(ERROR)); exit(ERROR);} if(!setjmp(__b2c__jump)) goto $g_CATCHGOTO;} }" >> $g_CFILE
    else
	echo "if(($SIZE = recv($FROM, (void*)$VAR, $CHUNK, 0)) < 0) {if(!__b2c__trap){ERROR = 14;if(!__b2c__catch_set)" >> $g_CFILE
	echo "{fprintf(stderr, \"%s\n\", ERR${g_STRINGSIGN}(ERROR)); exit(ERROR);} if(!setjmp(__b2c__jump)) goto $g_CATCHGOTO;} }" >> $g_CFILE
    fi
}
#-----------------------------------------------------------

function Handle_Send
{
    # Local variables
    local VAR TO CHUNK

    # Check if TO is available
    if [[ "$1" != +(* TO *) ]]
    then
	echo -e "\nERROR: Missing TO in SEND statement at line $g_COUNTER in file '$g_CURFILE'!"
	exit 1
    fi

    # Get the variablename without surrounding spaces
    VAR=`echo ${1%% TO *}`;

    # Get filedescriptor
    TO=`echo ${1##* TO }`

   # Check for optional chunksize
    if [[ $TO = +(* CHUNK *) ]]
    then
	CHUNK=${TO##* CHUNK }
	TO=${TO%% CHUNK *}
    else
	CHUNK="strlen($VAR)"
    fi

    # Translate function to C function
    echo "if(send($TO, (void*)$VAR, $CHUNK, 0) < 0) {if(!__b2c__trap){ERROR = 15; if(!__b2c__catch_set){fprintf(stderr, \"%s\n\", ERR${g_STRINGSIGN}(ERROR)); exit(ERROR);} if(!setjmp(__b2c__jump)) goto $g_CATCHGOTO;} }" >> $g_CFILE
}

#-----------------------------------------------------------

function Handle_Getline
{
    # Local variables
    local CHECK VAR FROM TARGET STR

    # Check if FROM is available
    if [[ "$1" != +(* FROM *) ]]
    then
	echo -e "\nERROR: Missing FROM in GETLINE statement at line $g_COUNTER in file '$g_CURFILE'!"
	exit 1
    fi

    # Get the variablename without surrounding spaces
    VAR=`echo ${1%% FROM *}`

    # Get filedescriptor
    FROM=`echo ${1##* FROM }`

    # Check if var is string var
    if [[ "${VAR}" != +(*${g_STRINGSIGN}*) ]]
    then
	echo -e "\nERROR: Variable for GETLINE at line $g_COUNTER in file '$g_CURFILE' must be string!"
	exit 1
    fi

    # Determine target
    if [[ -n $g_FUNCNAME ]]
    then
	TARGET="$g_CFILE $g_HFILE"
    else
	TARGET=$g_HFILE
    fi

    touch $TARGET

    # Check if variable is declared
    if [[ ${VAR} != +(*\[*\]*) ]]
    then
	STR=${VAR%${g_STRINGSIGN}*}
	CHECK=`grep -E "char \*${STR}${g_STRINGSIGN} = NULL;" ${TARGET}`
	if [[ -z $CHECK ]]
	then
	    echo "char *$VAR = NULL;" >> $g_HFILE
	fi
    fi

    # Translate function to C function
    echo "if ($FROM == NULL || *$FROM == '\0') {$VAR = (char*)realloc($VAR, 2*sizeof(char)); strcpy($VAR, \"\");}" >> $g_CFILE
    echo "else { __b2c__assign = $FROM; while(*$FROM != '\0' && *$FROM != '\n') $FROM++;" >> $g_CFILE

    # Make sure internal var is copied to var of program
    echo "$VAR = (char*)realloc($VAR, ($FROM-__b2c__assign+1)*sizeof(char));" >> $g_CFILE
    echo "strncpy($VAR, __b2c__assign, $FROM-__b2c__assign);" >> $g_CFILE

    # Make sure to end the string
    echo "$VAR[($FROM-__b2c__assign)] = '\0'; $FROM++;}" >> $g_CFILE
}

#-----------------------------------------------------------

function Handle_Putline
{
    # Local variables
    local VAR TO LINE LEN CHAR IN_STRING IN_FUNC

    # Check if TO is available
    if [[ "$1" != +(* TO *) ]]
    then
	echo -e "\nERROR: Missing TO in PUTLINE statement at line $g_COUNTER in file '$g_CURFILE'!"
	exit 1
    fi

    # Get memorydescriptor
    TO=`echo ${1##* TO }`

    # Start miniparser to see if we need to print something, convert spaces
    LINE=`echo "${1%% TO *}" | tr " " "\001"`
    VAR=
    LEN=${#LINE}
    IN_STRING=0

    # Get the characters
    until [[ $LEN -eq 0 ]]
    do
	CHAR="${LINE:0:1}"
	case $CHAR in
	    ",")
		if [[ $IN_STRING -eq 0 && $IN_FUNC -eq 0 ]]
		then
		    # Check if var is string var
		    if [[ "${VAR%%\(*}" = +(*${g_STRINGSIGN}*) || "${VAR%%\(*}" = +(*${g_DQUOTESIGN}*) ]]
		    then
			echo "strcat($TO, $VAR); $TO+=strlen($VAR);" >> $g_CFILE
		    else
			echo "strcat($TO, STR${g_STRINGSIGN}($VAR)); $TO+=strlen(STR${g_STRINGSIGN}($VAR));" >> $g_CFILE
		    fi
		    VAR=
		    CHAR=
		    ESCAPED=0
		fi;;
	    "\\")
		ESCAPED=1;;
	    "\"")
		if [[ $ESCAPED -eq 0 ]]
		then
		    if [[ $IN_STRING -eq 0 ]]
		    then
			IN_STRING=1
		    else
			IN_STRING=0
		    fi
		fi
		ESCAPED=0;;
	    "(")
		if [[ $IN_STRING -eq 0 ]]
		then
		    ((IN_FUNC=$IN_FUNC+1))
		fi
		ESCAPED=0;;
	    ")")
		if [[ $IN_STRING -eq 0 ]]
		then
		    ((IN_FUNC=$IN_FUNC-1))
		fi
		ESCAPED=0;;
	    *)
		ESCAPED=0;;
	esac
	# Convert back to space
	if [[ "${CHAR}" = "${g_PARSEVAR}" ]]
	then
	    VAR="${VAR} "
	else
	    VAR="${VAR}${CHAR}"
	fi
	let LEN=${#LINE}-1
	LINE="${LINE: -$LEN}"
    done

    # Check if var is string var
    if [[ "${VAR%%\(*}" = +(*${g_STRINGSIGN}*) || "${VAR%%\(*}" = +(*${g_DQUOTESIGN}*) ]]
    then
	echo "strcat($TO, $VAR); strcat($TO, \"\n\"); $TO+=strlen($VAR)+1;" >> $g_CFILE
    else
	echo "strcat($TO, STR${g_STRINGSIGN}($VAR)); strcat($TO, \"\n\"); $TO+=strlen(STR${g_STRINGSIGN}($VAR))+1;" >> $g_CFILE
    fi
}

#-----------------------------------------------------------

function Handle_Import
{
    # Local variables
    local TMP SYM LIB CHECK TOKEN PTR TYPE ALIAS

    # Check if FROM is available
    if [[ "$1" != +(* FROM *) ]]
    then
	echo -e "\nERROR: missing FROM in IMPORT statement at line $g_COUNTER in file '$g_CURFILE'!"
	exit 1
    fi

    # Get the symbolname without surrounding spaces and doublequotes
    if [[ "$1" = +(*\(*) ]]
    then
	SYM=`echo ${1%%\(*} | tr -d "\042"`; TMP=${1#* FROM }
	TOKEN=`echo ${1%\)*}`
    else
	SYM=`echo ${1%% FROM *} | tr -d "\042"`; TMP=${1#* FROM }
	TOKEN=
    fi

    # Check if TYPE is available
    if [[ "$1" != +(* TYPE *) ]]
    then
	echo -e "\nERROR: missing TYPE in IMPORT statement at line $g_COUNTER in file '$g_CURFILE'!"
	exit 1
    fi

    # Get library and type
    LIB=`echo ${TMP%% TYPE *}`
    TYPE=`echo ${TMP##* TYPE }`

    # Check if ALIAS is there
    if [[ $TYPE = +(* ALIAS *) ]]
    then
	ALIAS=`echo ${TYPE##* ALIAS } | tr -d "\042"`
	echo "#define $ALIAS $SYM" >> $g_HFILE
	g_IMPORTED="$ALIAS $g_IMPORTED"
	TYPE=${TYPE%% ALIAS *}
    fi

    # If library is libm or libc, skip dlopen as we're linking with those anyway
    if [[ $LIB != +(*libc.so*) && $LIB != +(*libm.so*) ]]
    then
	# Create name from libname
	PTR=`echo $LIB | tr -d [:punct:]`

	# Check if variable was declared
	CHECK=`grep -i "void\* __b2c__dlopen__pointer_$PTR;" $g_CFILE`
	if [[ -z $CHECK ]]
	then
	    echo "void* __b2c__dlopen__pointer_$PTR;" >> $g_CFILE
	    echo "__b2c__dlopen__pointer_$PTR = dlopen($LIB, RTLD_LAZY);" >> $g_CFILE
	fi
	echo "if(__b2c__dlopen__pointer_$PTR == NULL){if(!__b2c__trap){ERROR = 3;if(!__b2c__catch_set){fprintf(stderr, \"%s\n\", ERR${g_STRINGSIGN}(ERROR)); exit(ERROR);} if(!setjmp(__b2c__jump)) goto $g_CATCHGOTO;} }" >> $g_CFILE

	# Check if token was declared
	CHECK=`grep -i "$TYPE (\*$SYM)" $g_HFILE`
	if [[ -z $CHECK ]]
	then
	    echo "$TYPE (*$SYM)(${TOKEN#*\(});" >> $g_HFILE
	fi

	# Translate to C function
	echo "*($TYPE **) (&$SYM) = dlsym(__b2c__dlopen__pointer_$PTR, \"$SYM\");" >> $g_CFILE
	echo "if($SYM == NULL) {if(!__b2c__trap){ERROR = 4;if(!__b2c__catch_set){fprintf(stderr, \"%s\n\", ERR${g_STRINGSIGN}(ERROR)); exit(ERROR);} if(!setjmp(__b2c__jump)) goto $g_CATCHGOTO;} }" >> $g_CFILE
    fi

    # Make symbol known to parser
    g_IMPORTED="$SYM $g_IMPORTED"
}

#-----------------------------------------------------------

function Handle_Declare
{
    # Local variables
    local VAR TYPE CHECK NEW VALUE OPTION

    #  Check on a GLOBAL RECORD
    if [[ "$1" = +(*RECORD *) ]]
    then
	# Translate to C typedef struct
	g_RECORDNAME="RECORD_${g_COUNTER}"
	echo "struct $g_RECORDNAME{" >> $g_HFILE
	g_RECORDVAR=${1#* }
	# Store current function name
	if [[ -n $g_FUNCNAME ]]
	then
	    g_RECORDCACHE=$g_FUNCNAME
	    g_FUNCNAME=
	fi
    else
	# Get the variablename and type
	if [[ "$1" = +(* TYPE *) ]]
	then
	    VAR=`echo ${1%% TYPE *} | tr -d " "`
	    TYPE=`echo ${1##* TYPE }`
	elif [[ "$1" = +(* ASSOC *) ]]
	then
	    VAR=`echo ${1%% ASSOC *} | tr -d " "`
	    TYPE=`echo ${1##* ASSOC }`
	else
	    VAR=`echo ${1} | tr -d " "`
	    TYPE="long"
	fi

	# Check if variable was already declared
	if [[ "$VAR" != +(*.*) ]]
	then
            VALUE=${VAR%%\[*}
	    CHECK=`grep -E "DIR|FILE|int|long|float|double|char|void|STRING|NUMBER|FLOATING" $g_HFILE | grep -E " $VALUE,| $VALUE;|,$VALUE,|,$VALUE;| $VALUE=| $VALUE\[|,$VALUE\[" | grep -v " noparse "`
	fi

	if [[ -n $CHECK ]]
	then
	    echo -e "\nERROR: variable in DECLARE or GLOBAL statement at line $g_COUNTER in file '$g_CURFILE' was defined previously!"
	    exit 1
	fi

	# If array, increase dimensions when OPTION BASE is set
	if [[ $VAR = +(*\[*\]*) && $VAR != +(*=*) ]]
	then
	    NEW=
	    while [[ ${VAR} = +(*\[*\]*) ]]
	    do
		NEW="$NEW${VAR%%\[*}["
		VALUE=${VAR#*\[}
		NEW="$NEW${VALUE%%\]*}+$g_OPTION_BASE]"
		VAR=${VAR#*\]}
	    done
	    VAR="${NEW}"
	fi

	# Check for associative array
	if [[ "${1}" = +(* ASSOC *) ]]
	then
	    VAR=`echo "$VAR" | tr "," " "`
	    for i in $VAR
	    do
		echo "struct __b2c__${i}_type {char *key; /* noparse */ ${TYPE} value; /* noparse */ };" >> $g_HFILE
		echo "struct __b2c__${i}_type *__b2c__${i} = { NULL }; long __b2c__${i}_idx = 0;" >> $g_HFILE

		echo "static int __b2c__${i}_comp(const void *__b2c__m1, const void *__b2c__m2){ " >> $g_HFILE
		echo "struct __b2c__${i}_type *__b2c__mi1 = (struct __b2c__${i}_type *) __b2c__m1;" >> $g_HFILE
		echo "struct __b2c__${i}_type *__b2c__mi2 = (struct __b2c__${i}_type *) __b2c__m2;" >> $g_HFILE
		echo "if(__b2c__mi1->key == NULL && __b2c__mi2->key == NULL) return 0;" >> $g_HFILE
		echo "if(__b2c__mi1->key == NULL && __b2c__mi2->key != NULL) return -1;" >> $g_HFILE
		echo "if(__b2c__mi1->key != NULL && __b2c__mi2->key == NULL) return 1;" >> $g_HFILE
		echo "return strcmp(__b2c__mi1->key, __b2c__mi2->key); }" >> $g_HFILE

		echo "struct __b2c__${i}_type * __b2c__${i}_exist(char *__b2c__index){struct __b2c__${i}_type __b2c__${i}_key, *__b2c__${i}__result;" >> $g_HFILE
		echo "qsort(__b2c__${i}, __b2c__${i}_idx, sizeof(struct __b2c__${i}_type), __b2c__${i}_comp);" >> $g_HFILE
		echo "__b2c__${i}_key.key = __b2c__index; __b2c__${i}__result = bsearch(&__b2c__${i}_key, __b2c__${i}," >> $g_HFILE
		echo "__b2c__${i}_idx, sizeof(struct __b2c__${i}_type), __b2c__${i}_comp);" >> $g_HFILE
		echo "return(__b2c__${i}__result); }" >> $g_HFILE

		echo "void __b2c__${i}__add(char *__b2c__index){__b2c__${i}_idx++;" >> $g_HFILE
		echo "__b2c__${i} = (struct __b2c__${i}_type *) realloc (__b2c__${i}, __b2c__${i}_idx * sizeof (struct __b2c__${i}_type));" >> $g_HFILE
		echo "__b2c__${i}[__b2c__${i}_idx - 1].key = strdup (__b2c__index); __b2c__${i}[__b2c__${i}_idx-1].value = 0;}" >> $g_HFILE

		echo "void __b2c__${i}__del(char *__b2c__index){struct __b2c__${i}_type *__b2c__${i}__location = __b2c__${i}_exist(__b2c__index);" >> $g_HFILE
		echo "if(__b2c__${i}__location != NULL) {free(__b2c__${i}__location->key); __b2c__${i}__location->key = NULL; } }" >> $g_HFILE

		echo "${TYPE} ${i}(char *__b2c__index){struct __b2c__${i}_type __b2c__${i}_key, *__b2c__${i}__result;" >> $g_HFILE
		echo "qsort(__b2c__${i}, __b2c__${i}_idx, sizeof(struct __b2c__${i}_type), __b2c__${i}_comp);" >> $g_HFILE
		echo "__b2c__${i}_key.key = __b2c__index; __b2c__${i}__result = bsearch(&__b2c__${i}_key, __b2c__${i}," >> $g_HFILE
		echo "__b2c__${i}_idx, sizeof(struct __b2c__${i}_type), __b2c__${i}_comp);" >> $g_HFILE
		if [[ ${i} = +(*${g_STRINGSIGN}*) || ${TYPE} = +(*STRING*) || ${TYPE} = +(*char\**) ]]
		then
		    echo "if(__b2c__${i}__result == NULL) return(\"\"); return __b2c__${i}__result->value;}" >> $g_HFILE
		else
		    echo "if(__b2c__${i}__result == NULL) return(0); return __b2c__${i}__result->value;}" >> $g_HFILE
		fi
	    done

	# Check if var is string var
	elif [[ ( "${VAR}" = +(*${g_STRINGSIGN}*) || "${TYPE}" = +(*STRING*|*char\**) ) && "${VAR}" != +(*=*) ]]
	then
	    CHECK=`grep -E "char \*${STR} = NULL;" $g_HFILE`
	    if [[ -z $CHECK ]]
	    then
		STR=`echo ${VAR} | tr ',' ' '`
		for i in $STR
		do
		    if [[ "${i}" = +(*\[*\]*) ]]
		    then
			echo "char *$i = { NULL };" >> $g_HFILE
		    else
			echo "char *$i = NULL;" >> $g_HFILE
			# Pointer var should not be initialized
			if [[ "${VAR}" = +(*${g_STRINGSIGN}*) ]]
			then
			    echo "$i = calloc(1, sizeof(char));" >> $g_CFILE
			fi
		    fi
		done
	    fi
        # Var is string array assignment
	elif [[ ( "${VAR}" = +(*${g_STRINGSIGN}*) || "${TYPE}" = +(*STRING*|*char\**) ) && "${VAR}" = +(*=*) ]]
        then
            echo "char* ${VAR%%\{*} {" >> $g_HFILE
            OPTION=$g_OPTION_BASE
            while [[ ${OPTION} -gt 0 ]]
            do
                echo " \"\", " >> $g_HFILE
                ((OPTION-=1))
            done
	    echo "${VAR#*\{};" >> $g_HFILE
	# Assume char assignment or number
	else
	    if [[ "$VAR" = +(*\[*\]*) && "$VAR" != +(*=*) ]]
	    then
		VAR=`echo ${VAR} | tr "," " "`
		for i in $VAR
		do
		    echo "$TYPE $i = { 0 };" >> $g_HFILE
		done
	    elif [[ "$VAR" = +(*\[*\]*) && "$VAR" = +(*=*) ]]
            then
                echo "$TYPE ${VAR%%\{*} {" >> $g_HFILE
                OPTION=$g_OPTION_BASE
                while [[ ${OPTION} -gt 0 ]]
                do
                    echo " 0, " >> $g_HFILE
                    ((OPTION-=1))
                done
	        echo "${VAR#*\{};" >> $g_HFILE
	    elif [[ "$VAR" != +(*=*) && "$VAR" != +(*\(*\)*) && "${TYPE}" = +(*char*|*short*|*int*|*long*|*double*|*float*|*NUMBER*|*FLOATING*) ]]
	    then
		echo "$TYPE $VAR;" >> $g_HFILE
		echo "$VAR = 0;" | tr "," "=" >> $g_CFILE
	    else
		echo "$TYPE $VAR;" >> $g_HFILE
            fi
	fi
    fi
}

#-----------------------------------------------------------

function Handle_Local
{
    # Local variables
    local VAR TYPE CHECK TARGET DIM NEW VALUE i OPTION

    # Get the variablename and type
    if [[ "$1" = +(* TYPE *) ]]
    then
	VAR=`echo ${1%% TYPE *} | tr -d " "`
	TYPE=`echo ${1##* TYPE }`
    else
	VAR=`echo ${1} | tr -d " "`
	if [[ "${VAR}" = +(*${g_STRINGSIGN}*) ]]
	then
	    TYPE="char*"
	else
	    TYPE="long"
	fi
    fi

    # Determine target
    if [[ -n $g_FUNCNAME ]]
    then
	TARGET=$g_CFILE
    else
	TARGET=$g_HFILE
    fi

    touch $TARGET

    # Check if variable was already declared
    if [[ "$VAR" != +(*.*) ]]
    then
        VALUE=${VAR%%\[*}
	CHECK=`grep -E "DIR|FILE|int|long|float|double|char|void|STRING|NUMBER|FLOATING" $TARGET | grep -E " $VALUE,| $VALUE;|,$VALUE,|,$VALUE;| $VALUE=| $VALUE\[|,$VALUE\[" | grep -v " noparse "`
    fi

    if [[ -n $CHECK ]]
    then
	echo -e "\nERROR: variable in LOCAL statement at line $g_COUNTER in file '$g_CURFILE' was defined previously!"
	exit 1
    fi

    # If array, increase dimensions when OPTION BASE is set
    if [[ $VAR = +(*\[*\]*) && $VAR != +(*=*) ]]
    then
	NEW=
	while [[ ${VAR} = +(*\[*\]*) ]]
	do
	    NEW="$NEW${VAR%%\[*}["
	    VALUE=${VAR#*\[}
	    NEW="$NEW${VALUE%%\]*}+$g_OPTION_BASE]"
	    VAR=${VAR#*\]}
        done
	VAR="${NEW}"
    fi

    # Check if var is string var
    if [[ ( "${TYPE}" = +(*STRING*|*char\*) || "${VAR}" = +(*${g_STRINGSIGN}*) ) && "${VAR}" != +(*=*) && "${VAR}" != +(*\[*${g_STRINGSIGN}*\]*) ]]
    then
	STR=${VAR%${g_STRINGSIGN}*}
	CHECK=`grep -E "char \*${STR}${g_STRINGSIGN} = " ${TARGET}`
	if [[ -z $CHECK ]]
	then
	    STR=`echo ${VAR} | tr ',' ' '`
	    for i in $STR
	    do
		# Check on multidimensional stringarrays
		if [[ "${i}" = +(*\[*\]*\]*) ]]
		then
		    echo -e "\nERROR: multidimensional stringarrays at line $g_COUNTER in file '$g_CURFILE' are not supported!"
		    exit 1
		fi
		# Are we in a function?
		if [[ -n $g_FUNCNAME ]]
		then
		    if [[ -n $g_RECORDNAME ]]
		    then
			if [[ "${i}" = +(*\[*\]*) ]]
			then
			    echo "char *$i;" >> $g_CFILE
			    DIM=${i##*\[}; DIM=${DIM%%\]*}
			    g_STRINGARRAYS="$g_STRINGARRAYS for(__b2c__ctr=0; __b2c__ctr<$DIM; __b2c__ctr++)if($g_RECORDVAR.${i%%\[*}[__b2c__ctr]!=NULL){free($g_RECORDVAR.${i%%\[*}[__b2c__ctr]);}"
			else
			    echo "char *$i; /* noparse */" >> $g_CFILE
			fi
		    else
			if [[ "${i}" = +(*\[*\]*) ]]
			then
			    echo "char *$i = { NULL };" >> $g_CFILE
			    DIM=${i##*\[}; DIM=${DIM%%\]*}
			    g_STRINGARRAYS="$g_STRINGARRAYS for(__b2c__ctr=0; __b2c__ctr<$DIM; __b2c__ctr++)if(${g_WITHVAR}${i%%\[*}[__b2c__ctr]!=NULL){free(${g_WITHVAR}${i%%\[*}[__b2c__ctr]);}"
			else
			    echo "char *$i = NULL;" >> $g_CFILE
			    # Pointer var should not be initialized
			    if [[ "${VAR}" = +(*${g_STRINGSIGN}*) ]]
			    then
				echo "$i = calloc(1, sizeof(char));" >> $g_CFILE
				g_LOCALSTRINGS="$g_LOCALSTRINGS ${i}"
			    fi
			fi
		    fi
		# We are in the mainprogram
		else
		    if [[ -n $g_RECORDNAME ]]
		    then
			echo "char *$i; /* noparse */" >> $g_HFILE
		    else
			if [[ "${i}" = +(*\[*\]*) ]]
			then
			    echo "char *$i = { NULL };" >> $g_CFILE
			else
			    echo "char *$i = NULL;" >> $g_HFILE
			    # Pointer var should not be initialized
			    if [[ "${VAR}" = +(*${g_STRINGSIGN}*) ]]
			    then
				echo "$i = calloc(1, sizeof(char));" >> $g_CFILE
			    fi
			fi
		    fi
		fi
	    done
	fi
    elif [[ ( "${VAR}" = +(*${g_STRINGSIGN}*) || "${TYPE}" = +(*STRING*|*char\**) ) && "${VAR}" = +(*=*) ]]
    then
        if [[ -n $g_FUNCNAME ]]
	then
            # String array assignment
            echo "char* ${VAR%%\{*} {" >> $g_CFILE
            OPTION=$g_OPTION_BASE
            while [[ ${OPTION} -gt 0 ]]
            do
                echo " \"\", " >> $g_CFILE
                ((OPTION-=1))
            done
	    echo "${VAR#*\{};" >> $g_CFILE
        else
            # String array assignment
            echo "char* ${VAR%%\{*} {" >> $g_HFILE
            OPTION=$g_OPTION_BASE
            while [[ ${OPTION} -gt 0 ]]
            do
                echo " \"\", " >> $g_HFILE
                ((OPTION-=1))
            done
	    echo "${VAR#*\{};" >> $g_HFILE
        fi
    # Assume number
    else
	if [[ -n $g_FUNCNAME ]]
	then
	    if [[ -n $g_RECORDNAME ]]
	    then
		echo "$TYPE $VAR; /* noparse */" >> $g_CFILE
	    else
		if [[ "$VAR" = +(*\[*\]*) && "$VAR" != +(*=*) ]]
		then
		    VAR=`echo ${VAR} | tr "," " "`
		    for i in $VAR
		    do
			echo "$TYPE $i = { 0 };" >> $g_CFILE
		    done
		elif [[ "$VAR" = +(*\[*\]*) && "$VAR" != +(*=*) ]]
                then
                    # Numeric array assignment
                    echo "$TYPE ${VAR%%\{*} {" >> $g_CFILE
                    OPTION=$g_OPTION_BASE
                    while [[ ${OPTION} -gt 0 ]]
                    do
                        echo " 0, " >> $g_CFILE
                        ((OPTION-=1))
                    done
	            echo "${VAR#*\{};" >> $g_CFILE
		elif [[ "$VAR" != +(*=*) && "$VAR" != +(*\(*\)*) && "${TYPE}" = +(*char*|*short*|*int*|*long*|*double*|*float*|*NUMBER*|*FLOATING*) ]]
		then
		    echo "$TYPE $VAR;" >> $g_CFILE
		    echo "$VAR = 0;" | tr "," "=" >> $g_CFILE
		else
		    echo "$TYPE $VAR;" >> $g_CFILE
		fi
	    fi
	else
	    if [[ -n $g_RECORDNAME ]]
	    then
		echo "$TYPE $VAR; /* noparse */" >> $g_HFILE
	    else
		if [[ "$VAR" = +(*\[*\]*) && "$VAR" != +(*=*) ]]
		then
		    VAR=`echo ${VAR} | tr "," " "`
		    for i in $VAR
		    do
			echo "$TYPE $i = { 0 };" >> $g_HFILE
		    done
		elif [[ "$VAR" = +(*\[*\]*) && "$VAR" != +(*=*) ]]
                then
                    # Numeric array assignment
                    echo "$TYPE ${VAR%%\{*} {" >> $g_HFILE
                    OPTION=$g_OPTION_BASE
                    while [[ ${OPTION} -gt 0 ]]
                    do
                        echo " 0, " >> $g_HFILE
                        ((OPTION-=1))
                    done
	            echo "${VAR#*\{};" >> $g_HFILE
                elif [[ "$VAR" != +(*=*) && "$VAR" != +(*\(*\)*) && "${TYPE}" = +(*char*|*short*|*int*|*long*|*double*|*float*|*NUMBER*|*FLOATING*) ]]
		then
		    echo "$TYPE $VAR;" >> $g_HFILE
		    echo "$VAR = 0;" | tr "," "=" >> $g_CFILE
		else
		    echo "$TYPE $VAR;" >> $g_HFILE
		fi
	    fi
	fi
    fi
}

#-----------------------------------------------------------

function Handle_Read
{
    # Local variables
    local CHECK TARGET STR

    # Check if we have an argument at all
    if [[ "$1" = "READ" ]]
    then
	echo -e "\nERROR: empty READ at line $g_COUNTER in file '$g_CURFILE'!"
	exit 1
    fi

    # Determine target
    if [[ -n $g_FUNCNAME ]]
    then
	TARGET="$g_CFILE $g_HFILE"
    else
	TARGET=$g_HFILE
    fi

    touch $TARGET

    # Check type of var, string?
    if [[ "${1}" = +(*${g_STRINGSIGN}) ]]
    then
	STR=${1%${g_STRINGSIGN}*}
	CHECK=`grep -E "char \*${STR}${g_STRINGSIGN} = NULL;" ${TARGET}`
	if [[ -z $CHECK ]]
	then
	    echo "char *$1 = NULL;" >> $g_HFILE
	fi
	# Convert to C
	echo "$1 = (char*)realloc($1, (strlen(__b2c__stringarray[__b2c__stringarray_ptr])+1)*sizeof(char));" >> $g_CFILE
	echo "strcpy($1, __b2c__stringarray[__b2c__stringarray_ptr]);" >> $g_CFILE
	echo "__b2c__stringarray_ptr++;" >> $g_CFILE
    else
	# Variable may not be array, these should be defined with DECLARE
	if [[ "$1" != +(*\[*\]*) && "$1" != +(*.*) ]]
	then
	    # Not declared? Assume long
	    CHECK=`grep -E "DIR|FILE|int|long|float|double|char|void|STRING|NUMBER|FLOATING" $TARGET | grep -E " $1,| $1;|,$1,|,$1;| $1=| ${1%%\[*}\[|,${1%%\[*}\[" | grep -v " noparse "`
	    if [[ -z $CHECK ]]
	    then
		echo "long $1;" >> $g_HFILE
		CHECK="long "
	    fi
	else
	    # See how var was declared
	    CHECK=`grep -E "DIR |FILE |int |long |float |double |char |void |STRING |NUMBER |FLOATING " $TARGET | grep -E " ${1%%\[*}" | grep -v " noparse "`
	fi
	# Convert to C
	if [[ "$CHECK" = +(*double *) || "$CHECK" = +(*FLOATING *) ]]
	then
	    echo "${1} = __b2c__floatarray[__b2c__floatarray_ptr];" >> $g_CFILE
	    echo "__b2c__floatarray_ptr++;" >> $g_CFILE
	elif [[ "$CHECK" = +(*float *) ]]
	then
	    echo "${1} = (float)__b2c__floatarray[__b2c__floatarray_ptr];" >> $g_CFILE
	    echo "__b2c__floatarray_ptr++;" >> $g_CFILE
	elif [[ "$CHECK" = +(*long *) || "$CHECK" = +(*NUMBER *) ]]
	then
	    echo "${1} = (long)__b2c__floatarray[__b2c__floatarray_ptr];" >> $g_CFILE
	    echo "__b2c__floatarray_ptr++;" >> $g_CFILE
	elif [[ "$CHECK" = +(*int *) ]]
	then
	    echo "${1} = (int)__b2c__floatarray[__b2c__floatarray_ptr];" >> $g_CFILE
	    echo "__b2c__floatarray_ptr++;" >> $g_CFILE
	else
	    echo "${1} = (char*)realloc($1, (strlen(__b2c__stringarray[__b2c__stringarray_ptr])+1)*sizeof(char));" >> $g_CFILE
	    echo "strcpy(${1}, __b2c__stringarray[__b2c__stringarray_ptr]);" >> $g_CFILE
	    echo "__b2c__stringarray_ptr++;" >> $g_CFILE
	fi
    fi
}

#-----------------------------------------------------------

function Handle_Endfunction
{
    # Check if return was found
    if [[ -z $g_FUNCTYPE ]]
    then
	echo -e "\nERROR: function '$g_FUNCNAME' was defined without returning a value or string!"
	exit 1
    fi

    # Put prototype to header file
    echo "$g_FUNCTYPE ${g_PROTOTYPE}; /* noparse */" >> $g_HFILE
    g_PROTOTYPE=

    # Now setup function in main program
    echo "/* Created with BASH BaCon $g_VERSION - (c) Peter van Eerten - GPL v3 */" > ${g_TEMPDIR}/${g_CURFILE%.*}.$g_FUNCNAME.h
    echo "/* noparse $g_CURFILE BACON LINE $g_COUNTER */" >> ${g_TEMPDIR}/${g_CURFILE%.*}.$g_FUNCNAME.h
    if [[ $g_ORIGFUNCNAME != +(*\(*\)*) ]]
    then
	echo "$g_FUNCTYPE $g_ORIGFUNCNAME(void) {" >> ${g_TEMPDIR}/${g_CURFILE%.*}.$g_FUNCNAME.h
    else
	echo "$g_FUNCTYPE $g_ORIGFUNCNAME {" >> ${g_TEMPDIR}/${g_CURFILE%.*}.$g_FUNCNAME.h
    fi

    # Add function body
    echo "${g_STRINGARGS}" >> ${g_TEMPDIR}/${g_CURFILE%.*}.$g_FUNCNAME.h
    cat $g_CFILE >> ${g_TEMPDIR}/${g_CURFILE%.*}.$g_FUNCNAME.h
    echo "__B2C__PROGRAM__EXIT: ;" >> ${g_TEMPDIR}/${g_CURFILE%.*}.$g_FUNCNAME.h

    # Make sure the function always returns something
    if [[ $g_FUNCTYPE = +(*char\**) ]]
    then
	echo "return (\"\");}" >> ${g_TEMPDIR}/${g_CURFILE%.*}.$g_FUNCNAME.h
    else
	echo "return (0);}" >> ${g_TEMPDIR}/${g_CURFILE%.*}.$g_FUNCNAME.h
    fi

    # Include header file
    if [[ ${g_INCLUDE_FILES} != +(*${g_CURFILE%.*}.$g_FUNCNAME.h*) ]]
    then
	g_INCLUDE_FILES="$g_INCLUDE_FILES ${g_CURFILE%.*}.$g_FUNCNAME.h"
    fi

    # Add to total filelist
    g_TMP_FILES="$g_TMP_FILES ${g_TEMPDIR}/${g_CURFILE%.*}.$g_FUNCNAME.h"

    # Delete temp funcfile
    rm $g_CFILE

    # Restore mainfile
    g_CFILE=$g_COPY_CFILE

    # Restore CATCH routine
    g_CATCHGOTO="$g_ORIGCATCHGOTO"

    # Clear function variables
    g_ORIGFUNCNAME=
    g_FUNCNAME=
    g_FUNCTYPE=
    g_LOCALSTRINGS=
    g_STRINGARRAYS=
    g_STRINGARGS=
}

#-----------------------------------------------------------

function Handle_Return
{
    # Local variables
    local CHECK STR DQ FUNC ARG

    # Check if we have an argument at all
    if [[ "$1" = "RETURN" ]]
    then
	echo -e "\nERROR: empty RETURN at line $g_COUNTER in file '$g_CURFILE'!"
	exit 1
    fi

    CHECK=`grep -E "DIR|FILE|int|long|float|double|char|void|STRING|NUMBER|FLOATING" $g_CFILE | grep -E " $1,| $1;|,$1,|,$1;| $1=| ${1%%\[*}\[|,${1%%\[*}\[" | grep -v " noparse "`

    # Determine if argument ends with Double Quote
    DQ="${1: -1}"
    FUNC="${1:0:3}"

   # Check type of var, func using string but returning a value? See also PRINT miniparser
    if [[ ${FUNC} = "INS" || ${FUNC} = "VAL" || ${FUNC} = "LEN" || ${FUNC} = "SEA" || ${FUNC} = "ASC" || "${1}" = +(FILE*) || "${1}" = +(REGEX*) ]]
    then
	g_FUNCTYPE="double "
	ARG="${1}"

    # Check type of var, string or normal string?
    elif [[ "${1}" = +(*${g_STRINGSIGN}*) || "${DQ}" = +(${g_DQUOTESIGN}) || ${g_FUNCNAME} = +(*${g_STRINGSIGN}*) ]]
    then
	g_FUNCTYPE="char* "
	echo "__b2c__rbuffer_ptr++; if(__b2c__rbuffer_ptr >= $g_MAX_RBUFFERS) __b2c__rbuffer_ptr=0; if($1 != NULL)" >> $g_CFILE
	echo " {__b2c__rbuffer[__b2c__rbuffer_ptr] = (char*)realloc(__b2c__rbuffer[__b2c__rbuffer_ptr], (strlen($1)+1)*sizeof(char));" >> $g_CFILE
	echo "strcpy(__b2c__rbuffer[__b2c__rbuffer_ptr], $1);}" >> $g_CFILE
	echo "else {__b2c__rbuffer[__b2c__rbuffer_ptr] = (char*)realloc(__b2c__rbuffer[__b2c__rbuffer_ptr], 2*sizeof(char));" >> $g_CFILE
	echo "strcpy(__b2c__rbuffer[__b2c__rbuffer_ptr], \"\");}" >> $g_CFILE
	ARG="__b2c__rbuffer[__b2c__rbuffer_ptr]"

    # Check if float
    elif [[ "$1" = +(*.*) ]]
    then
	g_FUNCTYPE="double "
	ARG="${1}"

    # Check if no alpha chars (then integer value)
    elif [[ "$1" = +([0-9]) ]]
    then
	g_FUNCTYPE="long "
	ARG="${1}"

    # Assume variable, check if declared before
    elif [[ -n $CHECK ]]
    then
	case $CHECK in
	    +(*DIR *) )
		g_FUNCTYPE="DIR* ";;
	    +(*FILE *) )
		g_FUNCTYPE="FILE* ";;
	    +(*int\* *) )
		g_FUNCTYPE="int* ";;
	    +(*float\* *) )
		g_FUNCTYPE="float* ";;
	    +(*double\* *) )
		g_FUNCTYPE="double* ";;
	    +(*char\* *|*STRING *) )
		g_FUNCTYPE="char* ";;
	    +(*long\* *) )
		g_FUNCTYPE="long* ";;
	    +(*void\* *) )
		g_FUNCTYPE="void* ";;
	    +(*int *) )
		g_FUNCTYPE="int ";;
	    +(*float *) )
		g_FUNCTYPE="float ";;
	    +(*double *|*FLOATING *) )
		g_FUNCTYPE="double ";;
	    +(*char *) )
		g_FUNCTYPE="char ";;
	    +(*long *|*NUMBER *) )
		g_FUNCTYPE="long ";;
	    +(*void *) )
		g_FUNCTYPE="void ";;
	esac
	ARG="${1}"

    # Not declared, assume integer variable
    else
	g_FUNCTYPE="long "
	ARG="${1}"
    fi

    # Free strings variables if there are any
    for STR in $g_LOCALSTRINGS
    do
	echo "if($STR != NULL) free($STR);" >> $g_CFILE
    done
    echo "${g_STRINGARRAYS}" >> $g_CFILE

    # The actual return value
    echo "return (${ARG});" >> $g_CFILE
}

#-----------------------------------------------------------

function Handle_Push
{
    # Local variables
    local CHECK TARGET

    # Check if we have an argument at all
    if [[ "$1" = "PUSH" ]]
    then
	echo -e "\nERROR: empty PUSH at line $g_COUNTER in file '$g_CURFILE'!"
	exit 1
    fi

    # Determine target
    if [[ -n $g_FUNCNAME ]]
    then
	TARGET="$g_CFILE $g_HFILE"
    else
	TARGET=$g_HFILE
    fi

    touch $TARGET

    if [[ "$VAR" != +(*.*) ]]
    then
	CHECK=`grep -E "DIR|FILE|int|long|float|double|char|void|STRING|NUMBER|FLOATING" $TARGET | grep -E " $1,| $1;|,$1,|,$1;| $1=| ${1%%\[*}\[|,${1%%\[*}\[" | grep -v " noparse "`
    fi

    # Allocate space for type
    echo "__b2c__typestack = (int*)realloc(__b2c__typestack, (__b2c__stackptr+1)*sizeof(int));" >> $g_CFILE

    # Check type of var, string?
    if [[ "${1}" = +(*${g_STRINGSIGN}*) ]]
    then
	echo "__b2c__stringstack = (char**)realloc(__b2c__stringstack, (__b2c__stackptr+1)*sizeof(char*));" >> $g_CFILE
	echo "if(__b2c__stackptr == 0){ __b2c__stringstack[__b2c__stackptr] = realloc(__b2c__stringstack[__b2c__stackptr], (strlen($1)+1)*sizeof(char));" >> $g_CFILE
	echo "strcpy(__b2c__stringstack[__b2c__stackptr], $1);} else __b2c__stringstack[__b2c__stackptr] = strdup($1);" >> $g_CFILE
	echo "__b2c__typestack[__b2c__stackptr] = 1;" >> $g_CFILE
    # Check if it is a normal string
    elif [[ "${1}" = +(*${g_DQUOTESIGN}*) ]]
    then
	echo "__b2c__stringstack = (char**)realloc(__b2c__stringstack, (__b2c__stackptr+1)*sizeof(char*));" >> $g_CFILE
	echo "if(__b2c__stackptr == 0){__b2c__stringstack[__b2c__stackptr] = realloc(__b2c__stringstack[__b2c__stackptr], (strlen($1)+1)*sizeof(char));" >> $g_CFILE
	echo "strcpy(__b2c__stringstack[__b2c__stackptr], $1);} else __b2c__stringstack[__b2c__stackptr] = strdup($1);" >> $g_CFILE
	echo "__b2c__typestack[__b2c__stackptr] = 1;" >> $g_CFILE
    # Check if float
    elif [[ "$1" = +(*.*) ]]
    then
	echo "__b2c__doublestack = (double*)realloc(__b2c__doublestack, (__b2c__stackptr+1)*sizeof(double));" >> $g_CFILE
	echo "__b2c__doublestack[__b2c__stackptr] = $1;" >> $g_CFILE
	echo "__b2c__typestack[__b2c__stackptr] = 2;" >> $g_CFILE
    # Check if no alpha chars (then integer value)
    elif [[ "$1" = +(![a-zA-Z]) ]]
    then
	echo "__b2c__longstack = (long*)realloc(__b2c__longstack, (__b2c__stackptr+1)*sizeof(long));" >> $g_CFILE
	echo "__b2c__longstack[__b2c__stackptr] = $1;" >> $g_CFILE
	echo "__b2c__typestack[__b2c__stackptr] = 3;" >> $g_CFILE
    # Assume variable, check if declared before
    elif [[ -n $CHECK ]]
    then
	if [[ $CHECK = +(double*) ]]
	then
	    echo "__b2c__doublestack = (double*)realloc(__b2c__doublestack, (__b2c__stackptr+1)*sizeof(double));" >> $g_CFILE
	    echo "__b2c__doublestack[__b2c__stackptr] = $1;" >> $g_CFILE
	    echo "__b2c__typestack[__b2c__stackptr] = 2;" >> $g_CFILE
	else
	    echo "__b2c__longstack = (long*)realloc(__b2c__longstack, (__b2c__stackptr+1)*sizeof(long));" >> $g_CFILE
	    echo "__b2c__longstack[__b2c__stackptr] = $1;" >> $g_CFILE
	    echo "__b2c__typestack[__b2c__stackptr] = 3;" >> $g_CFILE
	fi
    # Not declared, assume integer variable
    else
	echo "__b2c__longstack = (long*)realloc(__b2c__longstack, (__b2c__stackptr+1)*sizeof(long));" >> $g_CFILE
	echo "__b2c__longstack[__b2c__stackptr] = $1;" >> $g_CFILE
	echo "__b2c__typestack[__b2c__stackptr] = 3;" >> $g_CFILE
    fi

    # Increase stackpointer
    echo "__b2c__stackptr++;" >> $g_CFILE
}

#-----------------------------------------------------------

function Handle_Pull
{
    local CHECK TARGET STR

    # Check if we have an argument at all
    if [[ "$1" = "PULL" ]]
    then
	echo -e "\nERROR: empty PULL at line $g_COUNTER in file '$g_CURFILE'!"
	exit 1
    fi

    # Argument must be a variable
    if [[ "$1" = +(![a-zA-Z]) ]]
    then
	echo -e "\nERROR: argument in PULL statement at line $g_COUNTER in file '$g_CURFILE' is not a variable!"
	exit 1
    fi

    # Determine target
    if [[ -n $g_FUNCNAME ]]
    then
	TARGET="$g_CFILE $g_HFILE"
    else
	TARGET=$g_HFILE
    fi

    touch $TARGET

    # Decrease stackpointer again
    echo "__b2c__stackptr--;" >> $g_CFILE
    echo "if(__b2c__stackptr < 0) __b2c__stackptr=0;" >> $g_CFILE

    # Get the last value from stack
    if [[ "${1}" = +(*${g_STRINGSIGN}) ]]
    then
    	STR=${1%${g_STRINGSIGN}*}
	CHECK=`grep -E "char \*${STR}${g_STRINGSIGN} = NULL;" ${TARGET}`
	if [[ -z $CHECK ]]
	then
	    echo "char *$1 = NULL;" >> $g_HFILE
	fi
	echo "if(__b2c__typestack[__b2c__stackptr] == 1) {" >> $g_CFILE
	echo "$1 = (char*)realloc($1, (strlen(__b2c__stringstack[__b2c__stackptr])+1)*sizeof(char));" >> $g_CFILE
	echo "strcpy($1, __b2c__stringstack[__b2c__stackptr]); if(__b2c__stackptr > 0) free(__b2c__stringstack[__b2c__stackptr]);}" >> $g_CFILE
    else
	# Variable may not be array, these should be defined with DECLARE
	if [[ "$1" != +(*\[*\]*) && "$VAR" != +(*.*) ]]
	then
	    # Not declared? Assume long
	    CHECK=`grep -E "DIR|FILE|int|long|float|double|char|void|STRING|NUMBER|FLOATING" $TARGET | grep -E " $1,| $1;|,$1,|,$1;| $1=| ${1%%\[*}\[|,${1%%\[*}\[" | grep -v " noparse "`
	    if [[ -z $CHECK ]]
	    then
		echo "long $1;" >> $g_HFILE
		CHECK="long "
	    fi
	else
	    # See how var was declared
	    CHECK=`grep -E "DIR |FILE |int |long |float |double |char |void |STRING |NUMBER |FLOATING " $TARGET | grep -E " ${1%%\[*}" | grep -v " noparse "`
	fi
	# Make sure internal var is copied to var of program
	if [[ "$CHECK" = +(*double *) || "$CHECK" = +(*float *) || "$CHECK" = +(*FLOATING *) ]]
	then
	    echo "if(__b2c__typestack[__b2c__stackptr] == 2) $1=__b2c__doublestack[__b2c__stackptr];" >> $g_CFILE
	elif [[ "$CHECK" = +(*long *) || "$CHECK" = +(*int *) || "$CHECK" = +(*NUMBER *) ]]
	then
	    echo "if(__b2c__typestack[__b2c__stackptr] == 3) $1=__b2c__longstack[__b2c__stackptr];" >> $g_CFILE
	else
	    echo "if(__b2c__typestack[__b2c__stackptr] == 1) {" >> $g_CFILE
	    echo "$1 = (char*)realloc($1, (strlen(__b2c__stringstack[__b2c__stackptr])+1)*sizeof(char));" >> $g_CFILE
	    echo "strcpy($1, __b2c__stringstack[__b2c__stackptr]); if(__b2c__stackptr > 0) free(__b2c__stringstack[__b2c__stackptr]);}" >> $g_CFILE
	fi
    fi
}

#-----------------------------------------------------------

function Handle_SubFunc
{
    local ARGS TOKEN LEN CHAR DIM ARR CHECK SIZE

    # Check argument
    if [[ "${1}" = "SUB" ]]
    then
	echo -e "\nERROR: empty SUB/FUNCTION at line $g_COUNTER in file '$g_CURFILE'!"
	exit 1
    fi

    # Check if we are in a sub already
    if [[ -n $g_FUNCNAME ]]
    then
	echo -e "\nERROR: cannot define a SUB/FUNCTION within a SUB/FUNCTION at line $g_COUNTER in file '$g_CURFILE'!"
	exit 1
    fi

    # Get the funcname
    g_ORIGFUNCNAME=`echo ${1%%\(*}"("`
    g_PROTOTYPE=`echo ${1%%\(*}"("`

    # Start miniparser to duplicate string arguments, convert spaces
    ARGS=`echo "${1##*\(}" | tr " " "\001"`
    TOKEN=
    LEN=${#ARGS}

    # Get the characters
    until [[ $LEN -eq 0 ]]
    do
	CHAR="${ARGS:0:1}"
	if [[ $CHAR = "," ]]
	then
	    if [[ ${TOKEN} = +(*STRING*) || ${TOKEN} = +(*char\**) ]]
	    then
		TOKEN=`echo ${TOKEN}`
                DIM=${TOKEN##*\[}; ARR=${TOKEN##* }
                if [[ $TOKEN != +(*${g_STRINGSIGN}*) && $TOKEN = +(*\[*\]*) ]]
                then
		    g_ORIGFUNCNAME="$g_ORIGFUNCNAME char *__b2c_${ARR%%\[*}[${DIM%%\]*}+$g_OPTION_BASE],"
	            g_STRINGARGS="$g_STRINGARGS char** ${ARR%%\[*} = __b2c_${ARR%%\[*};"
	            g_PROTOTYPE="$g_PROTOTYPE ${TOKEN},"
                elif [[ $TOKEN != +(*${g_STRINGSIGN}*) ]]
                then
		    g_ORIGFUNCNAME="$g_ORIGFUNCNAME char *__b2c_${TOKEN##* },"
	            g_STRINGARGS="$g_STRINGARGS char* ${TOKEN##* } = __b2c_${TOKEN##* };"
	            g_PROTOTYPE="$g_PROTOTYPE ${TOKEN},"
	        elif [[ $TOKEN = +(*\[*\]*) ]]
		then
		    g_ORIGFUNCNAME="$g_ORIGFUNCNAME char *__b2c_${ARR%%\[*}[${DIM%%\]*}+$g_OPTION_BASE],"
		    if [[ -z ${DIM%%\]*} ]]
		    then
			echo -e "\nERROR: cannot pass string array without dimension at line $g_COUNTER in file '$g_CURFILE'!"
			exit 1
		    fi
	            g_STRINGARGS="$g_STRINGARGS char *${ARR%%\[*}[${DIM%%\]*}+$g_OPTION_BASE] = { NULL };"
                    g_STRINGARGS="$g_STRINGARGS for(__b2c__ctr=0; __b2c__ctr<${DIM%%\]*}+$g_OPTION_BASE; __b2c__ctr++){if(__b2c_${ARR%%\[*}[__b2c__ctr]!=NULL) ${ARR%%\[*}[__b2c__ctr] = strdup(__b2c_${ARR%%\[*}[__b2c__ctr]);}"
	            g_STRINGARRAYS="$g_STRINGARRAYS for(__b2c__ctr=0; __b2c__ctr<${DIM%%\]*}+$g_OPTION_BASE; __b2c__ctr++)if(${ARR%%\[*}[__b2c__ctr]!=NULL){free(${ARR%%\[*}[__b2c__ctr]);}"
		    g_PROTOTYPE="$g_PROTOTYPE char *__b2c_${TOKEN##* },"
		else
		    g_ORIGFUNCNAME="$g_ORIGFUNCNAME char *__b2c_${TOKEN##* },"
		    g_STRINGARGS="$g_STRINGARGS char *${TOKEN##* } = strdup(__b2c_${TOKEN##* });"
		    g_LOCALSTRINGS="$g_LOCALSTRINGS ${TOKEN##* }"
		    g_PROTOTYPE="$g_PROTOTYPE ${TOKEN},"
		fi
	    else
		TOKEN=`echo ${TOKEN}`
		if [[ $TOKEN = +(*\[*\]*\]*) ]]
		then
		    echo -e "\nERROR: cannot pass multidimensional numeric array at line $g_COUNTER in file '$g_CURFILE'!"
		    exit 1
		elif [[ $TOKEN = +(*\[\]*) ]]
		then
		    g_ORIGFUNCNAME="$g_ORIGFUNCNAME ${TOKEN},"
		elif [[ $TOKEN = +(*\[*\]*) ]]
		then
		    DIM=${TOKEN##*\[}; ARR=${TOKEN##* }
		    g_ORIGFUNCNAME="$g_ORIGFUNCNAME ${TOKEN%% *} __b2c_${ARR%%\[*}[${DIM%%\]*}+$g_OPTION_BASE],"
		    if [[ -z ${DIM%%\]*} ]]
		    then
			echo -e "\nERROR: cannot pass numeric array without dimension at line $g_COUNTER in file '$g_CURFILE'!"
			exit 1
		    fi
		    g_STRINGARGS="$g_STRINGARGS ${TOKEN%% *} ${ARR%%\[*}[${DIM%%\]*}+$g_OPTION_BASE] = { 0 };"
		    g_STRINGARGS="$g_STRINGARGS for(__b2c__ctr=0; __b2c__ctr<${DIM%%\]*}+$g_OPTION_BASE; __b2c__ctr++){ ${ARR%%\[*}[__b2c__ctr] = __b2c_${ARR%%\[*}[__b2c__ctr];}"
		elif [[ $TOKEN = +(*VAR *) ]]
		then
		    echo -e "\nERROR: variable argument list cannot be followed by other arguments at line $g_COUNTER in file '$g_CURFILE'!"
		    exit 1
		else
		    g_ORIGFUNCNAME="$g_ORIGFUNCNAME ${TOKEN},"
		fi
		g_PROTOTYPE="$g_PROTOTYPE ${TOKEN},"
	    fi
	    TOKEN=
	    CHAR=
	fi
	# Convert back to space
	if [[ "${CHAR}" = "${g_PARSEVAR}" ]]
	then
	    TOKEN="${TOKEN} "
	else
	    TOKEN="${TOKEN}${CHAR}"
	fi
	let LEN=${#ARGS}-1
	ARGS="${ARGS: -$LEN}"
    done

    # Last token in the sequence of arguments
    TOKEN=${TOKEN%%\)*}
    TOKEN=`echo ${TOKEN}`
    if [[ ${TOKEN} = +(*STRING*) || ${TOKEN} = +(*char\**) ]]
    then
	DIM=${TOKEN##*\[}; ARR=${TOKEN##* }
        if [[ $TOKEN != +(*${g_STRINGSIGN}*) && $TOKEN = +(*\[*\]*) ]]
        then
	    g_ORIGFUNCNAME="$g_ORIGFUNCNAME char *__b2c_${ARR%%\[*}[${DIM%%\]*}+$g_OPTION_BASE])"
	    g_STRINGARGS="$g_STRINGARGS char** ${ARR%%\[*} = __b2c_${ARR%%\[*};"
	    g_PROTOTYPE="$g_PROTOTYPE ${TOKEN})"
        elif [[ $TOKEN != +(*${g_STRINGSIGN}*) ]]
        then
	    g_ORIGFUNCNAME="$g_ORIGFUNCNAME char *__b2c_${TOKEN##* })"
	    g_STRINGARGS="$g_STRINGARGS char* ${TOKEN##* } = __b2c_${TOKEN##* };"
	    g_PROTOTYPE="$g_PROTOTYPE ${TOKEN})"
	elif [[ $TOKEN = +(*\[*\]*) ]]
	then
	    g_ORIGFUNCNAME="$g_ORIGFUNCNAME char *__b2c_${ARR%%\[*}[${DIM%%\]*}+$g_OPTION_BASE])"
	    if [[ -z ${DIM%%\]*} ]]
	    then
		echo -e "\nERROR: cannot pass string array without dimension at line $g_COUNTER in file '$g_CURFILE'!"
		exit 1
	    fi
	    g_STRINGARGS="$g_STRINGARGS char *${ARR%%\[*}[${DIM%%\]*}+$g_OPTION_BASE] = { NULL };"
            g_STRINGARGS="$g_STRINGARGS for(__b2c__ctr=0; __b2c__ctr<${DIM%%\]*}+$g_OPTION_BASE; __b2c__ctr++){if(__b2c_${ARR%%\[*}[__b2c__ctr]!=NULL) ${ARR%%\[*}[__b2c__ctr] = strdup(__b2c_${ARR%%\[*}[__b2c__ctr]);}"
	    g_STRINGARRAYS="$g_STRINGARRAYS for(__b2c__ctr=0; __b2c__ctr<${DIM%%\]*}+$g_OPTION_BASE; __b2c__ctr++)if(${ARR%%\[*}[__b2c__ctr]!=NULL){free(${ARR%%\[*}[__b2c__ctr]);}"
	    g_PROTOTYPE="$g_PROTOTYPE char *__b2c_${TOKEN##* })"
	else
	    g_ORIGFUNCNAME="$g_ORIGFUNCNAME char *__b2c_${TOKEN##* })"
	    g_STRINGARGS="$g_STRINGARGS char *${TOKEN##* } = strdup(__b2c_${TOKEN##* });"
	    g_LOCALSTRINGS="$g_LOCALSTRINGS ${TOKEN##* }"
	    g_PROTOTYPE="$g_PROTOTYPE ${TOKEN})"
	fi
    else
	if [[ -z ${TOKEN} || ${TOKEN} = ${1} ]]
	then
	    TOKEN="void"
	fi
	if [[ $TOKEN = +(*\[*\]*\]*) ]]
	then
	    echo -e "\nERROR: cannot pass multidimensional numeric array at line $g_COUNTER in file '$g_CURFILE'!"
	    exit 1
	elif [[ $TOKEN = +(*\[\]*) ]]
	then
	    g_ORIGFUNCNAME="$g_ORIGFUNCNAME ${TOKEN})"
	elif [[ $TOKEN = +(*\[*\]*) ]]
	then
	    DIM=${TOKEN##*\[}; ARR=${TOKEN##* }
	    g_ORIGFUNCNAME="$g_ORIGFUNCNAME ${TOKEN%% *} __b2c_${ARR%%\[*}[${DIM%%\]*}+$g_OPTION_BASE])"
	    if [[ -z ${DIM%%\]*} ]]
	    then
		echo -e "\nERROR: cannot pass numeric array without dimension at line $g_COUNTER in file '$g_CURFILE'!"
		exit 1
	    fi
	    g_STRINGARGS="$g_STRINGARGS ${TOKEN%% *} ${ARR%%\[*}[${DIM%%\]*}+$g_OPTION_BASE] = { 0 };"
            g_STRINGARGS="$g_STRINGARGS for(__b2c__ctr=0; __b2c__ctr<${DIM%%\]*}+$g_OPTION_BASE; __b2c__ctr++){ ${ARR%%\[*}[__b2c__ctr] = __b2c_${ARR%%\[*}[__b2c__ctr];}"
	elif [[ $TOKEN = +(*VAR *) ]]
	then
	    if [[ $g_PROTOTYPE = +(*,*) ]]
	    then
		echo -e "\nERROR: variable argument list cannot be preceded by other arguments at line $g_COUNTER in file '$g_CURFILE'!"
		exit 1
	    fi
	    if [[ "${TOKEN}" != +(* SIZE *) ]]
	    then
		echo -e "\nERROR: variable argument list lacks SIZE argument at line $g_COUNTER in file '$g_CURFILE'!"
		exit 1
	    fi
	    ARR=${TOKEN#* }; ARR=${ARR%%SIZE *}; SIZE=${TOKEN##* }
	    if [[ "${ARR}" != +(*${g_STRINGSIGN}*) ]]
	    then
		echo -e "\nERROR: variable argument list is not string at line $g_COUNTER in file '$g_CURFILE'!"
		exit 1
	    fi
	    CHECK=`grep -E "DIR|FILE|int|long|float|double|char|void|STRING|NUMBER|FLOATING" $g_HFILE | grep -E " $SIZE,| $SIZE;|,$SIZE,|,$SIZE;| $SIZE=| ${SIZE%%\[*}\[|,${SIZE%%\[*}\[" | grep -v " noparse "`
	    if [[ -z $CHECK ]]
	    then
		g_STRINGARGS="$g_STRINGARGS long ${SIZE};"
	    fi
	    g_STRINGARGS="$g_STRINGARGS long __b2c__var_$ARR = $g_OPTION_BASE; va_list __b2c__ap; char **${ARR} = NULL; char* __b2c__va = NULL; $ARR = (char **)realloc($ARR, (__b2c__var_$ARR+1) * sizeof(char*));"
	    g_STRINGARGS="$g_STRINGARGS va_start(__b2c__ap, __b2c__name); ${ARR}[__b2c__var_$ARR] = strdup(__b2c__name); while (${ARR}[__b2c__var_$ARR] != NULL) {__b2c__var_$ARR++; $ARR = (char **)realloc($ARR, (__b2c__var_$ARR+1) * sizeof(char*));"
	    g_STRINGARGS="$g_STRINGARGS __b2c__va = va_arg(__b2c__ap, char*); if(__b2c__va!=NULL) ${ARR}[__b2c__var_$ARR] = strdup(__b2c__va); else ${ARR}[__b2c__var_$ARR] = NULL; }"
	    g_STRINGARGS="$g_STRINGARGS va_end(__b2c__ap); ${SIZE} = __b2c__var_$ARR - $g_OPTION_BASE; if(__b2c__var_$ARR > 0) __b2c__var_$ARR--;"
	    g_PROTOTYPE="__${g_PROTOTYPE}"
	    g_ORIGFUNCNAME="${g_ORIGFUNCNAME}char *__b2c__name, ...)"
	    TOKEN="char*, ..."
	    g_STRINGARRAYS="$g_STRINGARRAYS if($ARR != NULL) {for(__b2c__ctr=$g_OPTION_BASE; __b2c__ctr<=__b2c__var_$ARR; __b2c__ctr++) if($ARR[__b2c__ctr]!=NULL){free($ARR[__b2c__ctr]);} free($ARR);}"
	else
	    g_ORIGFUNCNAME="$g_ORIGFUNCNAME ${TOKEN})"
	fi
	g_PROTOTYPE="$g_PROTOTYPE ${TOKEN})"
    fi

    # Get original function name
    if [[ "$g_ORIGFUNCNAME" = +(* \(*\)*) ]]
    then
	g_FUNCNAME=`echo ${g_ORIGFUNCNAME%% *}`
    elif [[ "$g_ORIGFUNCNAME" = +(*\(*\)*) ]]
    then
	g_FUNCNAME=`echo ${g_ORIGFUNCNAME%%\(*}`
    else
	g_FUNCNAME=`echo $g_ORIGFUNCNAME`
    fi

    # Add macro in case of VAR argument
    if [[ $TOKEN = +(* ...*) ]]
    then
	echo "#define ${g_FUNCNAME}(...) __${g_FUNCNAME}(\"${g_FUNCNAME}\", __VA_ARGS__, NULL)" >> $g_HFILE
	g_ORIGFUNCNAME="__${g_ORIGFUNCNAME}"
    fi

    # Make symbol known to parser
    g_IMPORTED="$g_FUNCNAME $g_IMPORTED"

    # Switch to header file
    g_COPY_CFILE=$g_CFILE
    g_CFILE=${g_CFILE%.*}.${g_FUNCNAME}.tmp

    # Save CATCH routine
    g_ORIGCATCHGOTO="$g_CATCHGOTO"
    g_CATCHGOTO="__B2C__PROGRAM__EXIT"

    touch $g_CFILE
}

#-----------------------------------------------------------

function Handle_Endsub
{
    typeset STR

    # Put prototype to header file
    echo "void ${g_PROTOTYPE}; /* noparse */" >> $g_HFILE
    g_PROTOTYPE=

    # Get original function name
    echo "/* Created with BASH BaCon $g_VERSION - (c) Peter van Eerten - GPL v3 */" > ${g_TEMPDIR}/${g_CURFILE%.*}.$g_FUNCNAME.h
    echo "/* noparse $g_CURFILE BACON LINE $g_COUNTER */" >> ${g_TEMPDIR}/${g_CURFILE%.*}.$g_FUNCNAME.h
    if [[ "$g_ORIGFUNCNAME" = +(* \(*\)*) ]]
    then
	echo "void ${g_ORIGFUNCNAME} {" >> ${g_TEMPDIR}/${g_CURFILE%.*}.$g_FUNCNAME.h
    elif [[ "$g_ORIGFUNCNAME" = +(*\(*\)*) ]]
    then
	echo "void ${g_ORIGFUNCNAME} {" >> ${g_TEMPDIR}/${g_CURFILE%.*}.$g_FUNCNAME.h
    else
	echo "void ${g_FUNCNAME}(void) {" >> ${g_TEMPDIR}/${g_CURFILE%.*}.$g_FUNCNAME.h
    fi

    # Finalize sub
    echo "${g_STRINGARGS}" >> ${g_TEMPDIR}/${g_CURFILE%.*}.$g_FUNCNAME.h
    cat $g_CFILE >> ${g_TEMPDIR}/${g_CURFILE%.*}.$g_FUNCNAME.h

    # Free strings variables if there are any
    for STR in $g_LOCALSTRINGS
    do
	echo "if($STR != NULL) free(${STR});" >> ${g_TEMPDIR}/${g_CURFILE%.*}.$g_FUNCNAME.h
    done
    echo "${g_STRINGARRAYS}" >> ${g_TEMPDIR}/${g_CURFILE%.*}.$g_FUNCNAME.h
    echo "__B2C__PROGRAM__EXIT: ;" >> ${g_TEMPDIR}/${g_CURFILE%.*}.$g_FUNCNAME.h
    echo "}" >> ${g_TEMPDIR}/${g_CURFILE%.*}.$g_FUNCNAME.h

    # Include header file
    if [[ ${g_INCLUDE_FILES} != +(*${g_CURFILE%.*}.$g_FUNCNAME.h*) ]]
    then
	g_INCLUDE_FILES="$g_INCLUDE_FILES ${g_CURFILE%.*}.$g_FUNCNAME.h"
    fi

    # Add to total filelist
    g_TMP_FILES="$g_TMP_FILES ${g_TEMPDIR}/${g_CURFILE%.*}.$g_FUNCNAME.h"

    # Delete temp funcfile
    rm $g_CFILE

    # Restore mainfile
    g_CFILE=$g_COPY_CFILE

    # Restore CATCH routine
    g_CATCHGOTO="$g_ORIGCATCHGOTO"

    # Reset variables
    g_ORIGFUNCNAME=
    g_FUNCNAME=
    g_LOCALSTRINGS=
    g_STRINGARRAYS=
    g_STRINGARGS=
}

#-----------------------------------------------------------

function Handle_Deffn
{
    local SYM
	
    # Check if we have an argument at all
    if [[ "$1" = "DEF" ]]
    then
	echo -e "\nERROR: empty DEF FN at line $g_COUNTER in file '$g_CURFILE'!"
	exit 1
    fi

    # Translate to C macro
    SYM=${1#* }

    echo "#define ${SYM%%=*} (${SYM#*=})" >> $g_HFILE

    # Make symbol known to parser
    g_IMPORTED="${SYM%%\(*} $g_IMPORTED"
}

#-----------------------------------------------------------

function Handle_Const
{
    # Check if we have an argument at all
    if [[ "$1" = "CONST" ]]
    then
	echo -e "\nERROR: empty CONST at line $g_COUNTER in file '$g_CURFILE'!"
	exit 1
    fi

    echo "#define ${1%%=*} (${1#*=})" >> $g_HFILE
}

#-----------------------------------------------------------

function Handle_Seek
{
    local FILE OFFSET WHENCE

    # Check if we have an argument at all
    if [[ "$1" = "SEEK" ]]
    then
	echo -e "\nERROR: empty SEEK at line $g_COUNTER in file '$g_CURFILE'!"
	exit 1
    fi

    # Check if TO is available
    if [[ "$1" != +(* OFFSET *) ]]
    then
	echo -e "\nERROR: Missing OFFSET in SEEK statement at line $g_COUNTER in file '$g_CURFILE'!"
	exit 1
    fi

    # Get the variablename without surrounding spaces
    FILE=`echo ${1%% OFFSET *}`;

    # Get filedescriptor
    OFFSET=`echo ${1##* OFFSET }`

    WHENCE=

    # Check if WHENCE is available
    if [[ "$1" = +(* WHENCE *) ]]
    then
	WHENCE=${OFFSET##* WHENCE }
	OFFSET=${OFFSET%% WHENCE *}
    fi

    # Convert to C function
    case $WHENCE in
	+(START) )
	    echo "fseek($FILE, $OFFSET, SEEK_SET);" >> $g_CFILE;;
	+(CURRENT) )
	    echo "fseek($FILE, $OFFSET, SEEK_CUR);" >> $g_CFILE;;
	+(END) )
	    echo "fseek($FILE, $OFFSET, SEEK_END);" >> $g_CFILE;;
	*)
	    echo "fseek($FILE, $OFFSET, SEEK_SET);" >> $g_CFILE;;
    esac
}

#-----------------------------------------------------------

function Handle_Copy
{
    local FROM TO

    # Check if we have an argument at all
    if [[ "$1" = "COPY" ]]
    then
	echo -e "\nERROR: empty COPY at line $g_COUNTER in file '$g_CURFILE'!"
	exit 1
    fi

    # Check if TO is available
    if [[ "$1" != +(* TO *) ]]
    then
	echo -e "\nERROR: Missing TO in COPY statement at line $g_COUNTER in file '$g_CURFILE'!"
	exit 1
    fi

    # Get the filename and copyname
    FROM=`echo ${1%% TO *}`
    TO=`echo ${1##* TO }`

    #translate to C function
    echo "__b2c__inFile = fopen($FROM, \"r\"); __b2c__outFile = fopen($TO, \"w\"); __b2c__Byte = 0;" >> $g_CFILE
    echo "if (__b2c__inFile != NULL && __b2c__outFile != NULL){while(__b2c__Byte!=EOF){" >> $g_CFILE
    echo "__b2c__Byte=fgetc(__b2c__inFile); if(__b2c__Byte!=EOF){" >> $g_CFILE
    echo "fputc(__b2c__Byte,__b2c__outFile); }}" >> $g_CFILE
    echo "fclose(__b2c__inFile); fclose(__b2c__outFile);}" >> $g_CFILE
    echo "else {if(!__b2c__trap){ERROR = 2; if(!__b2c__catch_set){fprintf(stderr, \"%s\n\", ERR${g_STRINGSIGN}(ERROR)); exit(ERROR);} if(!setjmp(__b2c__jump)) goto $g_CATCHGOTO;} }" >> $g_CFILE
}

#-----------------------------------------------------------

function Handle_Rename
{
    local FROM TO

    # Check if we have an argument at all
    if [[ "$1" = "RENAME" ]]
    then
	echo -e "\nERROR: empty RENAME at line $g_COUNTER in file '$g_CURFILE'!"
	exit 1
    fi
    
    # Check if TO is available
    if [[ "$1" != +(* TO *) ]]
    then
	echo -e "\nERROR: Missing TO in RENAME statement at line $g_COUNTER in file '$g_CURFILE'!"
	exit 1
    fi

    # Get the filename and copyname
    FROM=`echo ${1%% TO *}`
    TO=`echo ${1##* TO }`

    # Translate to C function
    echo "if(rename($FROM, $TO) < 0) {if(!__b2c__trap){ERROR = 9; if(!__b2c__catch_set){fprintf(stderr, \"%s\n\", ERR${g_STRINGSIGN}(ERROR)); exit(ERROR);} if(!setjmp(__b2c__jump)) goto $g_CATCHGOTO;} }" >> $g_CFILE
}

#-----------------------------------------------------------

function Handle_Color
{
    local TO FROM BFG COL

    # Check if we have an argument at all
    if [[ "$1" = "COLOR" ]]
    then
	echo -e "\nERROR: empty COLOR at line $g_COUNTER in file '$g_CURFILE'!"
	exit 1
    fi

    # Check if we need to reset
    if [[ "$1" = +(*RESET*) ]]
    then
	echo "fprintf(stdout,\"\033[0m\");" >> $g_CFILE
    elif [[ "$1" = +(*INTENSE*) ]]
    then
	echo "fprintf(stdout,\"\033[1m\");" >> $g_CFILE
    elif [[ "$1" = +(*INVERSE*) ]]
    then
	echo "fprintf(stdout,\"\033[7m\");" >> $g_CFILE
    elif [[ "$1" = +(*NORMAL*) ]]
    then
	echo "fprintf(stdout,\"\033[22m\");" >> $g_CFILE
    # Check if TO is available
    elif [[ "$1" != +(* TO *) ]]
    then
	echo -e "\nERROR: Missing TO in COLOR statement at line $g_COUNTER in file '$g_CURFILE'!"
	exit 1
    else
	# Get the target and colorname
	FROM=`echo ${1%% TO *}`
	case $FROM in
	    FG)
		BFG=3;;
	    BG)
		BFG=4;;
	    [01])
		((BFG=${FROM}+3));;
	    *)
		BFG=${FROM};;
	esac

	TO=`echo ${1##* TO }`
	case $TO in
	    BLACK)
		COL=0;;
	    RED)
		COL=1;;
	    GREEN)
		COL=2;;
	    YELLOW)
		COL=3;;
	    BLUE)
		COL=4;;
	    MAGENTA)
		COL=5;;
	    CYAN)
		COL=6;;
	    WHITE)
		COL=7;;
	    *)
		COL=${TO};;
	esac

	# Now select color
	echo "fprintf(stdout,\"\033[%ld%ldm\", (long)${BFG}, (long)${COL});" >> $g_CFILE
    fi
}

#-----------------------------------------------------------

function Handle_Gotoxy
{
    local X Y

    # Check if we have an argument at all
    if [[ "$1" = "GOTOXY" ]]
    then
	echo -e "\nERROR: empty GOTOXY at line $g_COUNTER in file '$g_CURFILE'!"
	exit 1
    fi

    # Get the target and colorname
    if [[ "$1" = +(*,*) ]]
    then
	X=`echo ${1%%,*}`
	Y=`echo ${1##*,}`
    else
	echo -e "\nERROR: missing coordinate in GOTOXY at line $g_COUNTER in file '$g_CURFILE'!"
	exit 1
    fi

    # Translate to C
    echo "fprintf(stdout, \"\033[%ld;%ldH\",(long)(${Y}),(long)(${X}));fflush(stdout);" >> $g_CFILE
}

#-----------------------------------------------------------

function Handle_Split
{
    local SOURCE REST BY TO SIZE TARGET CHECK

    # Check if we have an argument at all
    if [[ "$1" = "SPLIT" ]]
    then
	echo -e "\nERROR: empty SPLIT at line $g_COUNTER in file '$g_CURFILE'!"
	exit 1
    fi
    
    # Check if BY is available
    if [[ "$1" != +(* BY *) ]]
    then
	echo -e "\nERROR: Missing BY in SPLIT statement at line $g_COUNTER in file '$g_CURFILE'!"
	exit 1
    fi

    # Check if TO is available
    if [[ "$1" != +(* TO *) ]]
    then
	echo -e "\nERROR: Missing TO in SPLIT statement at line $g_COUNTER in file '$g_CURFILE'!"
	exit 1
    fi

    # Check if SIZE is available
    if [[ "$1" != +(* SIZE *) ]]
    then
	echo -e "\nERROR: Missing SIZE in SPLIT statement at line $g_COUNTER in file '$g_CURFILE'!"
	exit 1
    fi

    # Get the source string
    SOURCE=`echo ${1%% BY *}`
    REST=`echo ${1##* BY }`

    BY=`echo ${REST%% TO *}`
    REST=`echo ${REST##* TO }`

    TO=`echo ${REST%% SIZE *}`
    SIZE=`echo ${REST##* SIZE }`

    # Determine target
    if [[ -n $g_FUNCNAME ]]
    then
	TARGET="$g_CFILE $g_HFILE"
    else
	TARGET=$g_HFILE
    fi

    touch $TARGET

    # Variable may not be array, these should be defined with DECLARE
    if [[ "$SIZE" != +(*\[*\]*) && "$SIZE" != +(*.*) ]]
    then
	# Declare variable if not done yet, assuming long
	CHECK=`grep -E "DIR|FILE|int|long|float|double|char|void|STRING|NUMBER|FLOATING" $TARGET | grep -E " $SIZE,| $SIZE;|,$SIZE,|,$SIZE;| $SIZE=| ${SIZE%%\[*}\[|,${SIZE%%\[*}\[" | grep -v " noparse "`
	if [[ -z $CHECK ]]
	then
	    echo "long $SIZE;" >> $g_HFILE
	fi
    fi

    # Translate to C code
    if [[ -n $g_FUNCNAME ]]
    then
	if [[ $g_STRINGARGS != +(*\*\*$TO*) ]]
	then
	    g_STRINGARGS="$g_STRINGARGS char **$TO = NULL; int __b2c__split__$TO = $g_OPTION_BASE;" 
	fi
    else
	if [[ -z `grep "$TO = NULL;" $g_HFILE` ]]
	then
	    echo "char **$TO = NULL; int __b2c__split__$TO = $g_OPTION_BASE;" >> $g_HFILE
	fi
    fi

    # If the split array was used before in a loop, clear it
    echo "if($TO != NULL) {for(__b2c__ctr=$g_OPTION_BASE; __b2c__ctr <= __b2c__split__$TO; __b2c__ctr++) if($TO[__b2c__ctr]!=NULL)" >> $g_CFILE
    echo "{free($TO[__b2c__ctr]);} free($TO); $TO = NULL;} __b2c__split__$TO = $g_OPTION_BASE;" >> $g_CFILE

    # Run the SPLIT code
    echo "if ($SOURCE != NULL && strlen($SOURCE) > 0 && $BY != NULL && strlen($BY) > 0) {__b2c__split_tmp = strdup($SOURCE); __b2c__split_ptr = __b2c__split_tmp; while((__b2c__split = strstr(__b2c__split_tmp, $BY)) != NULL)" >> $g_CFILE
    echo "{if(__b2c__split-__b2c__split_tmp >= 0) {$TO = (char **)realloc($TO, (__b2c__split__$TO + 1) * sizeof(char*)); if(__b2c__split-__b2c__split_tmp == 0){ $TO[__b2c__split__$TO] = calloc(1, sizeof(char)); if(__b2c__collapse == 0) __b2c__split__$TO++;" >> $g_CFILE
    echo "else free($TO[__b2c__split__$TO]);} else $TO[__b2c__split__$TO++] = __b2c__strndup(__b2c__split_tmp, __b2c__split-__b2c__split_tmp);}" >> $g_CFILE
    echo "__b2c__split_tmp = __b2c__split + strlen($BY);} if(strlen(__b2c__split_tmp) >= 0) {$TO = (char **)realloc($TO, (__b2c__split__$TO + 1) * sizeof(char*)); if(strlen(__b2c__split_tmp) == 0)" >> $g_CFILE
    echo "{$TO[__b2c__split__$TO] = calloc(1, sizeof(char)); if (__b2c__collapse == 0) __b2c__split__$TO++; else free($TO[__b2c__split__$TO]);}" >> $g_CFILE
    echo "else $TO[__b2c__split__$TO++] = strdup(__b2c__split_tmp);} free(__b2c__split_ptr);} $SIZE = __b2c__split__$TO - $g_OPTION_BASE; if(__b2c__split__$TO > 0) __b2c__split__$TO--;" >> $g_CFILE

    # Add declared array to array list if we are in a function
    if [[ -n $g_FUNCNAME && $g_STRINGARRAYS != +(*$TO\[*) ]]
    then
	g_STRINGARRAYS="$g_STRINGARRAYS if($TO != NULL) {for(__b2c__ctr=$g_OPTION_BASE; __b2c__ctr<=__b2c__split__$TO; __b2c__ctr++) if($TO[__b2c__ctr]!=NULL){free($TO[__b2c__ctr]);} free($TO);}"
    fi
}

#-----------------------------------------------------------

function Handle_Sort
{
    local STR CHECK DIM TARGET TYPE VAR DOWN

    # Check if we have an argument at all
    if [[ "$1" = "SORT" ]]
    then
	echo -e "\nERROR: empty SORT at line $g_COUNTER in file '$g_CURFILE'!"
	exit 1
    fi

    # Determine target
    if [[ -n $g_FUNCNAME ]]
    then
	TARGET="$g_CFILE $g_HFILE"
    else
	TARGET=$g_HFILE
    fi

    # Check on SIZE argument
    if [[ ${1} = +(* SIZE *) ]]
    then
	DIM=${1##* SIZE }
	VAR=${1%% SIZE *}
    else
	VAR=${1}
    fi

    # Check on DOWN argument
    if [[ ${1} = +(* DOWN*) ]]
    then
	DIM=${DIM%% DOWN}
	VAR=${VAR%% DOWN}
	DOWN="_down"
    else
	DOWN=
    fi

    # Declared before?
    if [[ "${VAR}" = +(*${g_STRINGSIGN}) ]]
    then
	STR=${VAR%${g_STRINGSIGN}*}
	CHECK=`grep -E "char \*${STR}${g_STRINGSIGN}\[" ${TARGET}`
    else
	CHECK=`grep -E "DIR|FILE|int|long|float|double|char|void|STRING|NUMBER|FLOATING" $TARGET | grep -E " ${VAR}" | grep -v " noparse "`
    fi

    # Verify if the array was declared at SPLIT
    if [[ -z ${CHECK} ]]
    then
	CHECK=`grep -E "__b2c__split__${STR}${g_STRINGSIGN}" $TARGET`
	if [[ -z ${CHECK} ]]
	then
	    echo -e "\nERROR: argument to SORT not an array at line $g_COUNTER in file '$g_CURFILE'!"
	    exit 1
	elif [[ -z $DIM ]]
	then
	    DIM="__b2c__split__${VAR}+1"
	fi
    elif [[ -z $DIM ]]
    then
	DIM=${CHECK##*\[}; DIM=${DIM%%\]*}
    fi

    # Check if we have a string
    if [[ "${VAR}" = +(*${g_STRINGSIGN}) ]]
    then
	echo "qsort(&$VAR[$g_OPTION_BASE], ${DIM}-$g_OPTION_BASE, sizeof(char*), __b2c__sortstr$DOWN);" >> $g_CFILE
    # It is a value
    else
	TYPE=${CHECK% *}
	if [[ $TYPE = +(*double*) || $TYPE = +(*FLOATING*) ]]
	then
	    echo "qsort(&$VAR[$g_OPTION_BASE], ${DIM}-$g_OPTION_BASE, sizeof(double), __b2c__sortnrd$DOWN);" >> $g_CFILE
	elif [[ $TYPE = +(*float*) ]]
	then
	    echo "qsort(&$VAR[$g_OPTION_BASE], ${DIM}-$g_OPTION_BASE, sizeof(float), __b2c__sortnrf$DOWN);" >> $g_CFILE
	elif [[ $TYPE = +(*long*) ||  $TYPE = +(*NUMBER*) ]]
	then
	    echo "qsort(&$VAR[$g_OPTION_BASE], ${DIM}-$g_OPTION_BASE, sizeof(long), __b2c__sortnrl$DOWN);" >> $g_CFILE
	else
	    echo "qsort(&$VAR[$g_OPTION_BASE], ${DIM}-$g_OPTION_BASE, sizeof(int), __b2c__sortnri$DOWN);" >> $g_CFILE
	fi
    fi
}

#-----------------------------------------------------------

function Handle_Alias
{
    local ORG NEW

    # Check if we have an argument at all
    if [[ "$1" = "ALIAS" ]]
    then
	echo -e "\nERROR: empty ALIAS at line $g_COUNTER in file '$g_CURFILE'!"
	exit 1
    fi

    # Check if TO is available
    if [[ "$1" != +(* TO *) ]]
    then
	echo -e "\nERROR: missing TO in ALIAS statement at line $g_COUNTER in file '$g_CURFILE'!"
	exit 1
    fi

    # Get the source string
    ORG=`echo ${1%% TO *} | tr -d "\042"`
    NEW=`echo ${1##* TO } | tr -d "\042"`

    echo "#define $NEW $ORG" >> $g_HFILE
    g_IMPORTED="$NEW $g_IMPORTED"
}

#-----------------------------------------------------------

function Handle_Lookup
{
    local SOURCE REST TO SIZE TARGET CHECK

    # Check if we have an argument at all
    if [[ "$1" = "LOOKUP" ]]
    then
	echo -e "\nERROR: empty LOOKUP at line $g_COUNTER in file '$g_CURFILE'!"
	exit 1
    fi

    # Check if TO is available
    if [[ "$1" != +(* TO *) ]]
    then
	echo -e "\nERROR: Missing TO in LOOKUP statement at line $g_COUNTER in file '$g_CURFILE'!"
	exit 1
    fi

    # Check if SIZE is available
    if [[ "$1" != +(* SIZE *) ]]
    then
	echo -e "\nERROR: Missing SIZE in LOOKUP statement at line $g_COUNTER in file '$g_CURFILE'!"
	exit 1
    fi

    # Get the source string
    SOURCE=`echo ${1%% TO *}`
    REST=`echo ${1##* TO }`

    TO=`echo ${REST%% SIZE *}`
    SIZE=`echo ${REST##* SIZE }`

    # Determine target
    if [[ -n $g_FUNCNAME ]]
    then
	TARGET="$g_CFILE $g_HFILE"
    else
	TARGET=$g_HFILE
    fi

    touch $TARGET

    # Variable may not be array, these should be defined with DECLARE
    if [[ "$SIZE" != +(*\[*\]*) && "$SIZE" != +(*.*) ]]
    then
	# Declare variable if not done yet, assuming long
	CHECK=`grep -E "DIR|FILE|int|long|float|double|char|void|STRING|NUMBER|FLOATING" $TARGET | grep -E " $SIZE,| $SIZE;|,$SIZE,|,$SIZE;| $SIZE=| ${SIZE%%\[*}\[|,${SIZE%%\[*}\[" | grep -v " noparse "`
	if [[ -z $CHECK ]]
	then
	    echo "long $SIZE;" >> $g_HFILE
	fi
    fi

    # Translate to C code
    if [[ -n $g_FUNCNAME ]]
    then
	if [[ $g_STRINGARGS != +(*\*\*$TO*) ]]
	then
	    g_STRINGARGS="$g_STRINGARGS char **$TO = NULL; int __b2c__split__$TO = $g_OPTION_BASE;" 
	fi
    else
	if [[ -z `grep "$TO = NULL;" $g_HFILE` ]]
	then
	    echo "char **$TO = NULL; int __b2c__split__$TO = $g_OPTION_BASE;" >> $g_HFILE
	fi
    fi

    # If the split array was used before in a loop, clear it
    echo "if($TO != NULL) {for(__b2c__ctr=$g_OPTION_BASE; __b2c__ctr <= __b2c__split__$TO; __b2c__ctr++) if($TO[__b2c__ctr] != NULL)" >> $g_CFILE
    echo "{free($TO[__b2c__ctr]);} free($TO); $TO = NULL;} __b2c__split__$TO = $g_OPTION_BASE;" >> $g_CFILE

    # Run the LOOKUP code
    echo "for(__b2c__ctr = $g_OPTION_BASE; __b2c__ctr < __b2c__${SOURCE}_idx + $g_OPTION_BASE; __b2c__ctr++)" >> $g_CFILE
    echo "{$TO = (char **)realloc($TO, (__b2c__split__$TO + 1) * sizeof(char*));" >> $g_CFILE
    echo "$TO[__b2c__split__$TO++] = strdup(__b2c__${SOURCE}[__b2c__ctr-$g_OPTION_BASE].key);} $SIZE = __b2c__split__$TO - $g_OPTION_BASE; if(__b2c__split__$TO > 0) __b2c__split__$TO--;" >> $g_CFILE

    # Add declared array to array list if we are in a function
    if [[ -n $g_FUNCNAME && $g_STRINGARRAYS != +(*$TO\[*) ]]
    then
	g_STRINGARRAYS="$g_STRINGARRAYS if($TO != NULL) {for(__b2c__ctr = $g_OPTION_BASE; __b2c__ctr <= __b2c__split__$TO; __b2c__ctr++) if($TO[__b2c__ctr]!=NULL){free($TO[__b2c__ctr]);} free($TO);}"
    fi
}

#-----------------------------------------------------------

function Handle_Relate
{
    local SOURCE TO TARGET CHECK STR

    # Check if we have an argument at all
    if [[ "$1" = "RELATE" ]]
    then
	echo -e "\nERROR: empty RELATE at line $g_COUNTER in file '$g_CURFILE'!"
	exit 1
    fi

    # Check if TO is available
    if [[ "$1" != +(* TO *) ]]
    then
	echo -e "\nERROR: Missing TO in RELATE statement at line $g_COUNTER in file '$g_CURFILE'!"
	exit 1
    fi

    # Get the source string
    SOURCE=`echo ${1%% TO *}`
    TO=`echo ${1##* TO } | tr "," " "`

    # Determine target
    if [[ -n $g_FUNCNAME ]]
    then
	TARGET="$g_CFILE $g_HFILE"
    else
	TARGET=$g_HFILE
    fi

    touch $TARGET

    # Check if variable is declared as ASSOC
    CHECK=`grep -E "__b2c__${SOURCE}_type" $TARGET`
    if [[ -z $CHECK ]]
    then
	echo -e "\nERROR: Variable '$SOURCE' not declared as ASSOC in RELATE statement at line $g_COUNTER in file '$g_CURFILE'!"
	exit 1
    fi

    # Assign relations
    for STR in ${TO}
    do
	CHECK=`grep -E "__b2c__${STR}_type" $TARGET`
	if [[ -z $CHECK ]]
	then
	    echo -e "\nERROR: Variable '$STR' not declared as ASSOC in RELATE statement at line $g_COUNTER in file '$g_CURFILE'!"
	    exit 1
	fi
	g_RELATE[${g_RELATE_CTR}]="$SOURCE ${STR}"
	((g_RELATE_CTR+=1))
    done
}

#-----------------------------------------------------------

function Handle_Data
{
    local LINE VAR LEN IN_STRING CHAR ESCAPED

    # Check if we have an argument at all
    if [[ "$1" = "DATA" ]]
    then
	echo -e "\nERROR: empty DATA at line $g_COUNTER in file '$g_CURFILE'!"
	exit 1
    fi

    # Start miniparser to see if we need to print something, convert spaces
    LINE=`echo "${1}" | tr " " "\001"`
    VAR=
    LEN=${#LINE}
    IN_STRING=0

    # Get the characters
    until [[ $LEN -eq 0 ]]
    do
	CHAR="${LINE:0:1}"
	case $CHAR in
	    ",")
		if [[ $IN_STRING -eq 0 ]]
		then
		    # Check if var is string var
		    if [[ "${VAR}" = +(*${g_DQUOTESIGN}*) ]]
		    then
			echo "${VAR}, " >> $STRINGARRAYFILE
		    else
			echo "${VAR}, " >> $FLOATARRAYFILE
		    fi
		    VAR=
		    CHAR=
		    ESCAPED=0
		fi;;
	    "\\")
		ESCAPED=1;;
	    "\"")
		if [[ $ESCAPED -eq 0 ]]
		then
		    if [[ $IN_STRING -eq 0 ]]
		    then
			IN_STRING=1
		    else
			IN_STRING=0
		    fi
		fi
		ESCAPED=0;;
	    *)
		ESCAPED=0;;
	esac
	# Convert back to space
	if [[ "${CHAR}" = "${g_PARSEVAR}" ]]
	then
	    VAR="${VAR} "
	else
	    VAR="${VAR}${CHAR}"
	fi
	let LEN=${#LINE}-1
	LINE="${LINE: -$LEN}"
    done

    # Write last element to file
    if [[ "${VAR}" = +(*${g_DQUOTESIGN}*) ]]
    then
	echo "${VAR}, " >> $STRINGARRAYFILE
    else
	echo "${VAR}, " >> $FLOATARRAYFILE
    fi
}

#-----------------------------------------------------------
#
# Simple parser to tokenize line.
#
# Each line should begin with a statement.
# The rest of the line may contain functions, these are
#   converted using C macros.
#
#-----------------------------------------------------------

function Parse_Line
{
    local FOUND SYM INC COPY_COUNTER COPY_CURFILE STATEMENT
    local LEN SEQ TOTAL EXP LINE TO_PARSE

    # Get statement without spaces
    STATEMENT=`echo "${1%% *}"`

    # Check if enclosed IF/ELIF/ELSE needs to be closed
    if [[ $g_IF_PARSE -eq 1 ]]
    then
	if [[ "${STATEMENT}" != +(ELIF*) && "${STATEMENT}" != +(ELSE*) ]]
	then
	    echo "}" >> $g_CFILE
	    g_IF_PARSE=0
	fi
    fi

    # In TRACE MODE show linenr and code
    if [[ $g_TRACE -eq 1 && ${1} != +(*FUNCTION *) && ${1} != +(*SUB *) ]]
    then
	echo "if(__b2c__getch() == 27) exit(EXIT_SUCCESS); /* noparse */" >> $g_CFILE
	LINE=`echo "${1}" | tr "\042" "\047"`
	echo "fprintf(stderr, \"${g_CURFILE} %d: ${LINE}\n\", $g_COUNTER); /* noparse */" >> $g_CFILE
    fi

    # See if we need to pass C code
    if [[ $g_USE_C -eq 1 ]]
    then
	if [[ "${STATEMENT}" = "END" || "${STATEMENT}" = "ENDUSEC" ]]
	then
	    let g_USE_C=0
	else
	    echo "${1}" >> $g_CFILE
	fi
    else
	case "${STATEMENT}" in
	    "USEC")
		let g_USE_C=1;;
	    "PRINT")
		Handle_Print "${1#* }";;
	    "INPUT")
		Handle_Input "${1#* }";;
	    "FOR")
                ((g_LOOPCTR+=1))
		Handle_For "${1#* }";;
	    "NEXT")
		echo "}" >> $g_CFILE
                if [[ $g_LOOPCTR -gt 0 ]]
                then
                    ((g_LOOPCTR-=1))
                    if [[ $g_LOOPCTR -gt 0 ]]
                    then
                        echo "if(__b2c__break_ctr) {__b2c__break_ctr--; if (!__b2c__break_ctr){if(__b2c__break_flag == 1) break; else continue;} else break; }" >> $g_CFILE
                    fi
                fi;;
	    "IF")
		g_IF_PARSE=0
		# Check if THEN is available
		if [[ "$1" != +(* THEN*) ]]
		then
		    echo -e "\nERROR: Missing THEN in IF statement at line $g_COUNTER in file '$g_CURFILE'!"
		    exit 1
		else
		    SYM="${1#* }"
		    # Translate function to C function
                    Parse_Equation "${SYM% THEN*}"
		    echo "if(${g_EQUATION}){" >> $g_CFILE
		    if [[ ${SYM##* THEN } != +(*THEN*) ]]
		    then
			Tokenize "${SYM##* THEN }"
			g_IF_PARSE=1
		    fi
		fi;;
	    "ELIF")
		g_IF_PARSE=0
		# Check if THEN is available
		if [[ "$1" != +(* THEN*) ]]
		then
		    echo -e "\nERROR: Missing THEN in ELIF statement at line $g_COUNTER in file '$g_CURFILE'!"
		    exit 1
		else
		    SYM="${1#* }"
		    # Translate function to C function
                    Parse_Equation "${SYM% THEN*}"
		    echo "} else if(${g_EQUATION}){" >> $g_CFILE
		    if [[ ${SYM##* THEN } != +(*THEN*) ]]
		    then
			Tokenize "${SYM##* THEN }"
			g_IF_PARSE=1
		    fi
		fi;;
	    "ELSE")
		g_IF_PARSE=0
		echo "} else {" >> $g_CFILE
		if [[ ${1##*ELSE } != +(*ELSE*) ]]
		then
		    Tokenize "${1##*ELSE }"
		    g_IF_PARSE=1
		fi;;
	    "ENDIF")
		echo "}" >> $g_CFILE;;
	    "WHILE")
                ((g_LOOPCTR+=1))
		Handle_While "${1#* }";;
	    "WEND")
		echo "}" >> $g_CFILE
                if [[ $g_LOOPCTR -gt 0 ]]
                then
                    ((g_LOOPCTR-=1))
                    if [[ $g_LOOPCTR -gt 0 ]]
                    then
                        echo "if(__b2c__break_ctr) {__b2c__break_ctr--; if (!__b2c__break_ctr){if(__b2c__break_flag == 1) break; else continue;} else break; }" >> $g_CFILE
                    fi
                fi;;
	    "BREAK")
                # Check argument
		if [[ "${1%% *}" != "${1#* }" && ${1#* } != "0" ]]
		then
                    echo "__b2c__break_ctr = ${1#* }-1; __b2c__break_flag = 1;" >> $g_CFILE
                fi
		echo "break;" >> $g_CFILE;;
            "CONTINUE")
                # Check argument
		if [[ "${1%% *}" != "${1#* }" && ${1#* } != "0" ]]
		then
                    echo "__b2c__break_ctr = ${1#* }-1; __b2c__break_flag = 2;" >> $g_CFILE
                fi
                if [[ ${1#* } -gt 1 ]]
                then
		    echo "break;" >> $g_CFILE
                else
		    echo "continue;" >> $g_CFILE
                fi;;
	    "REPEAT")
                ((g_LOOPCTR+=1))
		echo "do{" >> $g_CFILE;;
	    "UNTIL")
		# Check argument
		if [[ "${1%% *}" = "${1#* }" ]]
		then
		    echo -e "\nERROR: empty UNTIL at line $g_COUNTER in file '$g_CURFILE'!"
		    exit 1
		else
		    # Convert to legal C code
                    Parse_Equation "${1#* }"
		    echo "} while(!(${g_EQUATION}));" >> $g_CFILE
                    if [[ $g_LOOPCTR -gt 0 ]]
                    then
                        ((g_LOOPCTR-=1))
                        if [[ $g_LOOPCTR -gt 0 ]]
                        then
                            echo "if(__b2c__break_ctr) {__b2c__break_ctr--; if (!__b2c__break_ctr){if(__b2c__break_flag == 1) break; else continue;} else break; }" >> $g_CFILE
                        fi
                    fi
		fi;;
	    "LET")
		Handle_Let "${1#* }";;
	    +(REM*) )
		;;
	    +(\'*) )
		;;
	    "SYSTEM")
		# Check argument
		if [[ "${1%% *}" = "${1#* }" ]]
		then
		    echo -e "\nERROR: empty SYSTEM at line $g_COUNTER in file '$g_CURFILE'!"
		    exit 1
		else
		    echo "SYSTEM (${1#* });" >> $g_CFILE
		fi;;
	    "SLEEP")
		# Check argument
		if [[ "${1%% *}" = "${1#* }" ]]
		then
		    echo -e "\nERROR: empty SLEEP at line $g_COUNTER in file '$g_CURFILE'!"
		    exit 1
		else
		    echo "usleep(${1#* }*1000);" >> $g_CFILE
		fi;;
	    "OPEN")
		Handle_Open "${1#* }";;
	    "CLOSE")
		# Check argument
		if [[ "${1%% *}" = "${1#* }" ]]
		then
		    echo -e "\nERROR: empty CLOSE at line $g_COUNTER in file '$g_CURFILE'!"
		    exit 1
		else
		    if [[ "$1" = +(* FILE *) ]]
		    then
			echo "fclose(${1##* });" >> $g_CFILE
		    elif [[ "$1" = +(* DIRECTORY *) ]]
		    then
			echo "closedir(${1##* });" >> $g_CFILE
		    elif [[ "$1" = +(* MEMORY *) ]]
		    then
			echo "${1##* } = NULL;" >> $g_CFILE
		    elif [[ "$1" = +(* NETWORK *) || "$1" = +(* SERVER *) ]]
		    then
			echo "close(${1##* });" >> $g_CFILE
		    else
			echo -e "\nERROR: erronuous CLOSE argument at line $g_COUNTER in file '$g_CURFILE'!"
			exit 1
		    fi
		fi;;
	    "REWIND")
		# Check argument
		if [[ "${1%% *}" = "${1#* }" ]]
		then
		    echo -e "\nERROR: empty REWIND at line $g_COUNTER in file '$g_CURFILE'!"
		    exit 1
		else
		    echo "rewind(${1#* });" >> $g_CFILE
		fi;;
	    "MEMREWIND")
		# Check argument
		if [[ "${1%% *}" = "${1#* }" ]]
		then
		    echo -e "\nERROR: empty MEMREWIND at line $g_COUNTER in file '$g_CURFILE'!"
		    exit 1
		else
		    echo "${1#* } = (char*)__b2c_mem_${1#* };" >> $g_CFILE
		fi;;
	    "SEEK")
		Handle_Seek "${1#* }";;
	    "READLN")
		Handle_Readln "${1#* }";;
	    "WRITELN")
		Handle_Writeln "${1#* }";;
	    "GETBYTE")
		Handle_Getbyte "${1#* }";;
	    "PUTBYTE")
		Handle_Putbyte "${1#* }";;
	    "GETFILE")
		Handle_Getfile "${1#* }";;
	    "GETLINE")
		Handle_Getline "${1#* }";;
	    "PUTLINE")
		Handle_Putline "${1#* }";;
	    "END")
		if [[ "${1#* }" = +(*IF*) ]]
		then
		    echo "}" >> $g_CFILE
		elif [[ "${1#* }" = +(*RECORD*) ]]
		then
		    if [[ -n $g_FUNCNAME ]]
		    then
			echo "};" >> $g_CFILE
			echo "struct $g_RECORDNAME $g_RECORDVAR = { } ;" >> $g_CFILE
		    else
			echo "};" >> $g_HFILE
			echo "struct $g_RECORDNAME $g_RECORDVAR = { } ;" >> $g_HFILE
		    fi
		    g_RECORDNAME=
		    g_RECORDVAR=
		    # Restore function name if GLOBAL was used
		    if [[ -n $g_RECORDCACHE ]]
		    then
			g_FUNCNAME=$g_RECORDCACHE
			g_RECORDCACHE=
		    fi
		elif [[ "${1#* }" = +(*FUNCTION*) ]]
		then
		    Handle_Endfunction
		elif [[ "${1#* }" = +(*SUB*) ]]
		then
		    Handle_Endsub
		elif [[ "${1#* }" = +(*WITH*) ]]
		then
		    g_WITHVAR=
		elif [[ "${1#* }" = +(*SELECT*) ]]
		then
		    if [[ $g_SELECTVAR_CTR -eq 0 ]]
		    then
			echo -e "\nERROR: invalid END SELECT at line $g_COUNTER in file '$g_CURFILE'!"
			exit 1
		    else
			echo "}" >> $g_CFILE
			g_SELECTVAR[$g_SELECTVAR_CTR]=
			g_IN_CASE[$g_SELECTVAR_CTR]=
			g_CASE_FALL=
			((g_SELECTVAR_CTR-=1))
		    fi
		elif [[ "${1#* }" != "END" ]]
		then
		    echo "exit(${1#* });" >> $g_CFILE
		else
		    echo "exit(EXIT_SUCCESS);" >> $g_CFILE
		fi;;
	    "SUB")
		Handle_SubFunc "${1#* }";;
	    "ENDSUB")
		Handle_Endsub;;
	    "ENDWITH")
		g_WITHVAR=;;
	    "ENDSELECT")
		if [[ $g_SELECTVAR_CTR -eq 0 ]]
		then
		    echo -e "\nERROR: invalid END SELECT at line $g_COUNTER in file '$g_CURFILE'!"
		    exit 1
		else
		    echo "}" >> $g_CFILE
		    g_SELECTVAR[$g_SELECTVAR_CTR]=
		    g_IN_CASE[$g_SELECTVAR_CTR]=
		    g_CASE_FALL=
		    ((g_SELECTVAR_CTR-=1))
		fi;;
	    "CALL")
		# Check argument
		if [[ "${1%% *}" = "${1#* }" ]]
		then
		    echo -e "\nERROR: empty CALL at line $g_COUNTER in file '$g_CURFILE'!"
		    exit 1
		else
		    SYM=`echo "${1#* }"`
		    if [[ "$SYM" = +(* TO *) ]]
		    then
			if [[ "${SYM##*TO }" = +(*${g_STRINGSIGN}) ]]
			then
			    echo "${SYM##*TO } = realloc(${SYM##*TO }, (strlen(${SYM%% TO*})+1)*sizeof(char));" >> $g_CFILE
			    echo "strcpy(${SYM##*TO }," >> $g_CFILE
			else
			    echo "${SYM##*TO } = " >> $g_CFILE
			fi
			if [[ "${SYM%% TO*}" = +(*\(*\)*) ]]
			then
			    echo "${SYM%% TO*}" >> $g_CFILE
			else
			    echo "${SYM%% TO*}()" >> $g_CFILE
			fi
			if [[ "${SYM##*TO }" = +(*${g_STRINGSIGN}) ]]
			then
			    echo ");" >> $g_CFILE
			else
			    echo ";" >> $g_CFILE
			fi
		    else
			if [[ "$SYM" = +(*\(*\)*) ]]
			then
			    echo "$SYM;" >> $g_CFILE
			else
			    echo "$SYM();" >> $g_CFILE
			fi
		    fi
		fi;;
	    "FUNCTION")
		Handle_SubFunc "${1#* }";;
	    "ENDFUNCTION")
		Handle_Endfunction;;
	    "RETURN")
		Handle_Return "${1#* }";;
	    "IMPORT")
		Handle_Import "${1#* }";;
	    "DECLARE")
		Handle_Declare "${1#* }";;
	    "GLOBAL")
		Handle_Declare "${1#* }";;
	    "LOCAL")
		Handle_Local "${1#* }";;
	    "DATA")
		Handle_Data "${1#* }";;
	    "RESTORE")
		echo "if(__b2c__floatarray_ptr > 0) __b2c__floatarray_ptr = 0;" >> $g_CFILE
		echo "if(__b2c__stringarray_ptr > 0) __b2c__stringarray_ptr = 0;" >> $g_CFILE;;
	    "READ")
		Handle_Read "${1#* }";;
	    "PUSH")
		Handle_Push "${1#* }";;
	    "PULL")
		Handle_Pull "${1#* }";;
	    "SEED")
		# Check argument
		if [[ "${1%% *}" = "${1#* }" ]]
		then
		    echo -e "\nERROR: empty SEED at line $g_COUNTER in file '$g_CURFILE'!"
		    exit 1
		else
		    echo "srandom((unsigned int)${1#* });" >> $g_CFILE
		fi;;
	    "DEF")
		Handle_Deffn "${1#* }";;
	    "CONST")
		Handle_Const "${1#* }";;
	    "INCLUDE")
		# Get rid of doublequotes if they are there
		INC=`echo ${1#* } | tr -d "\042"`
		# Check argument
		if [[ ! -f ${INC%%,*} || "${1%% *}" = "${1#* }" ]]
		then
		    echo -e "\nERROR: missing file '${INC%%,*}' for INCLUDE at line $g_COUNTER in file '$g_CURFILE'!"
		    exit 1
		else
		    TO_PARSE=0
		    # See if there are arguments
		    if [[ ${INC} = +(*,*) ]]
		    then
			EXP=`echo ${INC#*,} | tr "," " " | tr -d "${g_STRINGSIGN}"`
			INC=${INC%%,*}
		    else
			TO_PARSE=2
		    fi
		    # Start walking through program
		    COPY_COUNTER=$g_COUNTER
		    g_COUNTER=1
		    # Assign new file
		    COPY_CURFILE=$g_CURFILE
		    # Get rid of absolute path
		    g_CURFILE=${INC##*/}
		    while read -r LINE
		    do
			echo -e -n "\rStarting conversion... $g_COUNTER"
			# See if we need to enable flag
			for SYM in ${EXP}
			do
			    if [[ $TO_PARSE -eq 0 && "${LINE#* }" = +(${SYM%${g_STRINGSIGN}*}*) && "${LINE}" = +(*SUB*|*FUNCTION*) || "${LINE}" = +(*INCLUDE) ]]
			    then
				TO_PARSE=1
				break
			    fi
			done
			# Line is not empty?
			if [[ -n "$LINE" && $TO_PARSE -gt 0 ]]
			then
			    if [[ "$LINE" = +(* \\) && "$LINE" != +(REM*) && "$LINE" != +(${g_SQUOTESIGN}*) ]]
			    then
				let LEN="${#LINE}"-2
				SEQ="${LINE:0:$LEN}"
				TOTAL=$TOTAL$SEQ
			    else
				echo "/* noparse $INC BACON LINE $g_COUNTER */" >> $g_CFILE
				echo "/* noparse $INC BACON LINE $g_COUNTER */" >> $g_HFILE
				TOTAL="${TOTAL}${LINE}"
				if [[ "${TOTAL}" != +(REM*) && "${TOTAL}" != +(${g_SQUOTESIGN}*) ]]
				then
				    Tokenize "${TOTAL}"
				fi
				TOTAL=
			    fi
			fi
			# See if we need to stop parsing
			if [[ $TO_PARSE -eq 1 && "${LINE}" = +(*END*) && "${LINE}" = +(*SUB*|*FUNCTION*) ]]
			then
			    TO_PARSE=0
			fi
			# Increase line number
			((g_COUNTER+=1))
		    done < $INC
		    # Restore original counter
		    g_COUNTER=$COPY_COUNTER
		    # Restore original file
		    g_CURFILE=$COPY_CURFILE
		fi;;
	    "POKE")
		# Check argument
		if [[ "${1%% *}" = "${1#* }" ]]
		then
		    echo -e "\nERROR: empty POKE at line $g_COUNTER in file '$g_CURFILE'!"
		    exit 1
		else
		    SYM=${1#* }
		    echo "if (!__b2c__trap){__b2c__memory__check((char*)${SYM%%,*}); if(ERROR) {fprintf(stderr, \"%s\n\", ERR${g_STRINGSIGN}(ERROR)); exit(ERROR);} }" >> $g_CFILE
		    echo "*(${g_OPTION_MEMTYPE}*)(${SYM%%,*}) = (${g_OPTION_MEMTYPE})${SYM#*,};" >> $g_CFILE
		fi;;
	    "RESIZE")
	    	# Check argument
		if [[ "${1%% *}" = "${1#* }" ]]
		then
		    echo -e "\nERROR: empty RESIZE at line $g_COUNTER in file '$g_CURFILE'!"
		    exit 1
		else
		    # Resolve this with C macro because of casting to (char)
		    SYM=${1#* }
		    echo "${SYM%%,*}=(long)RESIZE(${SYM});" >> $g_CFILE
		fi;;
	    "COPY")
		Handle_Copy "${1#* }";;
	    "DELETE")
		# Check argument
		if [[ "${1%% *}" = "${1#* }" ]]
		then
		    echo -e "\nERROR: empty DELETE at line $g_COUNTER in file '$g_CURFILE'!"
		    exit 1
		else
		    # Translate to C function
		    if [[ "${1#* }" = +(*FILE*) ]]
		    then
			echo "if (unlink(${1#*FILE })==-1){if(!__b2c__trap){ERROR = 7;if(!__b2c__catch_set){fprintf(stderr, \"%s\n\", ERR${g_STRINGSIGN}(ERROR)); exit(ERROR);} if(!setjmp(__b2c__jump)) goto $g_CATCHGOTO;} }" >> $g_CFILE
		    elif [[ "${1#* }" = +(*DIRECTORY*) ]]
		    then
			 echo "if (rmdir(${1#*DIRECTORY }) == -1){if(!__b2c__trap){ERROR = 20;if(!__b2c__catch_set){fprintf(stderr, \"%s\n\", ERR${g_STRINGSIGN}(ERROR)); exit(ERROR);} if(!setjmp(__b2c__jump)) goto $g_CATCHGOTO;} }" >> $g_CFILE
		    else
			echo "\nERROR: erronuous argument for DELETE at line $g_COUNTER in file '$g_CURFILE'!"
			exit 1
		    fi
		fi;;
	    "RENAME")
		Handle_Rename "${1#* }";;
	    "MAKEDIR")
		# Check argument
		if [[ "${1%% *}" = "${1#* }" ]]
		then
		    echo -e "\nERROR: empty MAKEDIR at line $g_COUNTER in file '$g_CURFILE'!"
		    exit 1
		else
		    # Translate to C function
		    echo "if (__b2c__makedir(${1#* }) != 0){if(!__b2c__trap){ERROR = 21;if(!__b2c__catch_set){fprintf(stderr, \"%s\n\", ERR${g_STRINGSIGN}(ERROR)); exit(ERROR);} if(!setjmp(__b2c__jump)) goto $g_CATCHGOTO;} }" >> $g_CFILE
		fi;;
	    "CHANGEDIR")
		# Check argument
		if [[ "${1%% *}" = "${1#* }" ]]
		then
		    echo -e "\nERROR: empty CHANGEDIR at line $g_COUNTER in file '$g_CURFILE'!"
		    exit 1
		else
		    # Translate to C function
		    echo "if (chdir(${1#* }) == -1){if(!__b2c__trap) {ERROR = 22;if(!__b2c__catch_set){fprintf(stderr, \"%s\n\", ERR${g_STRINGSIGN}(ERROR)); exit(ERROR);} if(!setjmp(__b2c__jump)) goto $g_CATCHGOTO;} }" >> $g_CFILE
		fi;;
	    "FREE")
		# Check argument
		if [[ "${1%% *}" = "${1#* }" ]]
		then
		    echo -e "\nERROR: empty FREE at line $g_COUNTER in file '$g_CURFILE'!"
		    exit 1
		else
		    # Translate to C function
		    if [[ ${1#* } = +(*\(*\)*) ]]
		    then
			EXP=${1#* }
			if [[ $EXP = +(*${g_STRINGSIGN}*) ]]
			then
			    echo "if(__b2c__${EXP%%\(*}_exist(${1#*\(} != NULL) {free(__b2c__${EXP%%\(*}_exist(${1#*\(}->value); __b2c__${EXP%%\(*}_exist(${1#*\(}->value = NULL; __b2c__${EXP%%\(*}__del(${1#*\(};}" >> $g_CFILE
			else
			    echo "if(__b2c__${EXP%%\(*}_exist(${1#*\(} != NULL) {__b2c__${EXP%%\(*}_exist(${1#*\(}->value = 0; __b2c__${EXP%%\(*}__del(${1#*\(}; }" >> $g_CFILE
			fi
		    else
			echo "if(!__b2c__trap){__b2c__memory__check((char *)${1#* });" >> $g_CFILE
			echo "if(ERROR) {if(!__b2c__catch_set){fprintf(stderr, \"%s\n\", ERR${g_STRINGSIGN}(ERROR)); exit(ERROR);} if(!setjmp(__b2c__jump)) goto $g_CATCHGOTO;} } free((void*)${1#* });" >> $g_CFILE
		    fi
		fi;;
	    "GOTO")
		# Check argument
		if [[ "${1%% *}" = "${1#* }" ]]
		then
		    echo -e "\nERROR: empty GOTO at line $g_COUNTER in file '$g_CURFILE'!"
		    exit 1
		else
		    # Translate to C label
		    echo "goto ${1#* };" >> $g_CFILE
		fi;;
	    "LABEL")
		# Check argument
		if [[ "${1%% *}" = "${1#* }" ]]
		then
		    echo -e "\nERROR: empty LABEL at line $g_COUNTER in file '$g_CURFILE'!"
		    exit 1
		else
		    # Translate to C label
		    echo "${1#* }:" >> $g_CFILE
		    echo ";" >> $g_CFILE
		fi;;
	    "TRAP")
		# Check argument
		if [[ "${1%% *}" = "${1#* }" ]]
		then
		    echo -e "\nERROR: empty TRAP at line $g_COUNTER in file '$g_CURFILE'!"
		    exit 1
		else
		    if [[ "${1#* }" = "SYSTEM" ]]
		    then
			echo "/* Error catching is enabled */" >> $g_CFILE
			echo "__b2c__trap = 1;" >> $g_CFILE
			echo "signal(SIGILL, __b2c__catch_signal);" >> $g_CFILE
			echo "signal(SIGABRT, __b2c__catch_signal);" >> $g_CFILE
			echo "signal(SIGFPE, __b2c__catch_signal);" >> $g_CFILE
			echo "signal(SIGSEGV, __b2c__catch_signal);" >> $g_CFILE
		    elif [[ "${1#* }" = "LOCAL" ]]
		    then
			echo "/* Error catching is disabled */" >> $g_CFILE
			echo "__b2c__trap = 0;" >> $g_CFILE
			echo "signal(SIGILL, SIG_DFL);" >> $g_CFILE
			echo "signal(SIGABRT, SIG_DFL);" >> $g_CFILE
			echo "signal(SIGFPE, SIG_DFL);" >> $g_CFILE
			echo "signal(SIGSEGV, SIG_DFL);" >> $g_CFILE
		    else
			echo -e "\nERROR: invalid argument for TRAP at line $g_COUNTER in file '$g_CURFILE'!"
			exit 1
		    fi
		fi;;
	    "CATCH")
		# Check argument
		if [[ "${1%% *}" = "${1#* }" ]]
		then
		    echo -e "\nERROR: empty CATCH at line $g_COUNTER in file '$g_CURFILE'!"
		    exit 1
		elif [[ "${1#* }" = +(*GOTO*) ]]
		then
		    echo "__b2c__catch_set = 1;" >> $g_CFILE
		    g_CATCHGOTO="${1##* GOTO }"
		elif [[ "${1#* }" = +(*RESET*) ]]
		then
		    echo "__b2c__catch_set = 0;" >> $g_CFILE
		    g_CATCHGOTO="__B2C__PROGRAM__EXIT"
		else
		    echo -e "\nERROR: CATCH without GOTO or RESET at line $g_COUNTER in file '$g_CURFILE'!"
		    exit 1
		fi;;
	    "RESUME")
		echo "longjmp(__b2c__jump, 1);" >> $g_CFILE;;
	    "CLEAR")
		echo "fprintf(stdout,\"\033[2J\"); fprintf(stdout,\"\033[0;0f\");fflush(stdout);" >> $g_CFILE;;
	    "COLOR")
		Handle_Color "${1#* }";;
	    "GOTOXY")
		Handle_Gotoxy "${1#* }";;
	    "RECEIVE")
		Handle_Receive "${1#* }";;
	    "SEND")
		Handle_Send "${1#* }";;
	    "RECORD")
	    	# Check argument
		if [[ "${1%% *}" = "${1#* }" ]]
		then
		    echo -e "\nERROR: empty RECORD at line $g_COUNTER in file '$g_CURFILE'!"
		    exit 1
		elif [[ -n $g_RECORDNAME ]]
		then
		    echo -e "\nERROR: cannot define a record within a record!"
		    exit 1
		else
		    # Translate to C typedef struct
		    if [[ -n $g_FUNCNAME ]]
		    then
			g_RECORDNAME="RECORD_${g_FUNCNAME}_${g_COUNTER}"
			echo "struct $g_RECORDNAME{" >> $g_CFILE
		    else
			g_RECORDNAME="RECORD_${g_COUNTER}"
			echo "struct $g_RECORDNAME{" >> $g_HFILE
		    fi
		    g_RECORDVAR=${1#* }
		fi;;
	    "WITH")
	    	# Check argument
		if [[ "${1%% *}" = "${1#* }" ]]
		then
		    echo -e "\nERROR: empty WITH at line $g_COUNTER in file '$g_CURFILE'!"
		    exit 1
		elif [[ -n $g_RECORDNAME ]]
		then
		    echo -e "\nERROR: cannot define a WITH within a WITH!"
		    exit 1
		else
		    g_WITHVAR=${1#* }
		fi;;
	    "SPLIT")
		Handle_Split "${1#* }";;
	    "SELECT")
	    	# Check argument
		if [[ "${1%% *}" = "${1#* }" ]]
		then
		    echo -e "\nERROR: empty SELECT at line $g_COUNTER in file '$g_CURFILE'!"
		    exit 1
		else
		    ((g_SELECTVAR_CTR+=1))
		    g_SELECTVAR[$g_SELECTVAR_CTR]=${1#* }
		    g_IN_CASE[$g_SELECTVAR_CTR]=
		    g_CASE_FALL=
		fi;;
	    "CASE")
	    	# Check argument
		if [[ "${1%% *}" = "${1#* }" ]]
		then
		    echo "\nERROR: empty CASE at line $g_COUNTER in file '$g_CURFILE'!"
		    exit 1
		else
		    if [[ -n ${g_IN_CASE[$g_SELECTVAR_CTR]} ]]
		    then
			if [[ ${g_SELECTVAR[$g_SELECTVAR_CTR]} = +(*${g_STRINGSIGN}*) ]]
			then
			    # Get expression without ;
			    if [[ -z ${1##*;} ]]
			    then
				let LEN="${#1}"-1; EXP="${1:0:$LEN}"
				g_CASE_FALL="|| !strcmp(${g_SELECTVAR[$g_SELECTVAR_CTR]}, ${EXP#* }) ${g_CASE_FALL}"
			    else
				echo "} else if (!strcmp(${g_SELECTVAR[$g_SELECTVAR_CTR]}, ${1#* }) ${g_CASE_FALL}){" >> $g_CFILE
				g_CASE_FALL=
			    fi
			else
			    # Get expression without ;
			    if [[ -z ${1##*;} ]]
			    then
				let LEN="${#1}"-1; EXP="${1:0:$LEN}"
				g_CASE_FALL="|| ${g_SELECTVAR[$g_SELECTVAR_CTR]} == (${EXP#* }) ${g_CASE_FALL}"
			    else
				echo "} else if (${g_SELECTVAR[$g_SELECTVAR_CTR]} == (${1#* }) ${g_CASE_FALL}){" >> $g_CFILE
				g_CASE_FALL=
			    fi
			fi
		    else
			if [[ ${g_SELECTVAR[$g_SELECTVAR_CTR]} = +(*${g_STRINGSIGN}*) ]]
			then
			    # Get expression without ;
			    if [[ -z ${1##*;} ]]
			    then
				let LEN="${#1}"-1; EXP="${1:0:$LEN}"
				g_CASE_FALL="|| !strcmp(${g_SELECTVAR[$g_SELECTVAR_CTR]}, ${EXP#* }) ${g_CASE_FALL}"
			    else
				echo "if (!strcmp(${g_SELECTVAR[$g_SELECTVAR_CTR]}, ${1#* }) ${g_CASE_FALL}){" >> $g_CFILE
				g_IN_CASE[$g_SELECTVAR_CTR]=1
				g_CASE_FALL=
			    fi
			else
			    # Get expression without ;
			    if [[ -z ${1##*;} ]]
			    then
				let LEN="${#1}"-1; EXP="${1:0:$LEN}"
				g_CASE_FALL="|| ${g_SELECTVAR[$g_SELECTVAR_CTR]} == (${EXP#* }) ${g_CASE_FALL}"
			    else
				echo "if (${g_SELECTVAR[$g_SELECTVAR_CTR]} == (${1#* }) ${g_CASE_FALL}){" >> $g_CFILE
				g_IN_CASE[$g_SELECTVAR_CTR]=1
				g_CASE_FALL=
			    fi
			fi
		    fi
		fi;;
	    "DEFAULT")
		if [[ -n ${g_IN_CASE[$g_SELECTVAR_CTR]} ]]
		then
		    echo "} else {" >> $g_CFILE
		else
		    echo -e "\nERROR: cannot use DEFAULT without previous CASE at line $g_COUNTER in file '$g_CURFILE'!"
		    exit 1
		fi
		g_IN_CASE[$g_SELECTVAR_CTR]=
		g_CASE_FALL=;;
	    "SETENVIRON")
		# Check argument
		if [[ "${1%% *}" = "${1#* }" ]]
		then
		    echo -e "\nERROR: empty SETENVIRON at line $g_COUNTER in file '$g_CURFILE'!"
		    exit 1
		else
		    # Resolve this with C macro
		    echo "SETENVIRON(${1#* });" >> $g_CFILE
		fi;;
	    "SORT")
		Handle_Sort "${1#* }";;
	    "STOP")
		echo "kill(getpid(), SIGSTOP);" >> $g_CFILE
		;;
	    "TRACE")
		# Check argument
		if [[ "${1%% *}" = "${1#* }" ]]
		then
		    echo -e "\nERROR: empty TRACE at line $g_COUNTER in file '$g_CURFILE'!"
		    exit 1
		else
		    if [[ "${1#* }" = +(*ON*) ]]
		    then
			g_TRACE=1
		    elif [[ "${1#* }" = +(*OFF*) ]]
		    then
			g_TRACE=0
		    fi
		fi;;
	    "OPTION")
		# Check argument
		if [[ "${1%% *}" = "${1#* }" ]]
		then
		    echo -e "\nERROR: empty OPTION at line $g_COUNTER in file '$g_CURFILE'!"
		    exit 1
		else
		    if [[ "${1#* }" = +(*BASE*) ]]
		    then
			if [[ "${1##*BASE }" = +([0123456789]) ]]
			then
			    g_OPTION_BASE=${1##*BASE }
			else
			    echo -e "\nERROR: invalid argument to OPTION BASE at line $g_COUNTER in file '$g_CURFILE'!"
			    exit 1
			fi
		    elif [[ "${1#* }" = +(*COMPARE*) ]]
		    then
			if [[ "${1##*COMPARE }" = +([01]|TRUE|FALSE) ]]
			then
			    echo "__b2c__option_compare = ${1##*COMPARE };" >> $g_CFILE
			else
			    echo -e "\nERROR: invalid argument to OPTION COMPARE at line $g_COUNTER in file '$g_CURFILE'!"
			    exit 1
			fi
		    elif [[ "${1#* }" = +(*SOCKET*) ]]
		    then
			if [[ "${1##*SOCKET }" = +([0123456789]) ]]
			then
			    g_OPTION_SOCKET=${1##*SOCKET }
			else
			    echo -e "\nERROR: invalid argument to OPTION SOCKET at line $g_COUNTER in file '$g_CURFILE'!"
			    exit 1
			fi
                    elif [[ "${1#* }" = +(*MEMSTREAM*) ]]
		    then
			if [[ "${1##*MEMSTREAM }" = +([01]|TRUE|FALSE) ]]
			then
			    echo "__b2c__option_memstream = ${1##*MEMSTREAM };" >> $g_CFILE
			else
			    echo -e "\nERROR: invalid argument to OPTION MEMSTREAM at line $g_COUNTER in file '$g_CURFILE'!"
			    exit 1
			fi
                    elif [[ "${1#* }" = +(*MEMTYPE*) ]]
		    then
                        case "${1##*MEMTYPE }" in
                            *short*)
                                echo "__b2c__memtype = 2;" >> $g_CFILE
				g_OPTION_MEMTYPE="short"
				;;
                            *int*)
                                echo "__b2c__memtype = 3;" >> $g_CFILE
				g_OPTION_MEMTYPE="int"
				;;
                            *long*|*NUMBER*)
                                echo "__b2c__memtype = 4;" >> $g_CFILE
				g_OPTION_MEMTYPE="long"
				;;
                            *float*)
                                echo "__b2c__memtype = 5;" >> $g_CFILE
				g_OPTION_MEMTYPE="float"
				;;
                            *double*|*FLOATING*)
                                echo "__b2c__memtype = 6;" >> $g_CFILE
				g_OPTION_MEMTYPE="double"
				;;
                            *void*|*char\**|*STRING*)
                                echo "__b2c__memtype = 7;" >> $g_CFILE
				g_OPTION_MEMTYPE="char*"
				;;
                            *char*)
                                echo "__b2c__memtype = 1;" >> $g_CFILE
				g_OPTION_MEMTYPE="char"
				;;
			    *)
				echo -e "\nERROR: invalid argument to OPTION MEMTYPE at line $g_COUNTER in file '$g_CURFILE'!"
				exit 1
				;;
                        esac
                    elif [[ "${1#* }" = +(*COLLAPSE*) ]]
		    then
			if [[ "${1##*COLLAPSE }" = +([01]|TRUE|FALSE) ]]
			then
			    echo "__b2c__collapse = ${1##*COLLAPSE };" >> $g_CFILE
			else
			    echo -e "\nERROR: invalid argument to OPTION COLLAPSE at line $g_COUNTER in file '$g_CURFILE'!"
			    exit 1
			fi
                    elif [[ "${1#* }" = +(*INTERNATIONAL*) ]]
		    then
			if [[ "${1##*INTERNATIONAL }" = +([01]|TRUE|FALSE) ]]
			then
			    echo "#include <libintl.h>" >> $g_HFILE
			    echo "#include <locale.h>" >> $g_HFILE
			    echo "setlocale(LC_ALL, \"\");" >> $g_CFILE
			    echo "if(bindtextdomain(\"${g_SOURCEFILE%.*}\",\"/usr/share/locale\")==NULL){if(!__b2c__trap){ERROR = 6;if(!__b2c__catch_set){fprintf(stderr, \"%s\n\", ERR${g_STRINGSIGN}(ERROR)); exit(ERROR);} if(!setjmp(__b2c__jump)) goto $g_CATCHGOTO;} }" >> $g_CFILE
			    echo "if(textdomain(\"${g_SOURCEFILE%.*}\")==NULL){if(!__b2c__trap){ERROR = 6; if(!__b2c__catch_set){fprintf(stderr, \"%s\n\", ERR${g_STRINGSIGN}(ERROR)); exit(ERROR);} if(!setjmp(__b2c__jump)) goto $g_CATCHGOTO;} }" >> $g_CFILE
			else
			    echo -e "\nERROR: invalid argument to OPTION INTERNATIONAL at line $g_COUNTER in file '$g_CURFILE'!"
			    exit 1
			fi
		    else
			echo -e "\nERROR: argument to OPTION at line $g_COUNTER in file '$g_CURFILE' not recognized!"
			exit 1
		    fi
		fi;;
	    "PROTO")
		# Check argument
		if [[ "${1%% *}" = "${1#* }" ]]
		then
		    echo -e "\nERROR: empty PROTO at line $g_COUNTER in file '$g_CURFILE'!"
		    exit 1
		else
		    SYM=`echo ${1#* } | tr -d "\042"`
		    # Check if ALIAS is there
		    if [[ $SYM = +(* ALIAS *) ]]
		    then
			echo "#define ${SYM##* ALIAS } ${SYM%% ALIAS *}" >> $g_HFILE
			g_IMPORTED="${SYM##* ALIAS } $g_IMPORTED"
			g_IMPORTED="${SYM%% ALIAS *} $g_IMPORTED"
		    else
			g_IMPORTED="`echo ${SYM} | tr ',' ' '` $g_IMPORTED"
		    fi
		fi;;
	    "INCR")
		# Check argument
		if [[ "${1%% *}" = "${1#* }" ]]
		then
		    echo -e "\nERROR: empty INC at line $g_COUNTER in file '$g_CURFILE'!"
		    exit 1
		else
		    EXP=${1#* }
		    if [[ ${EXP} = +(*,*) ]]
		    then
			echo "${EXP%%,*} = ${EXP%%,*} + (${EXP#*,});" >> $g_CFILE
		    else
			echo "${EXP} = ${EXP} + 1;" >> $g_CFILE
		    fi
		fi;;
	    "DECR")
		# Check argument
		if [[ "${1%% *}" = "${1#* }" ]]
		then
		    echo -e "\nERROR: empty DEC at line $g_COUNTER in file '$g_CURFILE'!"
		    exit 1
		else
		    EXP=${1#* }
		    if [[ ${EXP} = +(*,*) ]]
		    then
			echo "${EXP%%,*} = ${EXP%%,*} - (${EXP#*,});" >> $g_CFILE
		    else
			echo "${EXP} = ${EXP} - 1;" >> $g_CFILE
		    fi
		fi;;
	    "ALARM")
		# Check argument
		if [[ "${1%% *}" = "${1#* }" ]]
		then
		    echo -e "\nERROR: empty ALARM at line $g_COUNTER in file '$g_CURFILE'!"
		    exit 1
		else
		    EXP=${1#* }
		    if [[ ${EXP} = +(*,*) ]]
		    then
			echo "signal(SIGALRM, (void*)${EXP%,*});" >> $g_CFILE
			echo "alarm(${EXP#*,});" >> $g_CFILE
		    else
			echo -e "\nERROR: missing argument in ALARM at line $g_COUNTER in file '$g_CURFILE'!"
			exit 1
		    fi
		fi;;
	    "CURSOR")
		# Check argument
		if [[ "${1%% *}" = "${1#* }" ]]
		then
		    echo -e "\nERROR: empty CURSOR at line $g_COUNTER in file '$g_CURFILE'!"
		    exit 1
		else
		    if [[ "${1#* }" = +(*OFF*) ]]
		    then
			echo "fprintf(stdout,\"\033[?25l\"); fflush(stdout);" >> $g_CFILE
		    elif [[ "${1#* }" = +(*ON*) ]]
		    then
			echo "fprintf(stdout,\"\033[?25h\"); fflush(stdout);" >> $g_CFILE
		    fi
		fi;;
	    "ALIAS")
		Handle_Alias "${1#* }";;
	    "LOOKUP")
		Handle_Lookup "${1#* }";;
	    "RELATE")
		Handle_Relate "${1#* }";;
	    "TEXTDOMAIN")
		# Check argument
		if [[ "${1%% *}" = "${1#* }" ]]
		then
		    echo -e "\nERROR: empty TEXTDOMAIN at line $g_COUNTER in file '$g_CURFILE'!"
		    exit 1
		else
		    EXP=${1#* }
		    if [[ ${EXP} = +(*,*) ]]
		    then
			echo "bindtextdomain(${EXP});" >> $g_CFILE
			echo "textdomain(${EXP%,*});" >> $g_CFILE
		    else
			echo -e "\nERROR: missing argument in TEXTDOMAIN at line $g_COUNTER in file '$g_CURFILE'!"
			exit 1
		    fi
		fi;;
	    *)
		# Check on imported symbols first
		FOUND=0
		for SYM in $g_IMPORTED
		do
		    if [[ "$SYM" = ${1%%\(*} || "$SYM" = ${1%% *} ]]
		    then
			FOUND=1
			if [[ "$1" != +(*\(*\)*) ]]
			then
			    echo "$SYM();" >> $g_CFILE
			else
			    echo "$SYM(${1#*\(};" >> $g_CFILE
			fi
		    fi
		done
		# Not an imported symbol? Check if assignment
		if [[ $FOUND -eq 0 ]]
		then
		    Handle_Let "$1"
		fi;;
	esac
    fi
}

#-----------------------------------------------------------

function Tokenize
{
    local CHAR IS_ESCAPED IS_STRING IS_STATEMENT TOKEN DATA LEN

    IS_ESCAPED=0
    IS_STRING=0
    IS_STATEMENT=""
    TOKEN=

    # Initialize miniparser, convert spaces
    DATA=`echo "${1}" | tr " " "\001"`
    LEN=${#DATA}

    until [[ $LEN -eq 0 ]]
    do
        CHAR="${DATA:0:5}"
	if [[ "${CHAR}" = "INTL$" ]]
        then
	    if [[ $IS_STRING -eq 0 ]]
	    then
                let LEN=${#DATA}-5
	        DATA="${DATA: -$LEN}"
		TOKEN="${TOKEN}gettext"
            fi
	elif [[ "${CHAR}" = "NNTL$" ]]
        then
	    if [[ $IS_STRING -eq 0 ]]
	    then
                let LEN=${#DATA}-5
	        DATA="${DATA: -$LEN}"
		TOKEN="${TOKEN}ngettext"
            fi
        fi
	CHAR="${DATA:0:1}"
	case $CHAR in
	    ":")
		if [[ $IS_STRING -eq 0 ]]
		then
		    Parse_Line "${TOKEN}"
		    unset CHAR
		    TOKEN=
		    IS_STATEMENT=""
		fi;;
	    "$")
		if [[ $IS_STRING -eq 0 || ${1} = +(*IMPORT*FROM*TYPE*) ]]
		then
		    TOKEN="${TOKEN}${g_STRINGSIGN}"
		    CHAR=
		    IS_ESCAPED=0
		fi;;
	    "\\")
		if [[ $IS_ESCAPED -eq 0 ]]
		then
		    IS_ESCAPED=1
		else
		    IS_ESCAPED=0
		fi;;
	    "\"")
		if [[ $IS_ESCAPED -eq 0 ]]
		then
		    if [[ $IS_STRING -eq 0 ]]
		    then
			IS_STRING=1
		    else
			IS_STRING=0
		    fi
		fi
		IS_ESCAPED=0;;
	    [A-Za-z=])
		if [[ $IS_STRING -eq 0 ]]
		then
		    IS_STATEMENT=" "
		fi
		IS_ESCAPED=0;;
	    *)
		IS_ESCAPED=0;;
	esac
	# Convert back to space
	if [[ "${CHAR}" = "${g_PARSEVAR}" ]]
	then
	    TOKEN="${TOKEN}${IS_STATEMENT}"
        else
	    TOKEN="${TOKEN}${CHAR}"
	fi
	let LEN=${#DATA}-1
	DATA="${DATA: -$LEN}"
    done
    Parse_Line "${TOKEN}"
}

#-----------------------------------------------------------

function Parse_Chunk
{
    local CHAR IS_ESCAPED IS_STRING TOKEN DATA LEN TERM EQ IS_EQUATION

    IS_ESCAPED=0
    IS_STRING=0
    IS_EQUATION=0
    TOKEN=
    EQ="!"

    # Initialize miniparser, convert spaces
    DATA=`echo "${1}" | tr " " "\001"`
    LEN=${#DATA}

    until [[ $LEN -eq 0 ]]
    do
	CHAR="${DATA:0:1}"
	case $CHAR in
	    "=")
		if [[ $IS_STRING -eq 0 ]]
		then
                    if [[ "${1%%\(*}" = +(*${g_STRINGSIGN}*) || "${1%%\(*}" = +(*${g_DQUOTESIGN}*) ]]
                    then
                        TERM="${TOKEN}"
                        TOKEN=
                    elif [[ $IS_EQUATION -eq 0 ]]
                    then
		        TOKEN="${TOKEN}=="
                    else
		        TOKEN="${TOKEN}="
                        IS_EQUATION=0
                    fi
		    IS_ESCAPED=0
                else
		    TOKEN="${TOKEN}="
		fi;;
	    "!")
		if [[ $IS_STRING -eq 0 ]]
		then
                    if [[ "${1%%\(*}" = +(*${g_STRINGSIGN}*) || "${1%%\(*}" = +(*${g_DQUOTESIGN}*) ]]
                    then
                        EQ=""
                    elif [[ $IS_EQUATION -eq 0 ]]
                    then
                        TOKEN="${TOKEN}!="
		        IS_ESCAPED=0
                        let LEN=${#DATA}-1
                        DATA="${DATA: -$LEN}"
                    else
                        TOKEN="${TOKEN}!"
                        IS_EQUATION=0
                    fi
                else
                    TOKEN="${TOKEN}!"
		fi;;
            "<")
                IS_EQUATION=1
                TOKEN="${TOKEN}<";;
            ">")
                IS_EQUATION=1
                TOKEN="${TOKEN}>";;
            "#")
                IS_EQUATION=1
                TOKEN="${TOKEN}#";;
	    "\\")
		if [[ $IS_ESCAPED -eq 0 ]]
		then
		    IS_ESCAPED=1
		else
		    IS_ESCAPED=0
		fi
                TOKEN="${TOKEN}\\";;
	    "\"")
		if [[ $IS_ESCAPED -eq 0 ]]
		then
		    if [[ $IS_STRING -eq 0 ]]
		    then
			IS_STRING=1
		    else
			IS_STRING=0
		    fi
		fi
		IS_ESCAPED=0
                TOKEN="${TOKEN}\"";;
	    *)
                # Convert back to space
	        if [[ "${CHAR}" = "${g_PARSEVAR}" ]]
	        then
	            TOKEN="${TOKEN} "
                else
	            TOKEN="${TOKEN}${CHAR}"
	        fi
		IS_ESCAPED=0;;
	esac
	let LEN=${#DATA}-1
	DATA="${DATA: -$LEN}"
    done

    if [[ "${1%%\(*}" = +(*${g_STRINGSIGN}*) || "${1%%\(*}" = +(*${g_DQUOTESIGN}*) ]]
    then
        TOKEN="((__b2c__option_compare == 0) ? ${EQ}strcmp(${TERM}, $TOKEN) : ${EQ}strcasecmp(${TERM}, $TOKEN))"
    fi

    g_EQUATION="${g_EQUATION} ${TOKEN} ${2}"
}

#-----------------------------------------------------------

function Parse_Equation
{
    local CHAR IS_ESCAPED IS_STRING TOKEN DATA LEN
    local AND OR

    g_EQUATION=
    IS_ESCAPED=0
    IS_STRING=0
    TOKEN=

    AND=`echo " AND " | tr " " "\001"`
    OR=`echo " OR " | tr " " "\001"`

    # Initialize miniparser, convert spaces
    DATA=`echo "${1}" | tr " " "\001"`
    LEN=${#DATA}

    until [[ $LEN -eq 0 ]]
    do
        CHAR="${DATA:0:5}"
	if [[ "${CHAR}" = "${AND}" ]]
        then
	    if [[ $IS_STRING -eq 0 ]]
	    then
		Parse_Chunk "${TOKEN}" " AND "
                let LEN=${#DATA}-4
	        DATA="${DATA: -$LEN}"
		unset CHAR
		TOKEN=
            fi
        fi
        CHAR="${DATA:0:4}"
	if [[ "${CHAR}" = "${OR}" ]]
        then
	    if [[ $IS_STRING -eq 0 ]]
	    then
		Parse_Chunk "${TOKEN}" " OR "
                let LEN=${#DATA}-3
	        DATA="${DATA: -$LEN}"
		unset CHAR
		TOKEN=
            fi
        fi
	CHAR="${DATA:0:1}"
	case $CHAR in
	    "\\")
		if [[ $IS_ESCAPED -eq 0 ]]
		then
		    IS_ESCAPED=1
		else
		    IS_ESCAPED=0
		fi;;
	    "\"")
		if [[ $IS_ESCAPED -eq 0 ]]
		then
		    if [[ $IS_STRING -eq 0 ]]
		    then
			IS_STRING=1
		    else
			IS_STRING=0
		    fi
		fi
		IS_ESCAPED=0;;
	    *)
		IS_ESCAPED=0;;
	esac
	# Convert back to space
	if [[ "${CHAR}" = "${g_PARSEVAR}" ]]
	then
	    TOKEN="${TOKEN} "
        else
	    TOKEN="${TOKEN}${CHAR}"
	fi
	let LEN=${#DATA}-1
	DATA="${DATA: -$LEN}"
    done
    Parse_Chunk "${TOKEN}"
}

#-----------------------------------------------------------
#
# Main program
#
#-----------------------------------------------------------

# Default BACON settings
let g_MAX_DIGITS=32

# Maximum of internal buffers needed for string processing
let g_MAX_BUFFERS=32

# This is the size for static buffers like fgets, read etc.
let g_BUFFER_SIZE=512

# Maximum RETURN buffers
let g_MAX_RBUFFERS=32

let g_NO_COMPILE=0
let g_TMP_PRESERVE=0
let g_USE_C=0
let g_MAX_BACKLOG=5
let g_CPP=0
let g_XGETTEXT=0

g_TEMPDIR=.
g_CCNAME=cc
g_CCFLAGS=
g_INCFILES=
g_INCLUDE_FILES=
let g_TRACE=0
let g_OPTION_BASE=0
let g_OPTION_SOCKET=5
g_OPTION_MEMTYPE="char"
let g_IF_PARSE=0

# Some global declarations
g_CURFILE=
g_FUNCNAME=
g_FUNCTYPE=
g_PROTOTYPE=
g_TMP_FILES=
g_LOCALSTRINGS=
g_STRINGARRAYS=
g_STRINGARGS=
g_BINEXT=
g_RECORDCACHE=
g_LOOPCTR=0
g_ERRORTXT=
g_EQUATION=

# Always create a final label
g_CATCHGOTO="__B2C__PROGRAM__EXIT"

# Records
g_RECORDNAME=
g_RECORDVAR=
g_WITHVAR=

# Select/Case
declare -a g_SELECTVAR
declare -a g_IN_CASE
g_SELECTVAR_CTR=0

# Relate
declare -a g_RELATE
g_RELATE_CTR=0

# Get arguments
while getopts ":c:d:i:l:o:xnjfpv" OPT
do
    case $OPT in
	c) g_CCNAME=$OPTARG;;
	d) if [[ ! -d $OPTARG ]]
	   then
		mkdir -p $OPTARG
	   fi
	   g_TEMPDIR=$OPTARG;;
	i) if [[ ! -f $OPTARG && ! -f "/usr/include/$OPTARG" ]]
	   then
		echo -e "ERROR: included C header file from -i option not found!"
		exit 1
	   fi
	   if [[ ! -f "/usr/include/$OPTARG" ]]
	   then
		g_INCFILES="$g_INCFILES ${OPTARG}"
	   else
		g_INCFILES="$g_INCFILES <${OPTARG}>"
	   fi;;
	l) g_LDFLAGS="$g_LDFLAGS -l$OPTARG";;
	o) g_CCFLAGS="$g_CCFLAGS $OPTARG";;
	n) g_NO_COMPILE=1;;
	j) g_CPP=1;;
	f) g_CCFLAGS="$g_CCFLAGS -shared -rdynamic"
	   if [[ `uname -a` = +(*x86_64*) ]]
	   then
		g_CCFLAGS="$g_CCFLAGS -fPIC"
	   fi
	   g_BINEXT=".so";; 
	p) g_TMP_PRESERVE=1;;
	x) g_XGETTEXT=1;;
	v) echo 
	   echo "BaCon version $g_VERSION - BASH - (c) Peter van Eerten - GPL v3."
	   echo 
	   exit 0;; 
	\?|h) echo 
	    echo "USAGE: bacon [options] program[.bac]"
	    echo 
	    echo "OPTIONS:"
	    echo 
	    echo -e " -c <compiler>\tCompiler to use (default: $g_CCNAME)"
	    echo -e " -l <flags>\tPass libraries to linker"
	    echo -e " -o <options>\tPass compiler options"
	    echo -e " -i <include>\tAdd include file to C code"
	    echo -e " -d <tmpdir>\tTemporary directory (default: $g_TEMPDIR)"
	    echo -e " -x \t\tExtract gettext strings"
	    echo -e " -f \t\tCreate Shared Object"
	    echo -e " -n \t\tDo not compile, only convert"
	    echo -e " -j \t\tInvoke C Preprocessor"
	    echo -e " -p \t\tPreserve temporary files"
	    echo -e " -v \t\tShow version"
	    echo -e " -h \t\tShow help"
	    echo 
	    exit 0;;
    esac
done

shift $(($OPTIND-1))

# Check if a filename was entered, if so get it
if [[ $# -eq 0 ]]
then
    echo -e "ERROR: no filename? Run with '-h' to see usage."
    exit 1
elif [[ "$@" = +(http://*) ]]
then
    if [[ -z `which telnet 2>/dev/null` ]]
    then
	echo "ERROR: No telnet client found! Cannot retrieve file."
	exit 1
    fi
    echo -n "Fetching file... "
    # Remove http part
    g_SOURCEFILE="${1#*http://}"

    # Get header to see if file exists, and if so, get length
    HEAD=`(echo "set crlf on"; echo "open ${g_SOURCEFILE%%/*} 80"; sleep 1;
    echo "HEAD /${1##*/} HTTP/1.1"; echo "Host: ${g_SOURCEFILE%%/*}"; echo;
    sleep 1; echo "quit";) | telnet 2>/dev/null`

    LEN=`echo ${HEAD#*Content-Length: }`

    # No file found on server
    if [[ "${LEN%% *}" = "telnet>" || "${HEAD}" != +(*Content-Length*) ]]
    then
        echo "ERROR: file not found! Check URL and try again."
        exit 1
    fi

    # Get the actual contents of the file
    DOWNLOAD=`(echo "set crlf on"; echo "open ${g_SOURCEFILE%%/*} 80"; sleep 1;
    echo "GET /${1##*/} HTTP/1.1"; echo "Host: ${g_SOURCEFILE%%/*}"; echo;
    sleep 1; echo "quit";) | telnet 2>/dev/null`

    # Set the final filename and save
    g_SOURCEFILE="${1##*/}"
    let START=${#DOWNLOAD}-${LEN%% *}
    echo "${DOWNLOAD:${START}:${#DOWNLOAD}}" > $g_SOURCEFILE

    # Check resulting filesize with HTTP header
    FILELEN=`wc -c $g_SOURCEFILE`
    let FILELEN=${FILELEN%% *}-1
    if [[ ${FILELEN} -ne ${LEN%% *} ]]
    then
        echo "ERROR: file could not be downloaded. Try again later."
        exit 1
    fi
    echo "done."

elif [[ "$@" != +(*.bac) ]]
then
    g_SOURCEFILE="$@.bac"
else
    g_SOURCEFILE="$@"
fi

# Check if file exists
if [[ ! -f $g_SOURCEFILE ]]
then
    echo -e "ERROR: file not found!"
    exit 1
fi

# Change the working directory
if [[ -d ${g_SOURCEFILE%/*} ]]
then
    cd ${g_SOURCEFILE%/*}
fi

# Now create the global filenames where to write to
g_CFILE=$g_TEMPDIR/${g_SOURCEFILE##*/}.c
g_HFILE=$g_TEMPDIR/${g_SOURCEFILE##*/}.h
STRINGARRAYFILE=$g_TEMPDIR/${g_SOURCEFILE##*/}.string.h
FLOATARRAYFILE=$g_TEMPDIR/${g_SOURCEFILE##*/}.float.h

# Check to overwrite
if [[ -f $g_CFILE || -f $g_HFILE ]]
then
    rm -f $g_CFILE
    rm -f $g_HFILE
    rm -f $STRINGARRAYFILE
    rm -f $FLOATARRAYFILE
fi

echo -n "Starting conversion... "

# Add to total file list
g_TMP_FILES="$g_CFILE $g_HFILE $STRINGARRAYFILE $FLOATARRAYFILE"

# Create basic C file
echo "/* Created with BASH BaCon $g_VERSION - (c) Peter van Eerten - GPL v3 */" > $g_CFILE
echo "#include \"${g_SOURCEFILE##*/}.h\"" >> $g_CFILE
echo "int main(int argc, const char **argv)" >> $g_CFILE
echo "{" >> $g_CFILE
echo "/* Default is: system traps signals */" >> $g_CFILE
echo "signal(SIGILL, __b2c__catch_signal);" >> $g_CFILE
echo "signal(SIGABRT, __b2c__catch_signal);" >> $g_CFILE
echo "signal(SIGFPE, __b2c__catch_signal);" >> $g_CFILE
echo "signal(SIGSEGV, __b2c__catch_signal);" >> $g_CFILE
echo "/* Make sure internal string buffers are empty */" >> $g_CFILE
echo "__b2c__sbuffer_ptr=0;" >> $g_CFILE
echo "__b2c__rbuffer_ptr=0;" >> $g_CFILE

# Put arguments into reserved variable ARGUMENT
echo "/* Setup the reserved variable 'ARGUMENT' */" >> $g_CFILE
echo "for(__b2c__counter=0; __b2c__counter < argc; __b2c__counter++)" >> $g_CFILE
echo "{__b2c__arglen += strlen(argv[__b2c__counter]) + 1;} __b2c__arglen++;" >> $g_CFILE
echo "ARGUMENT${g_STRINGSIGN} = (char*)calloc(__b2c__arglen, sizeof(char));" >> $g_CFILE
echo "for(__b2c__counter=0; __b2c__counter < argc; __b2c__counter++)" >> $g_CFILE
echo "{strcat(ARGUMENT${g_STRINGSIGN}, argv[__b2c__counter]); if(__b2c__counter != argc - 1) strcat(ARGUMENT${g_STRINGSIGN}, \" \");}" >> $g_CFILE
echo "/* By default seed random generator */" >> $g_CFILE
echo "srandom((unsigned int)time(NULL));" >> $g_CFILE
echo "/* Initialize internal stackpointer */" >> $g_CFILE
echo "__b2c__typestack = (int*)calloc(1, sizeof(int));" >> $g_CFILE
echo "__b2c__stringstack = (char**)realloc(__b2c__stringstack, sizeof(char*)); __b2c__stringstack[0] = calloc(1, sizeof(char));" >> $g_CFILE
echo "/* Rest of the program */" >> $g_CFILE

# Create basic H file, functions are converted using macros
echo "/* Created with BASH BaCon $g_VERSION - (c) Peter van Eerten - GPL v3 */" > $g_HFILE
echo >> $g_HFILE
echo "#include <stdio.h>" >> $g_HFILE
echo "#include <stdlib.h>" >> $g_HFILE
echo "#include <stdarg.h>" >> $g_HFILE
echo "#include <sys/time.h>" >> $g_HFILE
echo "#include <sys/stat.h>" >> $g_HFILE
echo "#include <sys/types.h>" >> $g_HFILE
echo "#include <sys/wait.h>" >> $g_HFILE
echo "#include <sys/socket.h>" >> $g_HFILE
echo "#include <sys/utsname.h>" >> $g_HFILE
echo "#include <dirent.h>" >> $g_HFILE
echo "#include <setjmp.h>" >> $g_HFILE
echo "#include <netdb.h>" >> $g_HFILE
if [[ `uname` = +(*BSD*) ]]
then
    echo "#include <netinet/in.h>" >> $g_HFILE
fi
echo "#include <arpa/inet.h>" >> $g_HFILE
echo "#include <signal.h>" >> $g_HFILE
echo "static jmp_buf __b2c__jump;" >> $g_HFILE
echo "static int __b2c__trap = 1;" >> $g_HFILE
echo "static int __b2c__catch_set = 0;" >> $g_HFILE
echo "static int ERROR = 0;" >> $g_HFILE
echo "static int __b2c__option_compare = 0;" >> $g_HFILE
echo "static int __b2c__option_memstream = 0;" >> $g_HFILE
echo "static int __b2c__memtype = 1;" >> $g_HFILE
echo "static int __b2c__collapse = 0;" >> $g_HFILE
echo "int __b2c__break_ctr = 0;" >> $g_HFILE
echo "int __b2c__break_flag = 0;" >> $g_HFILE
echo "int RETVAL = 0;" >> $g_HFILE
echo "char __b2c__chop_default[] = \"\r\n\t \";" >> $g_HFILE
echo "char VERSION${g_STRINGSIGN}[] = \"$g_VERSION\";" >> $g_HFILE
echo >> $g_HFILE
# Add user include files
echo "/* User include files */" >> $g_HFILE
for i in $g_INCFILES
do
    if [[ "$i" = +(*<*) ]]
    then
	echo "#include $i" >> $g_HFILE
    else
	echo "#include \"$i\"" >> $g_HFILE
    fi
done
echo "/* READ/DATA include files */" >> $g_HFILE
echo "int __b2c__stringarray_ptr = 0;" >> $g_HFILE
echo "#include \"${g_SOURCEFILE##*/}.string.h\"" >> $g_HFILE
echo "int __b2c__floatarray_ptr = 0;" >> $g_HFILE
echo "#include \"${g_SOURCEFILE##*/}.float.h\"" >> $g_HFILE
echo "int __b2c__ctr;" >> $g_HFILE
echo >> $g_HFILE
echo "/* Math functions */" >> $g_HFILE
echo "extern double round(double __b2c__x);" >> $g_HFILE
echo "extern long int lrint(double __b2c__x);" >> $g_HFILE
echo "#include <math.h>" >> $g_HFILE
echo "#define SQR(__b2c__x) sqrt(__b2c__x)" >> $g_HFILE
echo "#define POW(__b2c__x, __b2c__y) pow(__b2c__x, __b2c__y)" >> $g_HFILE
echo "#define SIN(__b2c__x) sin(__b2c__x)" >> $g_HFILE
echo "#define COS(__b2c__x) cos(__b2c__x)" >> $g_HFILE
echo "#define TAN(__b2c__x) tan(__b2c__x)" >> $g_HFILE
echo "#define ATN(__b2c__x) atan(__b2c__x)" >> $g_HFILE
echo "#define LOG(__b2c__x) log(__b2c__x)" >> $g_HFILE
echo "#define EXP(__b2c__x) exp(__b2c__x)" >> $g_HFILE
echo "#define SGN(__b2c__x) (__b2c__x == 0 ? 0 : (__b2c__x < 0 ? -1 : 1))" >> $g_HFILE
echo "#define ROUND(__b2c__x) lrint(__b2c__x)" >> $g_HFILE
echo "#define INT(__b2c__x) lrint(__b2c__x)" >> $g_HFILE
echo "#define MOD(__b2c__x, __b2c__y) ((long)__b2c__x % (long)__b2c__y)" >> $g_HFILE
echo "#define EVEN(__b2c__x) ((__b2c__x % 2 == 0) ? 1 : 0)" >> $g_HFILE
echo "#define ODD(__b2c__x) ((__b2c__x % 2 != 0) ? 1 : 0)" >> $g_HFILE
echo "#define FLOOR(__b2c__x) (long)floor(__b2c__x)" >> $g_HFILE
echo "#define ABS(__b2c__x) (long)abs(__b2c__x)" >> $g_HFILE
echo "#define RND random()" >> $g_HFILE
if [[ `uname` = +(*SunOS*) ]]
then
    echo "#define MAXRANDOM 2147483647" >> $g_HFILE
else
    echo "#define MAXRANDOM RAND_MAX" >> $g_HFILE
fi
echo "#define RANDOM(__b2c__x) ((__b2c__x != 0) ? random()/(MAXRANDOM/__b2c__x) : 0)" >> $g_HFILE
echo >> $g_HFILE
echo "/* Other functions */" >> $g_HFILE
echo "#define VAL(__b2c__x) ((__b2c__x != NULL) ? atof(__b2c__x) : 0)" >> $g_HFILE
echo >> $g_HFILE
echo "/* Unix functions */" >> $g_HFILE
echo "#include <unistd.h>" >> $g_HFILE
echo "#define SYSTEM(__b2c__x) do {if (__b2c__x != NULL) {RETVAL = system(__b2c__x); if(WIFEXITED(RETVAL)) RETVAL = WEXITSTATUS(RETVAL);} else RETVAL=0;} while(0)" >> $g_HFILE
echo >> $g_HFILE
echo "/* String functions */" >> $g_HFILE
echo "#include <string.h>" >> $g_HFILE
echo "char *__b2c__strndup(const char *__b2c__s, size_t __b2c__n){size_t __b2c__avail;" >> $g_HFILE
echo "char *__b2c__p; if (!__b2c__s) return 0; __b2c__avail = strlen(__b2c__s) + 1;" >> $g_HFILE
echo "if (__b2c__avail > __b2c__n + 1) __b2c__avail = __b2c__n + 1; __b2c__p = malloc(__b2c__avail);" >> $g_HFILE
echo "memcpy(__b2c__p, __b2c__s, __b2c__avail); __b2c__p[__b2c__avail - 1] = '\0'; return __b2c__p;}" >> $g_HFILE
echo "char __b2c__input__buffer[$g_BUFFER_SIZE];" >> $g_HFILE
echo "char* __b2c__sbuffer[$g_MAX_BUFFERS] = { NULL };" >> $g_HFILE
echo "int __b2c__sbuffer_ptr;" >> $g_HFILE
echo "char* __b2c__rbuffer[$g_MAX_RBUFFERS] = { NULL };" >> $g_HFILE
echo "int __b2c__rbuffer_ptr;" >> $g_HFILE
echo "/* Temporary pointer to perform assignments */" >> $g_HFILE
echo "char *__b2c__assign = NULL;" >> $g_HFILE
echo "char *__b2c__split = NULL; char *__b2c__split_tmp = NULL; char *__b2c__split_ptr = NULL;" >> $g_HFILE
echo "char *ERR${g_STRINGSIGN}(int);" >> $g_HFILE
echo "/* Functions for sort */" >> $g_HFILE
echo "int __b2c__sortnrd(const void *__b2c__a, const void *__b2c__b)" >> $g_HFILE
echo "{if (*(double*)__b2c__a==*(double*)__b2c__b) return 0; else if (*(double*)__b2c__a < *(double*)__b2c__b) return -1; else return 1;}" >> $g_HFILE
echo "int __b2c__sortnrd_down(const void *__b2c__a, const void *__b2c__b)" >> $g_HFILE
echo "{if (*(double*)__b2c__a==*(double*)__b2c__b) return 0; else if (*(double*)__b2c__a < *(double*)__b2c__b) return 1; else return -1;}" >> $g_HFILE
echo "int __b2c__sortnrf(const void *__b2c__a, const void *__b2c__b)" >> $g_HFILE
echo "{if (*(float*)__b2c__a==*(float*)__b2c__b) return 0; else if (*(float*)__b2c__a < *(float*)__b2c__b) return -1; else return 1;}" >> $g_HFILE
echo "int __b2c__sortnrf_down(const void *__b2c__a, const void *__b2c__b)" >> $g_HFILE
echo "{if (*(float*)__b2c__a==*(float*)__b2c__b) return 0; else if (*(float*)__b2c__a < *(float*)__b2c__b) return 1; else return -1;}" >> $g_HFILE
echo "int __b2c__sortnrl(const void *__b2c__a, const void *__b2c__b)" >> $g_HFILE
echo "{if (*(long*)__b2c__a==*(long*)__b2c__b) return 0; else if (*(long*)__b2c__a < *(long*)__b2c__b) return -1; else return 1;}" >> $g_HFILE
echo "int __b2c__sortnrl_down(const void *__b2c__a, const void *__b2c__b)" >> $g_HFILE
echo "{if (*(long*)__b2c__a==*(long*)__b2c__b) return 0; else if (*(long*)__b2c__a < *(long*)__b2c__b) return 1; else return -1;}" >> $g_HFILE
echo "int __b2c__sortnri(const void *__b2c__a, const void *__b2c__b)" >> $g_HFILE
echo "{if (*(int*)__b2c__a==*(int*)__b2c__b) return 0; else if (*(int*)__b2c__a < *(int*)__b2c__b) return -1; else return 1;}" >> $g_HFILE
echo "int __b2c__sortnri_down(const void *__b2c__a, const void *__b2c__b)" >> $g_HFILE
echo "{if (*(int*)__b2c__a==*(int*)__b2c__b) return 0; else if (*(int*)__b2c__a < *(int*)__b2c__b) return 1; else return -1;}" >> $g_HFILE
echo "int __b2c__sortstr(const void *__b2c__a, const void *__b2c__b)" >> $g_HFILE
echo "{return strcmp(*(char **) __b2c__a, *(char **) __b2c__b);}" >> $g_HFILE
echo "int __b2c__sortstr_down(const void *__b2c__a, const void *__b2c__b)" >> $g_HFILE
echo "{return strcmp(*(char **) __b2c__b, *(char **) __b2c__a);}" >> $g_HFILE
echo "/* Actual functions */" >> $g_HFILE
echo "char* __b2c__curdir(void){__b2c__sbuffer_ptr++; if(__b2c__sbuffer_ptr >= $g_MAX_BUFFERS) __b2c__sbuffer_ptr=0;" >> $g_HFILE
echo "__b2c__sbuffer[__b2c__sbuffer_ptr] = (char*)realloc(__b2c__sbuffer[__b2c__sbuffer_ptr], $g_BUFFER_SIZE*sizeof(char));" >> $g_HFILE
echo "return (getcwd(__b2c__sbuffer[__b2c__sbuffer_ptr], $g_BUFFER_SIZE));}" >> $g_HFILE
echo "#define CURDIR${g_STRINGSIGN} __b2c__curdir()" >> $g_HFILE
echo "char* __b2c__reverse(char *__b2c__s){int __b2c__i; __b2c__sbuffer_ptr++; if(__b2c__sbuffer_ptr >= $g_MAX_BUFFERS) __b2c__sbuffer_ptr=0;" >> $g_HFILE
echo "__b2c__sbuffer[__b2c__sbuffer_ptr] = (char*)realloc(__b2c__sbuffer[__b2c__sbuffer_ptr], (strlen(__b2c__s)+2)*sizeof(char));" >> $g_HFILE
echo "memset(__b2c__sbuffer[__b2c__sbuffer_ptr], 0, strlen(__b2c__s)+1);" >> $g_HFILE
echo "for(__b2c__i=0;__b2c__i<strlen(__b2c__s);__b2c__i++){__b2c__sbuffer[__b2c__sbuffer_ptr][__b2c__i]=__b2c__s[strlen(__b2c__s)-1-__b2c__i];}" >> $g_HFILE
echo "return(__b2c__sbuffer[__b2c__sbuffer_ptr]);}" >> $g_HFILE
echo "#define REVERSE${g_STRINGSIGN}(x) ((x != NULL) ? __b2c__reverse(x) : \"null\")" >> $g_HFILE
echo "char* __b2c__str(double d){__b2c__sbuffer_ptr++; if(__b2c__sbuffer_ptr >= $g_MAX_BUFFERS) __b2c__sbuffer_ptr=0;" >> $g_HFILE
echo "__b2c__sbuffer[__b2c__sbuffer_ptr] = (char*)realloc(__b2c__sbuffer[__b2c__sbuffer_ptr], $g_MAX_DIGITS*sizeof(char));" >> $g_HFILE
echo "memset(__b2c__sbuffer[__b2c__sbuffer_ptr], 0, $g_MAX_DIGITS);" >> $g_HFILE
echo "if(floor(d) == d) snprintf(__b2c__sbuffer[__b2c__sbuffer_ptr], $g_MAX_DIGITS, \"%ld\", (long)d); else snprintf(__b2c__sbuffer[__b2c__sbuffer_ptr], $g_MAX_DIGITS, \"%.10g\", d);" >> $g_HFILE
echo "return(__b2c__sbuffer[__b2c__sbuffer_ptr]);}" >> $g_HFILE
echo "#define STR${g_STRINGSIGN}(x) __b2c__str(x)" >> $g_HFILE
echo "char* __b2c__concat(char *__b2c__first, ...){char *__b2c__tmp; va_list __b2c__ap; __b2c__sbuffer_ptr++; if(__b2c__sbuffer_ptr >= $g_MAX_BUFFERS) __b2c__sbuffer_ptr=0;" >> $g_HFILE
echo "if(__b2c__first != NULL) { __b2c__sbuffer[__b2c__sbuffer_ptr] = (char*)realloc(__b2c__sbuffer[__b2c__sbuffer_ptr], (strlen(__b2c__first)+1)*sizeof(char));" >> $g_HFILE
echo "memset(__b2c__sbuffer[__b2c__sbuffer_ptr], 0, (strlen(__b2c__first)+1)*sizeof(char)); strcpy(__b2c__sbuffer[__b2c__sbuffer_ptr], __b2c__first);}" >> $g_HFILE
echo "else {__b2c__sbuffer[__b2c__sbuffer_ptr] = (char*)realloc(__b2c__sbuffer[__b2c__sbuffer_ptr], 2*sizeof(char)); strcpy(__b2c__sbuffer[__b2c__sbuffer_ptr], \"\");} va_start(__b2c__ap, __b2c__first);" >> $g_HFILE
echo "while((__b2c__tmp = va_arg(__b2c__ap, char *)) != NULL) {__b2c__sbuffer[__b2c__sbuffer_ptr] = (char*)realloc(__b2c__sbuffer[__b2c__sbuffer_ptr], (strlen(__b2c__tmp)+strlen(__b2c__sbuffer[__b2c__sbuffer_ptr])+1)*sizeof(char));" >> $g_HFILE
echo "strcat(__b2c__sbuffer[__b2c__sbuffer_ptr], __b2c__tmp);} va_end(__b2c__ap); return(__b2c__sbuffer[__b2c__sbuffer_ptr]);}" >> $g_HFILE
echo "#define CONCAT${g_STRINGSIGN}(...) __b2c__concat(__VA_ARGS__, (char*)NULL)" >> $g_HFILE
echo "char* __b2c__left(char *__b2c__src, long __b2c__n){if(__b2c__src == NULL || __b2c__n > strlen(__b2c__src) || __b2c__n < 0) return(__b2c__src);" >> $g_HFILE
echo "__b2c__sbuffer_ptr++; if(__b2c__sbuffer_ptr >= $g_MAX_BUFFERS) __b2c__sbuffer_ptr=0;" >> $g_HFILE
echo "__b2c__sbuffer[__b2c__sbuffer_ptr] = (char*)realloc(__b2c__sbuffer[__b2c__sbuffer_ptr], (strlen(__b2c__src)+1)*sizeof(char));" >> $g_HFILE
echo "memset(__b2c__sbuffer[__b2c__sbuffer_ptr], 0, (strlen(__b2c__src)+1)*sizeof(char)); strncpy(__b2c__sbuffer[__b2c__sbuffer_ptr], __b2c__src, (__b2c__n));" >> $g_HFILE
echo "return (__b2c__sbuffer[__b2c__sbuffer_ptr]);}" >> $g_HFILE
echo "#define LEFT${g_STRINGSIGN}(__b2c__x, __b2c__y) __b2c__left(__b2c__x, __b2c__y)" >> $g_HFILE
echo "char* __b2c__right(char *__b2c__src, long __b2c__n){if(__b2c__src == NULL || __b2c__n > strlen(__b2c__src) || __b2c__n < 0) return(__b2c__src);" >> $g_HFILE
echo "__b2c__sbuffer_ptr++; if(__b2c__sbuffer_ptr >= $g_MAX_BUFFERS) __b2c__sbuffer_ptr=0;" >> $g_HFILE
echo "__b2c__sbuffer[__b2c__sbuffer_ptr] = (char*)realloc(__b2c__sbuffer[__b2c__sbuffer_ptr], (strlen(__b2c__src)+1)*sizeof(char));" >> $g_HFILE
echo "memset(__b2c__sbuffer[__b2c__sbuffer_ptr], 0, (strlen(__b2c__src)+1)*sizeof(char)); strcpy(__b2c__sbuffer[__b2c__sbuffer_ptr], __b2c__src+ strlen(__b2c__src)- __b2c__n);" >> $g_HFILE
echo "return (__b2c__sbuffer[__b2c__sbuffer_ptr]);}" >> $g_HFILE
echo "#define RIGHT${g_STRINGSIGN}(__b2c__x, __b2c__y) __b2c__right(__b2c__x, __b2c__y)" >> $g_HFILE
echo "char* __b2c__mid(char *__b2c__src, ...){ va_list __b2c__ap; long __b2c__start, __b2c__end; if(__b2c__src == NULL || strlen(__b2c__src) == 0) return(\"\");" >> $g_HFILE
echo "__b2c__sbuffer_ptr++; if(__b2c__sbuffer_ptr >= $g_MAX_BUFFERS) __b2c__sbuffer_ptr=0;" >> $g_HFILE
echo "__b2c__sbuffer[__b2c__sbuffer_ptr] = (char*)realloc(__b2c__sbuffer[__b2c__sbuffer_ptr], (strlen(__b2c__src)+1)*sizeof(char));" >> $g_HFILE
echo "memset(__b2c__sbuffer[__b2c__sbuffer_ptr], 0, (strlen(__b2c__src)+1)*sizeof(char)); va_start(__b2c__ap, __b2c__src);" >> $g_HFILE
echo "__b2c__start = va_arg(__b2c__ap, long); if(__b2c__start < 1) return(__b2c__src); if(__b2c__start > strlen(__b2c__src)) return(\"\"); __b2c__end = va_arg(__b2c__ap, long); if((__b2c__end) < 0 || (__b2c__end) > strlen(__b2c__src)) __b2c__end = strlen(__b2c__src)-__b2c__start+1;" >> $g_HFILE
echo "strncpy(__b2c__sbuffer[__b2c__sbuffer_ptr], __b2c__src+(long)(__b2c__start)-1, (__b2c__end)); va_end(__b2c__ap); return (__b2c__sbuffer[__b2c__sbuffer_ptr]);}" >> $g_HFILE
echo "#define MID${g_STRINGSIGN}(__b2c__string, ...) __b2c__mid(__b2c__string, __VA_ARGS__, -1)" >> $g_HFILE
echo "long __b2c__instr(char *__b2c__first, ...){char *__b2c__tmp; char *__b2c__res; int __b2c__pos; __b2c__sbuffer_ptr++; if(__b2c__sbuffer_ptr >= $g_MAX_BUFFERS) __b2c__sbuffer_ptr=0;" >> $g_HFILE
echo "va_list __b2c__ap; if(__b2c__first == NULL) return (0); __b2c__sbuffer[__b2c__sbuffer_ptr] = (char*)realloc(__b2c__sbuffer[__b2c__sbuffer_ptr], (strlen(__b2c__first)+1)*sizeof(char));" >> $g_HFILE
echo "strcpy(__b2c__sbuffer[__b2c__sbuffer_ptr], __b2c__first); va_start(__b2c__ap, __b2c__first);" >> $g_HFILE
echo "__b2c__tmp = va_arg(__b2c__ap, char *); if(__b2c__tmp == NULL || strlen(__b2c__tmp) == 0) return (0);__b2c__pos = va_arg(__b2c__ap, int);" >> $g_HFILE
echo "if(__b2c__pos <= 0) __b2c__pos = 1; va_end(__b2c__ap); __b2c__res = strstr(__b2c__sbuffer[__b2c__sbuffer_ptr] + __b2c__pos - 1, __b2c__tmp);" >> $g_HFILE
echo "if(__b2c__res == NULL) return (0); return (__b2c__res - __b2c__sbuffer[__b2c__sbuffer_ptr] + 1);}" >> $g_HFILE
echo "#define INSTR(...) __b2c__instr(__VA_ARGS__, -1)" >> $g_HFILE
echo "long __b2c__instrrev(char *__b2c__first, ...){char *__b2c__tmp; char *__b2c__res = NULL; int __b2c__pos; __b2c__sbuffer_ptr++; if(__b2c__sbuffer_ptr >= $g_MAX_BUFFERS) __b2c__sbuffer_ptr=0;" >> $g_HFILE
echo "va_list __b2c__ap; if(__b2c__first == NULL) return (0); __b2c__sbuffer[__b2c__sbuffer_ptr] = (char*)realloc(__b2c__sbuffer[__b2c__sbuffer_ptr], (strlen(__b2c__first)+1)*sizeof(char));" >> $g_HFILE
echo "strcpy(__b2c__sbuffer[__b2c__sbuffer_ptr], __b2c__first); va_start(__b2c__ap, __b2c__first);" >> $g_HFILE
echo "__b2c__tmp = va_arg(__b2c__ap, char *); if(__b2c__tmp == NULL || strlen(__b2c__tmp) == 0) return (0);__b2c__pos = va_arg(__b2c__ap, int);" >> $g_HFILE
echo "if(__b2c__pos <= 0) __b2c__pos = 1; va_end(__b2c__ap); while(__b2c__res == NULL && __b2c__pos <= strlen(__b2c__sbuffer[__b2c__sbuffer_ptr])) {" >> $g_HFILE
echo "__b2c__res = strstr(__b2c__sbuffer[__b2c__sbuffer_ptr] + strlen(__b2c__sbuffer[__b2c__sbuffer_ptr]) - __b2c__pos, __b2c__tmp); __b2c__pos+=1;}" >> $g_HFILE
echo "if(__b2c__res == NULL) return (0); return (__b2c__res - __b2c__sbuffer[__b2c__sbuffer_ptr] + 1);}" >> $g_HFILE
echo "#define INSTRREV(...) __b2c__instrrev(__VA_ARGS__, -1)" >> $g_HFILE
echo "char* __b2c__spc(int __b2c__x){__b2c__sbuffer_ptr++; if(__b2c__sbuffer_ptr >= $g_MAX_BUFFERS) __b2c__sbuffer_ptr=0;" >> $g_HFILE
echo "__b2c__sbuffer[__b2c__sbuffer_ptr] = (char*)realloc(__b2c__sbuffer[__b2c__sbuffer_ptr], __b2c__x*sizeof(char)+1*sizeof(char));" >> $g_HFILE
echo "memset(__b2c__sbuffer[__b2c__sbuffer_ptr], 0, __b2c__x*sizeof(char)+1*sizeof(char));" >> $g_HFILE
echo "memset(__b2c__sbuffer[__b2c__sbuffer_ptr], 32, __b2c__x); return(__b2c__sbuffer[__b2c__sbuffer_ptr]);}" >> $g_HFILE
echo "#define SPC${g_STRINGSIGN}(x) ((x > -1) ? __b2c__spc(x) : \"\")" >> $g_HFILE
echo "char* __b2c__tab(int __b2c__x){__b2c__sbuffer_ptr++; if(__b2c__sbuffer_ptr >= $g_MAX_BUFFERS) __b2c__sbuffer_ptr=0;" >> $g_HFILE
echo "__b2c__sbuffer[__b2c__sbuffer_ptr] = (char*)realloc(__b2c__sbuffer[__b2c__sbuffer_ptr], __b2c__x*sizeof(char)+1*sizeof(char));" >> $g_HFILE
echo "memset(__b2c__sbuffer[__b2c__sbuffer_ptr], 0, __b2c__x*sizeof(char)+1*sizeof(char));" >> $g_HFILE
echo "memset(__b2c__sbuffer[__b2c__sbuffer_ptr], 9, __b2c__x); return(__b2c__sbuffer[__b2c__sbuffer_ptr]);}" >> $g_HFILE
echo "#define TAB${g_STRINGSIGN}(x) ((x > -1) ? __b2c__tab(x) : \"\")" >> $g_HFILE
echo "char* __b2c__fill(unsigned long __b2c__x, unsigned char __b2c__y){__b2c__sbuffer_ptr++; if(__b2c__sbuffer_ptr >= $g_MAX_BUFFERS) __b2c__sbuffer_ptr=0;" >> $g_HFILE
echo "__b2c__sbuffer[__b2c__sbuffer_ptr] = (char*)realloc(__b2c__sbuffer[__b2c__sbuffer_ptr], __b2c__x*sizeof(char)+1*sizeof(char));" >> $g_HFILE
echo "memset(__b2c__sbuffer[__b2c__sbuffer_ptr], 0, __b2c__x*sizeof(char)+1*sizeof(char));" >> $g_HFILE
echo "memset(__b2c__sbuffer[__b2c__sbuffer_ptr], __b2c__y, __b2c__x); return(__b2c__sbuffer[__b2c__sbuffer_ptr]);}" >> $g_HFILE
echo "#define FILL${g_STRINGSIGN}(x, y) ((y > -1 && y < 256) ? __b2c__fill(x, y) : \"\")" >> $g_HFILE
echo "char* __b2c__chop(char *__b2c__src, ...){char *__b2c__tmp, *__b2c__str; int __b2c__i, __b2c__loc = 0; va_list __b2c__ap; if(strlen(__b2c__src) == 0) return(__b2c__src);" >> $g_HFILE
echo "va_start (__b2c__ap, __b2c__src); __b2c__str = va_arg (__b2c__ap, char*); if(__b2c__str == 0) __b2c__str = (char*)__b2c__chop_default; else __b2c__loc = va_arg (__b2c__ap, int); va_end (__b2c__ap);" >> $g_HFILE
echo "if(__b2c__loc == 0 || __b2c__loc == 1) {while (*__b2c__src != '\0') {for(__b2c__i = 0; __b2c__i < strlen(__b2c__str); __b2c__i++) {if (*__b2c__src == *(__b2c__str+__b2c__i)) {__b2c__src++; break; } }" >> $g_HFILE
echo "if(__b2c__i == strlen(__b2c__str)) break;} if (*__b2c__src == '\0') return(\"\");} __b2c__tmp = __b2c__src + strlen(__b2c__src) - 1;" >> $g_HFILE
echo "if(__b2c__loc == 0 || __b2c__loc == 2) {while (__b2c__tmp >= __b2c__src && *__b2c__tmp != '\0') {for(__b2c__i = 0; __b2c__i < strlen(__b2c__str); __b2c__i++) {if (*__b2c__tmp == *(__b2c__str+__b2c__i))" >> $g_HFILE
echo "{__b2c__tmp--; break; } } if(__b2c__i == strlen(__b2c__str)) break;} } __b2c__sbuffer_ptr++; if(__b2c__sbuffer_ptr >= $g_MAX_BUFFERS) __b2c__sbuffer_ptr=0;" >> $g_HFILE
echo "__b2c__sbuffer[__b2c__sbuffer_ptr] = (char*)realloc(__b2c__sbuffer[__b2c__sbuffer_ptr], (strlen(__b2c__src)+1)*sizeof(char));" >> $g_HFILE
echo "for(__b2c__i = 0; __b2c__i <= __b2c__tmp - __b2c__src; __b2c__i++) __b2c__sbuffer[__b2c__sbuffer_ptr][__b2c__i]=__b2c__src[__b2c__i];" >> $g_HFILE
echo "__b2c__sbuffer[__b2c__sbuffer_ptr][__b2c__i] = '\0'; return (__b2c__sbuffer[__b2c__sbuffer_ptr]);}" >> $g_HFILE
echo "#define CHOP${g_STRINGSIGN}(...) __b2c__chop(__VA_ARGS__, 0)" >> $g_HFILE
echo "char* __b2c__replace(char* __b2c__x, char* __b2c__y, char* __b2c__z){" >> $g_HFILE
echo "char *__b2c__tmp, *__b2c__buf, *__b2c__haystack, *__b2c__dup = NULL; __b2c__sbuffer_ptr++;" >> $g_HFILE
echo "if(__b2c__sbuffer_ptr >= $g_MAX_BUFFERS) __b2c__sbuffer_ptr=0; __b2c__haystack = strdup(__b2c__x); __b2c__dup = __b2c__haystack;" >> $g_HFILE
echo "__b2c__buf = calloc(1, sizeof(char)); while((__b2c__tmp = strstr(__b2c__haystack, __b2c__y)) != NULL) {*__b2c__tmp = '\0';" >> $g_HFILE
echo "__b2c__buf = realloc(__b2c__buf, (strlen(__b2c__buf) + strlen(__b2c__haystack) + strlen(__b2c__z) + 1)*sizeof(char));" >> $g_HFILE
echo "strcat(__b2c__buf, __b2c__haystack);strcat(__b2c__buf, __b2c__z);__b2c__haystack = __b2c__tmp+strlen(__b2c__y);}" >> $g_HFILE
echo "__b2c__buf = realloc(__b2c__buf, (strlen(__b2c__buf) + strlen(__b2c__haystack) + 1)*sizeof(char));strcat(__b2c__buf, __b2c__haystack);" >> $g_HFILE
echo "__b2c__sbuffer[__b2c__sbuffer_ptr] = (char*)realloc(__b2c__sbuffer[__b2c__sbuffer_ptr], (strlen(__b2c__buf)+1)*sizeof(char));" >> $g_HFILE
echo "strcpy(__b2c__sbuffer[__b2c__sbuffer_ptr], __b2c__buf);free(__b2c__buf);free(__b2c__dup);return (__b2c__sbuffer[__b2c__sbuffer_ptr]);}" >> $g_HFILE
echo "#define REPLACE${g_STRINGSIGN}(x, y, z)((x!=NULL && y!=NULL && z!= NULL) ? __b2c__replace(x, y, z) : 0)" >> $g_HFILE
echo "#define LEN(x) ((x != NULL) ? strlen(x) : 0)" >> $g_HFILE
echo "#define EQUAL(__b2c__x, __b2c__y) ((__b2c__x != NULL && __b2c__y != NULL && __b2c__option_compare == 0) ? !strcmp(__b2c__x, __b2c__y) : ((__b2c__x != NULL && __b2c__y != NULL && __b2c__option_compare == 1) ? !strcasecmp(__b2c__x, __b2c__y) : 0) )" >> $g_HFILE
echo "char * __b2c__getenv(char *__b2c__env){static char * __b2c__tmp; __b2c__tmp = getenv(__b2c__env); if (__b2c__tmp == NULL)" >> $g_HFILE
echo "{return \"\";} return __b2c__tmp;}" >> $g_HFILE
echo "#define GETENVIRON${g_STRINGSIGN}(x) ((x != NULL) ? __b2c__getenv(x) : \"null\")" >> $g_HFILE
echo "#define SETENVIRON(x, y) if(x != NULL && y != NULL) setenv(x, y, 1)" >> $g_HFILE
echo >> $g_HFILE
echo "/* CHAR functions */" >> $g_HFILE
echo "#include <ctype.h>" >> $g_HFILE
echo "char* __b2c__ucase(char *__b2c__s){int __b2c__i; __b2c__sbuffer_ptr++; if(__b2c__sbuffer_ptr >= $g_MAX_BUFFERS) __b2c__sbuffer_ptr=0;" >> $g_HFILE
echo "__b2c__sbuffer[__b2c__sbuffer_ptr] = (char*)realloc(__b2c__sbuffer[__b2c__sbuffer_ptr], strlen(__b2c__s)*sizeof(char)+1*sizeof(char));" >> $g_HFILE
echo "memset(__b2c__sbuffer[__b2c__sbuffer_ptr], 0, strlen(__b2c__s)*sizeof(char)+1*sizeof(char));" >> $g_HFILE
echo "for(__b2c__i=0; __b2c__i < strlen(__b2c__s); __b2c__i++){__b2c__sbuffer[__b2c__sbuffer_ptr][__b2c__i]=toupper(__b2c__s[__b2c__i]);}" >> $g_HFILE
echo "return(__b2c__sbuffer[__b2c__sbuffer_ptr]);}" >> $g_HFILE
echo "#define UCASE${g_STRINGSIGN}(x) ((x != NULL) ? __b2c__ucase(x) : \"null\")" >> $g_HFILE
echo "char* __b2c__lcase(char *__b2c__s){int __b2c__i; __b2c__sbuffer_ptr++; if(__b2c__sbuffer_ptr >= $g_MAX_BUFFERS) __b2c__sbuffer_ptr=0;" >> $g_HFILE
echo "__b2c__sbuffer[__b2c__sbuffer_ptr] = (char*)realloc(__b2c__sbuffer[__b2c__sbuffer_ptr], strlen(__b2c__s)*sizeof(char)+1*sizeof(char));" >> $g_HFILE
echo "memset(__b2c__sbuffer[__b2c__sbuffer_ptr], 0, strlen(__b2c__s)*sizeof(char)+1*sizeof(char));" >> $g_HFILE
echo "for(__b2c__i=0; __b2c__i < strlen(__b2c__s); __b2c__i++){__b2c__sbuffer[__b2c__sbuffer_ptr][__b2c__i]=tolower(__b2c__s[__b2c__i]);}" >> $g_HFILE
echo "return(__b2c__sbuffer[__b2c__sbuffer_ptr]);}" >> $g_HFILE
echo "#define LCASE${g_STRINGSIGN}(x) ((x != NULL) ? __b2c__lcase(x) : \"null\")" >> $g_HFILE
echo >> $g_HFILE
echo "/* I/O functions */" >> $g_HFILE
echo "FILE *__b2c__inFile; FILE *__b2c__outFile; int __b2c__Byte; struct dirent *__b2c__dir;" >> $g_HFILE
echo "char* __b2c__dec2hex(int __b2c__i){__b2c__sbuffer_ptr++; if(__b2c__sbuffer_ptr >= $g_MAX_BUFFERS) __b2c__sbuffer_ptr=0;" >> $g_HFILE
echo "__b2c__sbuffer[__b2c__sbuffer_ptr] = (char*)realloc(__b2c__sbuffer[__b2c__sbuffer_ptr], $g_MAX_DIGITS);" >> $g_HFILE
echo "memset(__b2c__sbuffer[__b2c__sbuffer_ptr], 0, $g_MAX_DIGITS);" >> $g_HFILE
echo "snprintf(__b2c__sbuffer[__b2c__sbuffer_ptr], $g_MAX_DIGITS, \"%X\", __b2c__i); return(__b2c__sbuffer[__b2c__sbuffer_ptr]);}" >> $g_HFILE
echo "long __b2c__hex2dec(char *__b2c__h){unsigned int __b2c__i; if(sscanf(__b2c__h, \"%X\", &__b2c__i) == EOF && !__b2c__trap){ERROR = 5;" >> $g_HFILE
echo "fprintf(stderr, \"%s\n\", ERR${g_STRINGSIGN}(ERROR)); exit(ERROR);} return(long)(__b2c__i);}" >> $g_HFILE
echo "unsigned char __b2c__char2asc(char *__b2c__c){return (unsigned char)*__b2c__c;}" >> $g_HFILE
echo "char* __b2c__asc2char(int __b2c__i){__b2c__sbuffer_ptr++; if(__b2c__sbuffer_ptr >= $g_MAX_BUFFERS) __b2c__sbuffer_ptr=0;" >> $g_HFILE
echo "__b2c__sbuffer[__b2c__sbuffer_ptr] = (char*)realloc(__b2c__sbuffer[__b2c__sbuffer_ptr], 2*sizeof(char));" >> $g_HFILE
echo "memset(__b2c__sbuffer[__b2c__sbuffer_ptr], 0, 2*sizeof(char)); snprintf(__b2c__sbuffer[__b2c__sbuffer_ptr], 2, \"%c\", __b2c__i);" >> $g_HFILE
echo "return(__b2c__sbuffer[__b2c__sbuffer_ptr]);}" >> $g_HFILE
echo "/* Function FILEEXISTS contributed by Armando Rivera */ " >> $g_HFILE
echo "long __b2c__fileexists(const char *__b2c__x) {struct stat __b2c__buf; if (stat(__b2c__x, &__b2c__buf) != -1) return 1; return 0;}" >> $g_HFILE
echo "#define FILEEXISTS(x) __b2c__fileexists(x)" >> $g_HFILE
echo "long __b2c__filelen(const char *__b2c__x) {struct stat __b2c__buf; if(stat(__b2c__x, &__b2c__buf) < 0 && !__b2c__trap){ERROR = 24; fprintf(stderr, \"%s\n\", ERR${g_STRINGSIGN}(ERROR)); exit(ERROR);}" >> $g_HFILE
echo "if(__b2c__x == NULL || stat(__b2c__x, &__b2c__buf) < 0) return -1; else return(long)(__b2c__buf.st_size);}" >> $g_HFILE
echo "#define FILELEN(x) __b2c__filelen(x)" >> $g_HFILE
echo "long __b2c__filetype(const char *__b2c__x) {struct stat __b2c__buf; if(__b2c__x == NULL) return 0; if(stat(__b2c__x, &__b2c__buf) < 0 && !__b2c__trap)" >> $g_HFILE
echo "{ERROR = 24; fprintf(stderr, \"%s\n\", ERR${g_STRINGSIGN}(ERROR)); exit(ERROR);}" >> $g_HFILE
echo "if (S_ISREG(__b2c__buf.st_mode)) return 1; if (S_ISDIR(__b2c__buf.st_mode)) return 2;" >> $g_HFILE
echo "if (S_ISCHR(__b2c__buf.st_mode)) return 3; if (S_ISBLK(__b2c__buf.st_mode)) return 4; if (S_ISFIFO(__b2c__buf.st_mode)) return 5;" >> $g_HFILE
echo "if (S_ISLNK(__b2c__buf.st_mode)) return 6; if (S_ISSOCK(__b2c__buf.st_mode)) return 7; return 0;}" >> $g_HFILE
echo "#define FILETYPE(x) __b2c__filetype(x)" >> $g_HFILE
echo "long __b2c__search(FILE* __b2c__x, char* __b2c__y){long __b2c__off, __b2c__pos; char* __b2c__ptr; size_t __b2c__tot;" >> $g_HFILE
echo "if(__b2c__x == NULL && !__b2c__trap){ERROR = 2; fprintf(stderr, \"%s\n\", ERR${g_STRINGSIGN}(ERROR)); exit(ERROR);}" >> $g_HFILE
echo "if(__b2c__y == NULL && !__b2c__trap){ERROR = 25; fprintf(stderr, \"%s\n\", ERR${g_STRINGSIGN}(ERROR)); exit(ERROR);}" >> $g_HFILE
echo "__b2c__pos = ftell(__b2c__x); __b2c__ptr = (char*)malloc((strlen(__b2c__y)+1)*sizeof(char)); __b2c__off = 0; do {" >> $g_HFILE
echo "fseek(__b2c__x, __b2c__off, SEEK_SET); memset(__b2c__ptr, 0, sizeof(char)*(strlen(__b2c__y)+1));" >> $g_HFILE
echo "__b2c__tot = fread(__b2c__ptr, sizeof(char), strlen(__b2c__y), __b2c__x);__b2c__off+=1;" >> $g_HFILE
echo "} while(!feof(__b2c__x) && strncmp(__b2c__ptr, __b2c__y, strlen(__b2c__y)));" >> $g_HFILE
echo "if(strncmp(__b2c__ptr, __b2c__y, strlen(__b2c__y))) __b2c__off = 0; fseek(__b2c__x, __b2c__pos, SEEK_SET); free(__b2c__ptr); return (--__b2c__off);}" >> $g_HFILE
echo "#define SEARCH(x, y) __b2c__search(x, y)" >> $g_HFILE
echo "char *__b2c__exec(char *__b2c__x, ...){int __b2c__r, __b2c__len, __b2c__i, __b2c__page; int __b2c__wpipe[2], __b2c__rpipe[2]; char *__b2c__str, *__b2c__ans = NULL; va_list __b2c__ap;" >> $g_HFILE
echo "va_start(__b2c__ap, __b2c__x); __b2c__str = va_arg (__b2c__ap, char*); va_end(__b2c__ap); if (pipe (__b2c__rpipe) < 0 || pipe (__b2c__wpipe) < 0){if(!__b2c__trap) {ERROR=29;fprintf(stderr, \"%s\n\", ERR${g_STRINGSIGN}(ERROR)); exit(ERROR);}}" >> $g_HFILE
echo "if ((__b2c__r = fork ()) < 0){if(!__b2c__trap) {ERROR=29;fprintf(stderr, \"%s\n\", ERR${g_STRINGSIGN}(ERROR)); exit(ERROR);}} else if (__b2c__r == 0){" >> $g_HFILE
echo "close(__b2c__wpipe[1]);close (__b2c__rpipe[0]);dup2 (__b2c__wpipe[0], STDIN_FILENO);close (__b2c__wpipe[0]);dup2 (__b2c__rpipe[1], STDOUT_FILENO);close (__b2c__rpipe[1]); __b2c__r = system (__b2c__x); if(WIFEXITED(__b2c__r)) RETVAL = WEXITSTATUS(__b2c__r); else RETVAL=0; exit(RETVAL);}" >> $g_HFILE
echo "else{close (__b2c__wpipe[0]);close (__b2c__rpipe[1]); __b2c__sbuffer_ptr++; if(__b2c__sbuffer_ptr >= $g_MAX_BUFFERS) __b2c__sbuffer_ptr=0;" >> $g_HFILE
echo "__b2c__sbuffer[__b2c__sbuffer_ptr] = (char*)realloc(__b2c__sbuffer[__b2c__sbuffer_ptr], $g_BUFFER_SIZE*sizeof(char) + 1);__b2c__ans = (char *) malloc ($g_BUFFER_SIZE * sizeof (char)); __b2c__len = 0;__b2c__page = 0;" >> $g_HFILE
echo "if(__b2c__str!=NULL) __b2c__i = write(__b2c__wpipe[1], __b2c__str, strlen(__b2c__str)+1); wait(&RETVAL); RETVAL = WEXITSTATUS(RETVAL); do{__b2c__i = read (__b2c__rpipe[0], __b2c__ans, $g_BUFFER_SIZE);if (__b2c__i == -1 && !__b2c__trap){ERROR=30;fprintf(stderr, \"%s\n\", ERR${g_STRINGSIGN}(ERROR)); exit(ERROR);}" >> $g_HFILE
echo "if (__b2c__i == 0)break;if (__b2c__len + __b2c__i > $g_BUFFER_SIZE * __b2c__page + 1){__b2c__page++;__b2c__sbuffer[__b2c__sbuffer_ptr] = realloc (__b2c__sbuffer[__b2c__sbuffer_ptr], $g_BUFFER_SIZE * __b2c__page + 1);" >> $g_HFILE
echo "if (__b2c__sbuffer[__b2c__sbuffer_ptr] == NULL && !__b2c__trap){ERROR=6; fprintf(stderr, \"%s\n\", ERR${g_STRINGSIGN}(ERROR)); exit(ERROR);} } memcpy (__b2c__sbuffer[__b2c__sbuffer_ptr] + __b2c__len, __b2c__ans, __b2c__i);" >> $g_HFILE
echo " __b2c__len += __b2c__i;} while (__b2c__i > 0); __b2c__sbuffer[__b2c__sbuffer_ptr][__b2c__len] = '\0';close (__b2c__wpipe[1]);" >> $g_HFILE
echo "close (__b2c__rpipe[0]);free (__b2c__ans);} return (__b2c__sbuffer[__b2c__sbuffer_ptr]);}" >> $g_HFILE
echo "#define EXEC${g_STRINGSIGN}(...) __b2c__exec(__VA_ARGS__, (char*)NULL)" >> $g_HFILE
echo "#define ENDFILE(x) feof(x)" >> $g_HFILE
echo "#define TELL(x) ftell(x)" >> $g_HFILE
echo "#define HEX${g_STRINGSIGN}(x) __b2c__dec2hex(x)" >> $g_HFILE
echo "#define DEC(x) __b2c__hex2dec(x)" >> $g_HFILE
echo "#define ASC(x) __b2c__char2asc(x)" >> $g_HFILE
echo "#define CHR${g_STRINGSIGN}(__b2c__x) __b2c__asc2char(__b2c__x)" >> $g_HFILE
echo "#define MEMTELL(x) (long)x" >> $g_HFILE
echo >> $g_HFILE
echo "/* Dynamic loading, errors */" >> $g_HFILE
echo "#include <dlfcn.h>" >> $g_HFILE
echo "#include <errno.h>" >> $g_HFILE
echo >> $g_HFILE
echo "/* GETKEY */" >> $g_HFILE
echo "#include <termios.h>" >> $g_HFILE
echo "long __b2c__getch(){long __b2c__ch; struct termios __b2c__oldt, __b2c__newt; tcgetattr(STDIN_FILENO, &__b2c__oldt);" >> $g_HFILE
echo "__b2c__newt = __b2c__oldt; __b2c__newt.c_lflag &= ~(ICANON | ECHO); __b2c__newt.c_cc[VMIN]=1; __b2c__newt.c_cc[VTIME]=0; tcsetattr(STDIN_FILENO, TCSANOW, &__b2c__newt);" >> $g_HFILE
echo "__b2c__ch = getchar(); tcsetattr(STDIN_FILENO, TCSANOW, &__b2c__oldt); return __b2c__ch;} " >> $g_HFILE
echo "#define GETKEY __b2c__getch()" >> $g_HFILE
echo "long __b2c__getxy(int __b2c__type){char __b2c__asw[$g_BUFFER_SIZE]; struct termios __b2c__old, __b2c__new; int __b2c__len, __b2c__x, __b2c__y; ssize_t __b2c__tot;" >> $g_HFILE
echo "tcgetattr(STDIN_FILENO, &__b2c__old); __b2c__new = __b2c__old;__b2c__new.c_lflag &= ~(ICANON | ECHO); tcsetattr(STDIN_FILENO, TCSANOW, &__b2c__new);" >> $g_HFILE
echo "__b2c__tot = write(STDOUT_FILENO, \"\033[6n\", strlen(\"\033[6n\")); __b2c__len = read(STDIN_FILENO, __b2c__asw, $g_BUFFER_SIZE);__b2c__asw[__b2c__len] = '\0'; " >> $g_HFILE
echo "tcsetattr(STDIN_FILENO, TCSANOW, &__b2c__old); sscanf(__b2c__asw, \"\033[%d;%dR\", &__b2c__y, &__b2c__x); if (!__b2c__type) return(long)__b2c__x; return(long)__b2c__y;}" >> $g_HFILE
echo "#define GETX __b2c__getxy(0)" >> $g_HFILE
echo "#define GETY __b2c__getxy(1)" >> $g_HFILE
echo "long __b2c__screen(int __b2c__type){long __b2c__x; fprintf(stdout,\"\033[s\"); fprintf(stdout,\"\033[?25l\"); fprintf(stdout,\"\033[999;999H\"); fflush(stdout);" >> $g_HFILE
echo "__b2c__x = __b2c__getxy(__b2c__type); fprintf(stdout,\"\033[u\"); fprintf(stdout,\"\033[?25h\");fflush(stdout); return(__b2c__x); }" >> $g_HFILE
echo "#define COLUMNS __b2c__screen(0)" >> $g_HFILE
echo "#define ROWS __b2c__screen(1)" >> $g_HFILE
echo >> $g_HFILE
echo "/* Constants, logical stuff */" >> $g_HFILE
echo "#define PI 3.14159265" >> $g_HFILE
echo "#define NOT(__b2c__x) (!(__b2c__x))" >> $g_HFILE
echo "#define AND &&" >> $g_HFILE
echo "#define OR ||" >> $g_HFILE
echo "#define EQ ==" >> $g_HFILE
echo "#define IS ==" >> $g_HFILE
echo "#define NE !=" >> $g_HFILE
echo "#define ISNOT !=" >> $g_HFILE
echo "#define TRUE 1" >> $g_HFILE
echo "#define FALSE 0" >> $g_HFILE
echo "#define NL${g_STRINGSIGN} \"\n\"" >> $g_HFILE
echo "#define STRING char*" >> $g_HFILE
echo "#define NUMBER long" >> $g_HFILE
echo "#define FLOATING double" >> $g_HFILE
echo "#define ISTRUE(__b2c__x) (__b2c__x!=0)" >> $g_HFILE
echo "#define ISFALSE(__b2c__x) (__b2c__x==0)" >> $g_HFILE
echo "#define SIZEOF(__b2c__x) sizeof(__b2c__x)" >> $g_HFILE
echo >> $g_HFILE
echo "/* Date and time */" >> $g_HFILE
echo "#include <time.h>" >> $g_HFILE
echo "#define NOW (long)time(NULL)" >> $g_HFILE
echo "long __b2c__time(time_t __b2c__now, int __b2c__which){struct tm *ts; __b2c__sbuffer_ptr++; if(__b2c__sbuffer_ptr >= $g_MAX_BUFFERS) __b2c__sbuffer_ptr=0;" >> $g_HFILE
echo "__b2c__sbuffer_ptr++; if(__b2c__sbuffer_ptr >= $g_MAX_BUFFERS) __b2c__sbuffer_ptr=0;" >> $g_HFILE
echo "__b2c__sbuffer[__b2c__sbuffer_ptr] = (char*)realloc(__b2c__sbuffer[__b2c__sbuffer_ptr], $g_MAX_DIGITS);" >> $g_HFILE
echo "memset(__b2c__sbuffer[__b2c__sbuffer_ptr], 0, $g_MAX_DIGITS); ts = localtime(&__b2c__now); switch(__b2c__which) { case 1: strftime(__b2c__sbuffer[__b2c__sbuffer_ptr], $g_MAX_DIGITS, \"%d\", ts); break;" >> $g_HFILE
echo "case 2: strftime(__b2c__sbuffer[__b2c__sbuffer_ptr], $g_MAX_DIGITS, \"%m\", ts); break; case 3: strftime(__b2c__sbuffer[__b2c__sbuffer_ptr], $g_MAX_DIGITS, \"%Y\", ts); break;" >> $g_HFILE
echo "case 4: strftime(__b2c__sbuffer[__b2c__sbuffer_ptr], $g_MAX_DIGITS, \"%H\", ts); break; case 5: strftime(__b2c__sbuffer[__b2c__sbuffer_ptr], $g_MAX_DIGITS, \"%M\", ts); break;" >> $g_HFILE
echo "case 6: strftime(__b2c__sbuffer[__b2c__sbuffer_ptr], $g_MAX_DIGITS, \"%S\", ts); break; case 7: strftime(__b2c__sbuffer[__b2c__sbuffer_ptr], $g_MAX_DIGITS, \"%W\", ts); break;}" >> $g_HFILE
echo "return(atol(__b2c__sbuffer[__b2c__sbuffer_ptr]));}" >> $g_HFILE
echo "#define DAY(x) __b2c__time(x, 1)" >> $g_HFILE
echo "#define MONTH(x) __b2c__time(x, 2)" >> $g_HFILE
echo "#define YEAR(x) __b2c__time(x, 3)" >> $g_HFILE
echo "#define HOUR(x) __b2c__time(x, 4)" >> $g_HFILE
echo "#define MINUTE(x) __b2c__time(x, 5)" >> $g_HFILE
echo "#define SECOND(x) __b2c__time(x, 6)" >> $g_HFILE
echo "#define WEEK(x) __b2c__time(x, 7)" >> $g_HFILE
echo "char * __b2c__datename(time_t __b2c__now, int __b2c__which){struct tm *ts; __b2c__sbuffer_ptr++; if(__b2c__sbuffer_ptr >= $g_MAX_BUFFERS) __b2c__sbuffer_ptr=0;" >> $g_HFILE
echo "__b2c__sbuffer_ptr++; if(__b2c__sbuffer_ptr >= $g_MAX_BUFFERS) __b2c__sbuffer_ptr=0;" >> $g_HFILE
echo "__b2c__sbuffer[__b2c__sbuffer_ptr] = (char*)realloc(__b2c__sbuffer[__b2c__sbuffer_ptr], $g_MAX_DIGITS);" >> $g_HFILE
echo "memset(__b2c__sbuffer[__b2c__sbuffer_ptr], 0, $g_MAX_DIGITS); ts = localtime(&__b2c__now); switch(__b2c__which){case 1: strftime(__b2c__sbuffer[__b2c__sbuffer_ptr], $g_MAX_DIGITS, \"%A\", ts); break;" >> $g_HFILE
echo "case 2: strftime(__b2c__sbuffer[__b2c__sbuffer_ptr], $g_MAX_DIGITS, \"%B\", ts); break;} return(__b2c__sbuffer[__b2c__sbuffer_ptr]);}" >> $g_HFILE
echo "#define WEEKDAY${g_STRINGSIGN}(x) __b2c__datename(x, 1)" >> $g_HFILE
echo "#define MONTH${g_STRINGSIGN}(x) __b2c__datename(x, 2)" >> $g_HFILE
echo "unsigned long __b2c__epoch(int __b2c__year, int __b2c__month, int __b2c__day, int __b2c__hour, int __b2c__minute, int __b2c__second){" >> $g_HFILE
echo "struct tm tm; time_t __b2c__t; tm.tm_year = __b2c__year - 1900; tm.tm_mon = __b2c__month - 1; tm.tm_mday = __b2c__day;" >> $g_HFILE
echo "tm.tm_hour = __b2c__hour; tm.tm_min = __b2c__minute; tm.tm_sec = __b2c__second;" >> $g_HFILE
echo "tm.tm_isdst = -1; __b2c__t = mktime(&tm); if (__b2c__t == -1) return (0); return(long) __b2c__t; }" >> $g_HFILE
echo "#define TIMEVALUE(x,y,z,a,b,c) __b2c__epoch(x,y,z,a,b,c)" >> $g_HFILE
echo "char* __b2c__os(void){struct utsname __b2c__buf; __b2c__sbuffer_ptr++; if(__b2c__sbuffer_ptr >= $g_MAX_BUFFERS) __b2c__sbuffer_ptr=0;" >> $g_HFILE
echo "__b2c__sbuffer[__b2c__sbuffer_ptr] = (char*)realloc(__b2c__sbuffer[__b2c__sbuffer_ptr], $g_BUFFER_SIZE);" >> $g_HFILE
echo "memset(__b2c__sbuffer[__b2c__sbuffer_ptr], 0, $g_BUFFER_SIZE); if(uname(&__b2c__buf) < 0 && !__b2c__trap) {ERROR = 26; fprintf(stderr, \"%s\n\", ERR${g_STRINGSIGN}(ERROR)); exit(ERROR);}" >> $g_HFILE
echo "strcpy(__b2c__sbuffer[__b2c__sbuffer_ptr], __b2c__buf.sysname); strcat(__b2c__sbuffer[__b2c__sbuffer_ptr], \" \");" >> $g_HFILE
echo "strcat(__b2c__sbuffer[__b2c__sbuffer_ptr], __b2c__buf.machine); return(__b2c__sbuffer[__b2c__sbuffer_ptr]);}" >> $g_HFILE
echo "#define OS${g_STRINGSIGN} __b2c__os()" >> $g_HFILE
echo >> $g_HFILE
echo "/* Peek and Poke */" >> $g_HFILE
echo "struct stat __b2c__sb;" >>  $g_HFILE
echo "void __b2c__memory__check(void* __b2c__x) {if (stat(__b2c__x, &__b2c__sb) == -1 && errno == EFAULT) {ERROR = 1;} }" >> $g_HFILE
echo "long __b2c__malloc(long __b2c__x) {void *__b2c__mem; if(__b2c__x==0) return(0); switch(__b2c__memtype) {case 1: __b2c__mem = calloc(__b2c__x+__b2c__option_memstream, sizeof(char)); break;" >> $g_HFILE
echo "case 2: __b2c__mem = calloc(__b2c__x+__b2c__option_memstream, sizeof(short)); break; case 3: __b2c__mem = calloc(__b2c__x+__b2c__option_memstream, sizeof(int)); break;" >> $g_HFILE
echo "case 4: __b2c__mem = calloc(__b2c__x+__b2c__option_memstream, sizeof(long)); break; case 5: __b2c__mem = calloc(__b2c__x+__b2c__option_memstream, sizeof(float)); break;" >> $g_HFILE
echo "case 6: __b2c__mem = calloc(__b2c__x+__b2c__option_memstream, sizeof(double)); break; case 7: __b2c__mem = calloc(__b2c__x+__b2c__option_memstream, sizeof(char)); break;}" >> $g_HFILE
echo "if(__b2c__mem == NULL && !__b2c__trap) {ERROR = 6; fprintf(stderr, \"%s\n\", ERR${g_STRINGSIGN}(ERROR)); exit(ERROR);} return(long)__b2c__mem;}" >> $g_HFILE
echo "#define MEMORY(__b2c__x) __b2c__malloc(__b2c__x)" >> $g_HFILE
echo "void *__b2c__realloc(void* __b2c__x, long __b2c__y) {if(__b2c__x == NULL) return (NULL); if(!__b2c__trap) {__b2c__memory__check((char*)__b2c__x);" >> $g_HFILE
echo "if(ERROR) {fprintf(stderr, \"%s\n\", ERR${g_STRINGSIGN}(ERROR)); exit(ERROR);} } switch(__b2c__memtype) {case 1: __b2c__x = realloc((void*)__b2c__x, sizeof(char)*(__b2c__y+1)); break;" >> $g_HFILE
echo "case 2: __b2c__x = realloc((void*)__b2c__x, sizeof(short)*(__b2c__y+1)); break; case 3: __b2c__x = realloc((void*)__b2c__x, sizeof(int)*(__b2c__y+1)); break;" >> $g_HFILE
echo "case 4: __b2c__x = realloc((void*)__b2c__x, sizeof(long)*(__b2c__y+1)); break; case 5: __b2c__x = realloc((void*)__b2c__x, sizeof(float)*(__b2c__y+1)); break;" >> $g_HFILE
echo "case 6: __b2c__x = realloc((void*)__b2c__x, sizeof(double)*(__b2c__y+1)); break; case 7: __b2c__x = realloc((void*)__b2c__x, sizeof(char)*(__b2c__y+1)); break;}" >> $g_HFILE
echo "if(__b2c__x == NULL && !__b2c__trap) {ERROR = 6; fprintf(stderr, \"%s\n\", ERR${g_STRINGSIGN}(ERROR)); exit(ERROR);} return (__b2c__x);}" >> $g_HFILE
echo "#define RESIZE(__b2c__x, __b2c__y) __b2c__realloc((void*)__b2c__x, __b2c__y)" >> $g_HFILE
echo "char __b2c__peek(char* __b2c__x) {if(!__b2c__trap) {__b2c__memory__check((char*) __b2c__x); if(ERROR) {fprintf(stderr, \"%s\n\", ERR${g_STRINGSIGN}(ERROR)); exit(ERROR);} } return((char)*__b2c__x);}" >> $g_HFILE
echo "short __b2c__peeks(short* __b2c__x) {if(!__b2c__trap) {__b2c__memory__check((short*) __b2c__x); if(ERROR) {fprintf(stderr, \"%s\n\", ERR${g_STRINGSIGN}(ERROR)); exit(ERROR);} } return((short)*__b2c__x);}" >> $g_HFILE
echo "int __b2c__peeki(int* __b2c__x) {if(!__b2c__trap) {__b2c__memory__check((int*) __b2c__x); if(ERROR) {fprintf(stderr, \"%s\n\", ERR${g_STRINGSIGN}(ERROR)); exit(ERROR);} } return((int)*__b2c__x);}" >> $g_HFILE
echo "long __b2c__peekl(long* __b2c__x) {if(!__b2c__trap) {__b2c__memory__check((long*) __b2c__x); if(ERROR) {fprintf(stderr, \"%s\n\", ERR${g_STRINGSIGN}(ERROR)); exit(ERROR);} } return((long)*__b2c__x);}" >> $g_HFILE
echo "float __b2c__peekf(float* __b2c__x) {if(!__b2c__trap) {__b2c__memory__check((float*) __b2c__x); if(ERROR) {fprintf(stderr, \"%s\n\", ERR${g_STRINGSIGN}(ERROR)); exit(ERROR);} } return((float)*__b2c__x);}" >> $g_HFILE
echo "double __b2c__peekd(double* __b2c__x) {if(!__b2c__trap) {__b2c__memory__check((double*) __b2c__x); if(ERROR) {fprintf(stderr, \"%s\n\", ERR${g_STRINGSIGN}(ERROR)); exit(ERROR);} } return((double)*__b2c__x);}" >> $g_HFILE
echo "char __b2c__peekv(char* __b2c__x) {if(!__b2c__trap) {__b2c__memory__check((char*) __b2c__x); if(ERROR) {fprintf(stderr, \"%s\n\", ERR${g_STRINGSIGN}(ERROR)); exit(ERROR);} } return((char)*__b2c__x);}" >> $g_HFILE
echo "#define PEEK(__b2c__x) (__b2c__memtype==1 ? (unsigned char)__b2c__peek((char*)__b2c__x) : (__b2c__memtype==2 ? (unsigned short)__b2c__peeks((short*)__b2c__x) : (__b2c__memtype==3 ? (unsigned int)__b2c__peeki((int*)__b2c__x) : \\" >> $g_HFILE
echo "(__b2c__memtype==4 ? (unsigned long)__b2c__peekl((long*)__b2c__x) : ( __b2c__memtype==5 ? (float)__b2c__peekf((float*)__b2c__x) : (__b2c__memtype==6 ? (double)__b2c__peekd((double*)__b2c__x) : (unsigned char)__b2c__peekv((char*)__b2c__x) ))))))" >> $g_HFILE
echo "#define ADDRESS(__b2c__x) (long)(&__b2c__x)" >> $g_HFILE
echo >> $g_HFILE
echo "/* Network variables and functions */" >> $g_HFILE
echo "struct timeval __b2c__to; struct hostent *__b2c__he;  char *__b2c__host; char *__b2c__port; int __b2c__yes = 1; struct sockaddr_in __b2c__addr;" >> $g_HFILE
echo "int __b2c__result; char __b2c__data_client[$g_BUFFER_SIZE] = { 0 }; char __b2c__data_server[$g_BUFFER_SIZE] = { 0 }; int __b2c__handle;" >> $g_HFILE
echo "long __b2c__netpeek(int __b2c__fd, int __b2c__usec){fd_set __b2c__rfds; struct timeval __b2c__tv; long __b2c__retval; struct termios __b2c__oldt, __b2c__newt;" >> $g_HFILE
echo "if(__b2c__fd == STDIN_FILENO){tcgetattr(STDIN_FILENO, &__b2c__oldt); __b2c__newt = __b2c__oldt; __b2c__newt.c_lflag &= ~(ICANON | ECHO); __b2c__newt.c_cc[VMIN]=1; __b2c__newt.c_cc[VTIME]=0; tcsetattr(STDIN_FILENO, TCSANOW, &__b2c__newt);}" >> $g_HFILE
echo "FD_ZERO(&__b2c__rfds); FD_SET(__b2c__fd, &__b2c__rfds);__b2c__tv.tv_usec = (__b2c__usec%1000)*1000; __b2c__tv.tv_sec = __b2c__usec/1000;" >> $g_HFILE
echo "__b2c__retval = select(__b2c__fd + 1, &__b2c__rfds, NULL, NULL, &__b2c__tv); if (__b2c__retval == -1 && !__b2c__trap) {ERROR = 16; fprintf(stderr, \"%s\n\", ERR${g_STRINGSIGN}(ERROR)); exit(ERROR);}" >> $g_HFILE
echo "if(__b2c__fd == STDIN_FILENO){if(__b2c__retval) if(read(__b2c__fd, &__b2c__retval, 1)==0) __b2c__retval=0; tcsetattr(STDIN_FILENO, TCSANOW, &__b2c__oldt);} return(__b2c__retval);}" >> $g_HFILE
echo "#define WAIT(x, y) __b2c__netpeek(x, y)" >> $g_HFILE
echo "char* __b2c__nethost(char* __b2c__host) {int __b2c__y; int __b2c__flag = 0; struct in_addr __b2c__address; __b2c__sbuffer_ptr++; if(__b2c__sbuffer_ptr >= $g_MAX_BUFFERS) __b2c__sbuffer_ptr=0;" >> $g_HFILE
echo "__b2c__sbuffer[__b2c__sbuffer_ptr] = (char*)realloc(__b2c__sbuffer[__b2c__sbuffer_ptr], $g_BUFFER_SIZE); memset(__b2c__sbuffer[__b2c__sbuffer_ptr], 0, $g_BUFFER_SIZE);" >> $g_HFILE
echo "for(__b2c__y=0; __b2c__y < strlen(__b2c__host); __b2c__y++) {if(isalpha(*(__b2c__host+__b2c__y))) {__b2c__flag = 1; break;}} if(__b2c__flag) __b2c__he = gethostbyname(__b2c__host); " >> $g_HFILE
echo "else {if(inet_aton(__b2c__host, &__b2c__address)) __b2c__he = gethostbyaddr((void*)&__b2c__address, sizeof(struct in_addr), AF_INET); } if (__b2c__he == NULL || __b2c__he->h_addr == NULL || __b2c__he->h_name == NULL)" >> $g_HFILE
echo "{if(!__b2c__trap){ERROR = 11; fprintf(stderr, \"%s\n\", ERR${g_STRINGSIGN}(ERROR)); exit(ERROR); } else strncpy(__b2c__sbuffer[__b2c__sbuffer_ptr], \"Host not found\", $g_BUFFER_SIZE-1); } else {if(__b2c__flag) {__b2c__addr.sin_addr = *((struct in_addr *)__b2c__he->h_addr);" >> $g_HFILE
echo "strncpy(__b2c__sbuffer[__b2c__sbuffer_ptr], inet_ntoa(__b2c__addr.sin_addr), $g_BUFFER_SIZE-1);} else strncpy(__b2c__sbuffer[__b2c__sbuffer_ptr], __b2c__he->h_name, $g_BUFFER_SIZE-1);} return (__b2c__sbuffer[__b2c__sbuffer_ptr]);}" >> $g_HFILE
echo "#define HOST${g_STRINGSIGN}(__b2c__x) __b2c__nethost(__b2c__x)" >> $g_HFILE
echo >> $g_HFILE
echo "/* Regex */" >> $g_HFILE
echo "#include <regex.h>" >> $g_HFILE
echo "long __b2c__regex(char* __b2c__x, char* __b2c__y){regex_t __b2c__reg; int __b2c__reti; char __b2c__buf[100]; __b2c__reti = regcomp(&__b2c__reg, __b2c__y, REG_EXTENDED|REG_NOSUB);" >> $g_HFILE
echo "if(!__b2c__trap && __b2c__reti){ERROR=27; fprintf(stderr, \"%s: \", ERR${g_STRINGSIGN}(ERROR)); regerror(__b2c__reti, &__b2c__reg, __b2c__buf, sizeof(__b2c__buf)); fprintf(stderr, \"%s\n\", __b2c__buf);" >> $g_HFILE
echo "exit(ERROR);} __b2c__reti = regexec(&__b2c__reg, __b2c__x, 0, NULL, 0);" >> $g_HFILE
echo "regfree(&__b2c__reg); if( !__b2c__reti ) return (1); else return (0);}" >> $g_HFILE
echo "#define REGEX(x, y) __b2c__regex(x, y)" >> $g_HFILE
echo >> $g_HFILE
echo "/* Declare reserved variable 'ARGUMENT' */" >> $g_HFILE
echo "int __b2c__counter;" >> $g_HFILE
echo "int __b2c__arglen = 0;" >> $g_HFILE
echo "char *ARGUMENT${g_STRINGSIGN};" >> $g_HFILE
echo >> $g_HFILE
echo "/* Initialize stack arrays and pointer */" >> $g_HFILE
echo "char **__b2c__stringstack = NULL; double *__b2c__doublestack = NULL;" >> $g_HFILE
echo "long *__b2c__longstack = NULL; int *__b2c__typestack = NULL;" >> $g_HFILE
echo "int __b2c__stackptr = 0;" >> $g_HFILE
# Signal function
echo "/* Signal trapping activated with TRAP */" >> $g_HFILE
echo "void __b2c__catch_signal(int sig){" >> $g_HFILE
echo "switch (sig) {case SIGABRT: fprintf(stderr, \"ERROR: signal ABORT received - internal error. Try to compile the program with TRAP LOCAL to find the cause.\n\"); break;" >> $g_HFILE
echo "case SIGFPE: fprintf(stderr, \"ERROR: signal for FPE received - division by zero? Examine the calculations in the program.\n\"); break;" >> $g_HFILE
echo "case SIGSEGV: fprintf(stderr, \"ERROR: signal for SEGMENTATION FAULT received - memory invalid or array out of bounds? Try to compile the program with TRAP LOCAL to find the cause.\n\"); break;" >> $g_HFILE
echo "case SIGILL: fprintf(stderr, \"ERROR: signal for ILLEGAL INSTRUCTION received - executing the program on other hardware? Try to recompile the program from scratch.\n\"); break;} exit(sig);}" >> $g_HFILE
# Makedir function
echo "int __b2c__makedir(char* __b2c__in){char *__b2c__i, *__b2c__dir; if(__b2c__in == NULL || strlen(__b2c__in)==0) return 0; if(*__b2c__in != '/'){__b2c__dir = (char*)malloc((strlen(__b2c__in)+2)*sizeof(char));" >> $g_HFILE
echo "strncpy(__b2c__dir, \"./\", 2); __b2c__dir = strcat(__b2c__dir, __b2c__in);} else __b2c__dir = strdup(__b2c__in); __b2c__i = __b2c__dir; do { __b2c__i++; while(*__b2c__i != '/' && *__b2c__i != '\0') __b2c__i++;" >> $g_HFILE
echo "if(*__b2c__i == '/') {*__b2c__i = '\0'; mkdir(__b2c__dir, S_IRWXU|S_IRGRP|S_IXGRP|S_IROTH|S_IXOTH); *__b2c__i = '/';} else if (*__b2c__i == '\0') mkdir(__b2c__dir, S_IRWXU|S_IRGRP|S_IXGRP|S_IROTH|S_IXOTH);" >> $g_HFILE
echo "if(errno != EEXIST && errno != 0) {free(__b2c__dir); return errno;} } while (*__b2c__i != '\0'); free(__b2c__dir); return 0;}" >> $g_HFILE
# Add error function
echo >> $g_HFILE
echo "/* Initialize error function */" >> $g_HFILE
echo "char *ERR${g_STRINGSIGN}(int __b2c__nr){static char __b2c__warn[$g_BUFFER_SIZE] = { 0 }; const char* __b2c__err;" >> $g_HFILE
echo "switch(__b2c__nr){" >> $g_HFILE
echo "case 0: strcpy(__b2c__warn,\"Success\"); break;" >> $g_HFILE
echo "case 1: strcpy(__b2c__warn,\"Trying to access illegal memory: \"); strncat(__b2c__warn,strerror(errno),$g_BUFFER_SIZE-48); break;" >> $g_HFILE
echo "case 2: strcpy(__b2c__warn,\"Error opening file: \"); strncat(__b2c__warn,strerror(errno),$g_BUFFER_SIZE-48); break;" >> $g_HFILE
echo "case 3: strcpy(__b2c__warn, \"Could not open library \"); __b2c__err = dlerror(); if(__b2c__err!=NULL) strncat(__b2c__warn, __b2c__err, $g_BUFFER_SIZE-48); break;" >> $g_HFILE
echo "case 4: strcpy(__b2c__warn, \"Symbol not found in library \"); __b2c__err = dlerror(); if(__b2c__err!=NULL) strncat(__b2c__warn, __b2c__err, $g_BUFFER_SIZE-48); break;" >> $g_HFILE
echo "case 5: strcpy(__b2c__warn, \"Wrong hexvalue: \"); strncat(__b2c__warn, strerror(errno), $g_BUFFER_SIZE-48); break;" >> $g_HFILE
echo "case 6: strcpy(__b2c__warn, \"Unable to claim memory.\"); break;" >> $g_HFILE
echo "case 7: strcpy(__b2c__warn, \"Unable to delete file: \"); strncat(__b2c__warn, strerror(errno),$g_BUFFER_SIZE-48); break;" >> $g_HFILE
echo "case 8: strcpy(__b2c__warn, \"Could not open directory: \"); strncat(__b2c__warn, strerror(errno),$g_BUFFER_SIZE-48); break;" >> $g_HFILE
echo "case 9: strcpy(__b2c__warn, \"Unable to rename file: \"); strncat(__b2c__warn, strerror(errno),$g_BUFFER_SIZE-48); break;" >> $g_HFILE
echo "case 10: strcpy(__b2c__warn, \"NETWORK argument should contain colon with port number\"); break;" >> $g_HFILE
echo "case 11: strcpy(__b2c__warn, \"Could not resolve hostname!\"); break;" >> $g_HFILE
echo "case 12: strcpy(__b2c__warn, \"Socket error: \"); strncat(__b2c__warn, strerror(errno),$g_BUFFER_SIZE-48); break;" >> $g_HFILE
echo "case 13: strcpy(__b2c__warn, \"Unable to open address: \"); strncat(__b2c__warn, strerror(errno),$g_BUFFER_SIZE-48); break;" >> $g_HFILE
echo "case 14: strcpy(__b2c__warn, \"Error reading from socket: \"); strncat(__b2c__warn, strerror(errno),$g_BUFFER_SIZE-48); break;" >> $g_HFILE
echo "case 15: strcpy(__b2c__warn, \"Error sending to socket: \"); strncat(__b2c__warn, strerror(errno),$g_BUFFER_SIZE-48); break;" >> $g_HFILE
echo "case 16: strcpy(__b2c__warn, \"Error checking socket: \"); strncat(__b2c__warn, strerror(errno),$g_BUFFER_SIZE-48); break;" >> $g_HFILE
echo "case 17: strcpy(__b2c__warn, \"Unable to bind the specified socket address: \"); strncat(__b2c__warn, strerror(errno),$g_BUFFER_SIZE-48); break;" >> $g_HFILE
echo "case 18: strcpy(__b2c__warn, \"Unable to listen to socket address: \"); strncat(__b2c__warn, strerror(errno),$g_BUFFER_SIZE-48); break;" >> $g_HFILE
echo "case 19: strcpy(__b2c__warn, \"Cannot accept incoming connection: \"); strncat(__b2c__warn, strerror(errno),$g_BUFFER_SIZE-48); break;" >> $g_HFILE
echo "case 20: strcpy(__b2c__warn, \"Unable to remove directory: \"); strncat(__b2c__warn, strerror(errno),$g_BUFFER_SIZE-48); break;" >> $g_HFILE
echo "case 21: strcpy(__b2c__warn, \"Unable to create directory: \"); strncat(__b2c__warn, strerror(errno),$g_BUFFER_SIZE-48); break;" >> $g_HFILE
echo "case 22: strcpy(__b2c__warn, \"Unable to change to directory: \"); strncat(__b2c__warn, strerror(errno),$g_BUFFER_SIZE-48); break;" >> $g_HFILE
echo "case 23: strcpy(__b2c__warn, \"GETENVIRON argument does not exist as environment variable\"); break;" >> $g_HFILE
echo "case 24: strcpy(__b2c__warn, \"Unable to stat file: \"); strncat(__b2c__warn, strerror(errno),$g_BUFFER_SIZE-48); break;" >> $g_HFILE
echo "case 25: strcpy(__b2c__warn, \"Search contains illegal string\"); break;" >> $g_HFILE
echo "case 26: strcpy(__b2c__warn, \"Cannot return OS name: \"); strncat(__b2c__warn, strerror(errno),$g_BUFFER_SIZE-48); break;" >> $g_HFILE
echo "case 27: strcpy(__b2c__warn, \"Illegal regex expression\"); break;" >> $g_HFILE
echo "case 28: strcpy(__b2c__warn, \"Unable to create bidirectional pipes: \"); strncat(__b2c__warn, strerror(errno),$g_BUFFER_SIZE-48); break;" >> $g_HFILE
echo "case 29: strcpy(__b2c__warn, \"Unable to fork process: \"); strncat(__b2c__warn, strerror(errno),$g_BUFFER_SIZE-48); break;" >> $g_HFILE
echo "case 30: strcpy(__b2c__warn, \"Cannot read from pipe: \"); strncat(__b2c__warn, strerror(errno),$g_BUFFER_SIZE-48); break;" >> $g_HFILE
echo "}; ERROR = 0; return(__b2c__warn);}" >> $g_HFILE
echo >> $g_HFILE
echo "/* User program definitions */" >> $g_HFILE

# Initialize the arrayfiles for DATA statement
echo "char *__b2c__stringarray[] = {" > $STRINGARRAYFILE
echo "double __b2c__floatarray[] = {" > $FLOATARRAYFILE

# There are no imported symbols yet
g_IMPORTED=

# Check if the C Preprocessor needs to run
if [[ $g_CPP -eq 1 ]]
then
    if [[ -n `which cpp 2>/dev/null` ]]
    then
	cpp -P -w $g_SOURCEFILE $g_SOURCEFILE.cpp
	FEED="${g_SOURCEFILE}.cpp"
	g_TMP_FILES="$g_TMP_FILES ${g_SOURCEFILE}.cpp"
    else
	echo -e "ERROR: the C Preprocessor 'cpp' not found on this system! Exiting..."
	exit 1
    fi
else
    FEED=${g_SOURCEFILE}
fi
g_CURFILE=${g_SOURCEFILE##*/}

# Initialize
LEN=
TOTAL=
SEQ=
g_COUNTER=1

# Start walking through program
while read -r LINE
do
    echo -e -n "\rStarting conversion... $g_COUNTER   "

    # Line is not empty?
    if [[ -n "$LINE" ]]
    then
	if [[ "$LINE" = +(* \\) && "$LINE" != +(REM*) && "$LINE" != +(${g_SQUOTESIGN}*) ]]
	then
	    let LEN="${#LINE}"-2
	    SEQ="${LINE:0:$LEN}"
	    TOTAL=$TOTAL$SEQ
	else
	    echo "/* noparse $FEED BACON LINE $g_COUNTER */" >> $g_CFILE
	    echo "/* noparse $FEED BACON LINE $g_COUNTER */" >> $g_HFILE
	    TOTAL="${TOTAL}${LINE}"
	    if [[ "${TOTAL}" != +(REM*) && "${TOTAL}" != +(${g_SQUOTESIGN}*) ]]
	    then
		Tokenize "${TOTAL}"
	    fi
	    TOTAL=
	fi
    fi
    ((g_COUNTER+=1))
done < $FEED

# Check if enclosed IF/ELIF/ELSE needs to be closed
if [[ $g_IF_PARSE -eq 1 ]]
then
    echo "}" >> $g_CFILE
fi

# Finalize main C-file
echo "__B2C__PROGRAM__EXIT:" >> $g_CFILE
echo "return 0;" >> $g_CFILE
echo "}" >> $g_CFILE

# Finalize STRING ARRAY file for DATA
echo " \"\" };" >> $STRINGARRAYFILE

# Finalize FLOAT ARRAY file for DATA
echo " 0.0};" >> $FLOATARRAYFILE

# Include functions and subs
for i in $g_INCLUDE_FILES
do
    echo "#include \"${i}\"" >> $g_HFILE
done

echo -e "\rStarting conversion... done.  "

# Indentation only when files are preserved
if [[ $g_TMP_PRESERVE -eq 1 ]]
then
    if [[ -n `which indent 2>/dev/null` ]]
    then
	echo -n "Applying indentation... "
	for i in $g_TMP_FILES
	do
	    if [[ $i != +(*.cpp) ]]
	    then
		if [[ `uname` = "Darwin" || `uname` = +(*BSD*) ]]
		then
		    mv ${i} "${i}.BAK"
		    indent "${i}.BAK" ${i}
		    rm "${i}.BAK"
		else
		    indent $i
		    rm $i~
		fi
	    fi
	done
	echo "done."
    else
	echo "WARNING: 'indent' not found on this system!"
	echo "Generated source code cannot be beautified."
    fi
fi

# Check if we need to run xgettext
if [[ ${g_XGETTEXT} -eq 1 ]]
then
    if [[ -n `which xgettext 2>/dev/null` ]]
    then
	echo -n "Executing xgettext... "
	xgettext -d ${g_SOURCEFILE%.*} -s -o ${g_SOURCEFILE%.*}.pot $g_TMP_FILES
	if [[ ! -f "${g_SOURCEFILE%.*}.pot" ]]
	then
	    echo "WARNING: catalog file not created!"
	else
	    echo "done."
	fi
    else
	echo "WARNING: 'xgettext' not found on this system!"
    fi
fi

# Start compilation
if [[ $g_NO_COMPILE -eq 0 ]]
then
    if [[ -z `which $g_CCNAME 2>/dev/null` ]]
    then
	echo "WARNING: '$g_CCNAME' not found on this system!"
	echo "Generated source code cannot be compiled."
	exit 0
    fi
    echo -n "Starting compilation... "

    # Make sure GCC uses English localization
    export LANG="C"

    $g_CCNAME $g_CCFLAGS -o ${g_SOURCEFILE%.*}$g_BINEXT $g_CFILE $g_LDFLAGS > $g_TEMPDIR/${g_SOURCEFILE##*/}.log 2>&1

    g_TMP_FILES="$g_TMP_FILES $g_TEMPDIR/${g_SOURCEFILE##*/}.log"

    if [[ -z `cat $g_TEMPDIR/${g_SOURCEFILE##*/}.log` ]]
    then
	echo "done."
	echo "Program '${g_SOURCEFILE%.*}$g_BINEXT' ready."
    else
	# Only print first error
	echo -e "Compiler emits messages!"
	while read -r g_ERROR
	do
	    if [[ ( ${g_ERROR} != +(*from *) || ${g_ERROR} = +(*error:*from*) ) && ${g_ERROR} = +(*[0-9]*) && ${g_ERROR} = +(*: error:*) ]]
	    then
		g_ERRORTXT="Cause:\n\t${g_ERROR##*error:}"
		g_FILE_LINE=${g_ERROR%%error:*}
		break
	    elif [[ ( ${g_ERROR} != +(*from *) || ${g_ERROR} = +(*Error:*from*) ) && ${g_ERROR} = +(*[0-9]*) && ${g_ERROR} = +(*: Error:*) ]]
	    then
		g_ERRORTXT="Cause:\n\t${g_ERROR##*:}"
		g_FILE_LINE=${g_ERROR##*Error: }
		break
	    elif [[ ( ${g_ERROR} != +(*from *) || ${g_ERROR} = +(*warning:*from*) ) && ${g_ERROR} = +(*[0-9]*) && ${g_ERROR} = +(*: warning:*) ]]
	    then
		g_ERRORTXT="Cause:\n\t${g_ERROR##*warning:}"
		g_FILE_LINE=${g_ERROR%%warning:*}
		break
	    elif [[ ( ${g_ERROR} != +(*from *) || ${g_ERROR} = +(*:*from*) ) && ${g_ERROR} = +(*[0-9]:*) ]]
	    then
		g_ERRORTXT="Cause:\n\t${g_ERROR##*:}"
		g_FILE_LINE=${g_ERROR%:*}
		break
	    fi
	done < $g_TEMPDIR/${g_SOURCEFILE##*/}.log

	# Restore $-symbol if there is any
	if [[ $g_ERRORTXT = +(*${g_STRINGSIGN}*) ]]
	then
	    LEN=${#g_STRINGSIGN}
	    POS=0
	    until [[ $POS -eq ${#g_ERRORTXT} ]]
	    do
		SUBSTR="${g_ERRORTXT:${POS}:${LEN}}"
		if [[ $SUBSTR = $g_STRINGSIGN ]]
		then
		    SUBSTR="${g_ERRORTXT:0:${POS}}$"
		    ((POS+=${LEN}))
		    g_ERRORTXT="${SUBSTR}${g_ERRORTXT:${POS}:${#g_ERRORTXT}}"
		    break
		fi
		((POS+=1))
	    done		
	fi

	# Get the file where the error is
	g_FILE=${g_FILE_LINE%%:*}
	# Tru64Unix helper
	g_FILE=${g_FILE%%,*}

	# Non-gcc or parse problem (file does not exist)
	if [[ -z $g_ERROR || $g_CCFLAGS = +(*Wall*) || ! -f $g_FILE ]]
	then
	    echo
	    cat $g_TEMPDIR/${g_SOURCEFILE##*/}.log
	    echo
	else
	    # Get the erroneous line
	    if [[ ${g_FILE_LINE} = +(*line*) ]]
	    then
		g_LINE=${g_FILE_LINE#*line}
	    else
		g_LINE=${g_FILE_LINE#*:}
	    fi
	    # Initiate error file name and error line in C code
	    g_FEED=${g_FILE_LINE%%:*}
	    g_CURLINE=${g_LINE%%:*}
	    # Remove everything behind last colon
	    g_LINE=${g_LINE%%:*}
	    g_COUNTER=1
	    while read -r LINE
	    do
		if [[ $LINE = +(*BACON LINE*) && $LINE = +(*noparse*) ]]
		then
		    g_CURLINE=${LINE##*BACON LINE }
		    g_FEED=${LINE##*noparse }
		    g_FEED=${g_FEED%% BACON LINE*}
		fi
		if [[ ${g_COUNTER} -eq ${g_LINE} ]]
		then
		    COUNTER=1
		    while read -r LINE
		    do
			if [[ $COUNTER -eq ${g_CURLINE%% *} ]]
			then
			    echo -e "\nProblem:\n\t file '$g_FEED' line $COUNTER: ${LINE}"
			    echo -e "$g_ERRORTXT\n"
			    break
			fi
			((COUNTER+=1))
		    done < $g_FEED
		    break
		fi
		((g_COUNTER+=1))
	    done < ${g_FILE}
	fi
	# Preserve temp files
	g_TMP_PRESERVE=1
    fi
fi

# Cleanup
if [[ $g_TMP_PRESERVE -eq 0 ]]
then
    for i in $g_TMP_FILES
    do
	rm $i
    done
elif [[ $g_CPP -eq 1 ]]
then
    mv ${g_SOURCEFILE}.cpp $g_TEMPDIR/${g_SOURCEFILE##*/}.cpp
fi

exit 0
