# Avoid multiple calls to find_package to append duplicated properties to the targets
include_guard()########### VARIABLES #######################################################################
#############################################################################################
set(lz4_FRAMEWORKS_FOUND_RELEASE "") # Will be filled later
conan_find_apple_frameworks(lz4_FRAMEWORKS_FOUND_RELEASE "${lz4_FRAMEWORKS_RELEASE}" "${lz4_FRAMEWORK_DIRS_RELEASE}")

set(lz4_LIBRARIES_TARGETS "") # Will be filled later


######## Create an interface target to contain all the dependencies (frameworks, system and conan deps)
if(NOT TARGET lz4_DEPS_TARGET)
    add_library(lz4_DEPS_TARGET INTERFACE IMPORTED)
endif()

set_property(TARGET lz4_DEPS_TARGET
             APPEND PROPERTY INTERFACE_LINK_LIBRARIES
             $<$<CONFIG:Release>:${lz4_FRAMEWORKS_FOUND_RELEASE}>
             $<$<CONFIG:Release>:${lz4_SYSTEM_LIBS_RELEASE}>
             $<$<CONFIG:Release>:>)

####### Find the libraries declared in cpp_info.libs, create an IMPORTED target for each one and link the
####### lz4_DEPS_TARGET to all of them
conan_package_library_targets("${lz4_LIBS_RELEASE}"    # libraries
                              "${lz4_LIB_DIRS_RELEASE}" # package_libdir
                              "${lz4_BIN_DIRS_RELEASE}" # package_bindir
                              "${lz4_LIBRARY_TYPE_RELEASE}"
                              "${lz4_IS_HOST_WINDOWS_RELEASE}"
                              lz4_DEPS_TARGET
                              lz4_LIBRARIES_TARGETS  # out_libraries_targets
                              "_RELEASE"
                              "lz4"    # package_name
                              "${lz4_NO_SONAME_MODE_RELEASE}")  # soname

# FIXME: What is the result of this for multi-config? All configs adding themselves to path?
set(CMAKE_MODULE_PATH ${lz4_BUILD_DIRS_RELEASE} ${CMAKE_MODULE_PATH})

########## GLOBAL TARGET PROPERTIES Release ########################################
    set_property(TARGET LZ4::lz4_static
                 APPEND PROPERTY INTERFACE_LINK_LIBRARIES
                 $<$<CONFIG:Release>:${lz4_OBJECTS_RELEASE}>
                 $<$<CONFIG:Release>:${lz4_LIBRARIES_TARGETS}>
                 )

    if("${lz4_LIBS_RELEASE}" STREQUAL "")
        # If the package is not declaring any "cpp_info.libs" the package deps, system libs,
        # frameworks etc are not linked to the imported targets and we need to do it to the
        # global target
        set_property(TARGET LZ4::lz4_static
                     APPEND PROPERTY INTERFACE_LINK_LIBRARIES
                     lz4_DEPS_TARGET)
    endif()

    set_property(TARGET LZ4::lz4_static
                 APPEND PROPERTY INTERFACE_LINK_OPTIONS
                 $<$<CONFIG:Release>:${lz4_LINKER_FLAGS_RELEASE}>)
    set_property(TARGET LZ4::lz4_static
                 APPEND PROPERTY INTERFACE_INCLUDE_DIRECTORIES
                 $<$<CONFIG:Release>:${lz4_INCLUDE_DIRS_RELEASE}>)
    # Necessary to find LINK shared libraries in Linux
    set_property(TARGET LZ4::lz4_static
                 APPEND PROPERTY INTERFACE_LINK_DIRECTORIES
                 $<$<CONFIG:Release>:${lz4_LIB_DIRS_RELEASE}>)
    set_property(TARGET LZ4::lz4_static
                 APPEND PROPERTY INTERFACE_COMPILE_DEFINITIONS
                 $<$<CONFIG:Release>:${lz4_COMPILE_DEFINITIONS_RELEASE}>)
    set_property(TARGET LZ4::lz4_static
                 APPEND PROPERTY INTERFACE_COMPILE_OPTIONS
                 $<$<CONFIG:Release>:${lz4_COMPILE_OPTIONS_RELEASE}>)

########## For the modules (FindXXX)
set(lz4_LIBRARIES_RELEASE LZ4::lz4_static)
