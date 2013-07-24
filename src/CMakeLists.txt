# Vala stuff

find_package(Vala REQUIRED)
include(ValaVersion)
ensure_vala_version("0.18.0" MINIMUM)
include(ValaPrecompile)

file(
    GLOB_RECURSE
    services_source_files
    Services/*.vala
)

# Precompile the Server files
file(
    GLOB_RECURSE
    server_source_files
    Server/*.vala
)

vala_precompile(VALA_C
    ${services_source_files}
    ${server_source_files}
PACKAGES
    gee-1.0
    gio-2.0
    sqlheavy-0.1
OPTIONS
    --thread
    --target-glib=2.32
)

find_package(PkgConfig)
pkg_check_modules(DEPS REQUIRED gee-1.0 gio-2.0 sqlheavy-0.1)
set(CFLAGS
    ${DEPS_CFLAGS} ${DEPS_CFLAGS_OTHER}
)
set(LIB_PATHS
    ${DEPS_LIBRARY_DIRS}
)
link_directories(${LIB_PATHS})
add_definitions(${CFLAGS})

add_executable(bavardage-server ${VALA_C})

target_link_libraries(bavardage-server ${DEPS_LIBRARIES})

install(TARGETS bavardage-server RUNTIME DESTINATION bin)


#~ # Precompile the Client files
#~ file(
    #~ GLOB_RECURSE
    #~ server_source_files
    #~ Client/*.vala
#~ )
#~ 
#~ vala_precompile(VALA_C 
    #~ ${client_source_files}
#~ PACKAGES
    #~ gtk+-3.0
    #~ libarchive
    #~ granite
    #~ gee-1.0
    #~ gio-2.0
    #~ sqlheavy-0.1
    #~ gdk-3.0
#~ OPTIONS
    #~ --thread)
#~ 
#~ find_package(PkgConfig)
#~ pkg_check_modules(DEPS REQUIRED gtk+-3.0 granite libarchive gee-1.0 gio-2.0 sqlheavy-0.1 gdk-3.0)
#~ set(CFLAGS
    #~ ${DEPS_CFLAGS} ${DEPS_CFLAGS_OTHER}
#~ )
#~ set(LIB_PATHS
    #~ ${DEPS_LIBRARY_DIRS}
#~ )
#~ link_directories(${LIB_PATHS})
#~ add_definitions(${CFLAGS})
#~ 
#~ add_executable(bavardage-server ${VALA_C})
#~ 
#~ target_link_libraries(bavardage-server ${DEPS_LIBRARIES})
#~ 
#~ install(TARGETS bavardage-server RUNTIME DESTINATION bin)
