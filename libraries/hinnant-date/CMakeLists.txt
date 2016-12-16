cmake_minimum_required(VERSION 3.2)

project(date)
set(LIBRARY_SHARED_OR_STATIC STATIC)

set(header_files
    date.h
    tz.h tz_private.h
    chrono_io.h
    iso_week.h
    julian.h
    islamic.h)

set(source_files
    tz.cpp)

add_library(${PROJECT_NAME} ${LIBRARY_SHARED_OR_STATIC} ${header_files} ${souce_files})
set_target_properties(${PROJECT_NAME} PROPERTIES LINKER_LANGUAGE CXX)

install(TARGETS ${PROJECT_NAME} DESTINATION lib${LIB_SUFFIX})
install(FILES ${header_files} DESTINATION include)

configure_file("libdate.pc.in" "libdate.pc" @ONLY)
install(FILES       "${CMAKE_CURRENT_BINARY_DIR}/libdate.pc"
        DESTINATION "${CMAKE_INSTALL_PREFIX}/lib${LIB_SUFFIX}/pkgconfig")
