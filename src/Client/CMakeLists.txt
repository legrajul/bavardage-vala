file(
    GLOB_RECURSE
    client_source_files
    *.vala
)

vala_precompile(VALA_C
    ${client_source_files}
    ${services_source_files}
PACKAGES
    gtk+-3.0
    libarchive
    granite
    gee-1.0
    gio-2.0
    sqlheavy-0.1
    gdk-3.0
OPTIONS
    --thread
    --target-glib=2.32
)

find_package(PkgConfig)
pkg_check_modules(DEPS REQUIRED gtk+-3.0 granite libarchive gee-1.0 gio-2.0 sqlheavy-0.1 gdk-3.0)
set(CFLAGS
    ${DEPS_CFLAGS} ${DEPS_CFLAGS_OTHER}
)
set(LIB_PATHS
    ${DEPS_LIBRARY_DIRS}
)
link_directories(${LIB_PATHS})
add_definitions(${CFLAGS})

add_executable(bavardage-client ${VALA_C})

target_link_libraries(bavardage-client ${DEPS_LIBRARIES})

install(TARGETS bavardage-client RUNTIME DESTINATION bin)
