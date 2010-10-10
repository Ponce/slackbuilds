cmake_minimum_required(VERSION 2.6)

PROJECT(subtitleripper)

SET(CMAKE_C_FLAGS $ENV{CFLAGS})

SET ( PNG 
	"ON"
	CACHE BOOL "Enable PNG support")
SET ( PPM
	"ON"
	CACHE BOOL "Enable PPM support")
SET ( ZLIB
	"ON"
	CACHE BOOL "Enable ZLIB support")

SET(BIN_INSTALL_DIR bin)
SET(DATA_INSTALL_DIR share)

SET(subtitle2pgm_sources subtitle2pgm.c spudec.c)
SET(subtitle2vobsub_sources subtitle2vobsub.c vobsub.c)
SET(srttool_sources srttool.c)
SET(vobsub2pgm_sources vobsub2pgm.c vobsub.c spudec.c)


# LIBRARIES (MATH LIBPPM-NETPBM LIBPNG LIBZ)
LINK_LIBRARIES(m)

IF ( ${PPM} STREQUAL "ON" )
	ADD_DEFINITIONS( -D_HAVE_LIB_PPM_ )
	LINK_LIBRARIES(netpbm)
	INCLUDE_DIRECTORIES( /usr/include/netpbm )
ENDIF ( ${PPM} STREQUAL "ON" )

IF ( ${PNG} STREQUAL "ON" )
	ADD_DEFINITIONS( -D_HAVE_PNG_ -DPNG_SKIP_SETJMP_CHECK )
	LINK_LIBRARIES(png)
ENDIF ( ${PNG} STREQUAL "ON" )

IF ( ${ZLIB} STREQUAL "ON" )
	ADD_DEFINITIONS( -D_HAVE_ZLIB_ )
	LINK_LIBRARIES(z)
ENDIF ( ${ZLIB} STREQUAL "ON" )

ADD_EXECUTABLE(subtitle2pgm ${subtitle2pgm_sources})
ADD_EXECUTABLE(subtitle2vobsub ${subtitle2vobsub_sources})
ADD_EXECUTABLE(srttool ${srttool_sources})
ADD_EXECUTABLE(vobsub2pgm ${vobsub2pgm_sources})

ADD_DEFINITIONS( -DHAVE_GETLINE )

EXECUTE_PROCESS(
	INPUT_FILE pgm2txt
	OUTPUT_FILE pgm2txt.new
	COMMAND sed s|^PATH_TO_LANGUAGE_FILTER.*|PATH_TO_LANGUAGE_FILTER=@CMAKE_INSTALL_PREFIX@/@DATA_INSTALL_DIR@/subtitleripper/|
)

EXECUTE_PROCESS(
	COMMAND mv pgm2txt.new pgm2txt
)

INSTALL(FILES "gocrfilter_en.sed" "gocrfilter_fr.sed" "gocrfilter_nl.sed" "gocrfilter_none.sed" DESTINATION ${DATA_INSTALL_DIR}/subtitleripper )
INSTALL(PROGRAMS "pgm2txt" DESTINATION ${BIN_INSTALL_DIR})
INSTALL(TARGETS subtitle2pgm DESTINATION ${BIN_INSTALL_DIR})
INSTALL(TARGETS subtitle2vobsub DESTINATION ${BIN_INSTALL_DIR})
INSTALL(TARGETS srttool DESTINATION ${BIN_INSTALL_DIR})
INSTALL(TARGETS vobsub2pgm DESTINATION ${BIN_INSTALL_DIR})
