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

add_subdirectory ("Server")
add_subdirectory ("Client")
