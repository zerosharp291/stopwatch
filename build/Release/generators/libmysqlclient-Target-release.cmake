# Avoid multiple calls to find_package to append duplicated properties to the targets
include_guard()########### VARIABLES #######################################################################
#############################################################################################
set(libmysqlclient_FRAMEWORKS_FOUND_RELEASE "") # Will be filled later
conan_find_apple_frameworks(libmysqlclient_FRAMEWORKS_FOUND_RELEASE "${libmysqlclient_FRAMEWORKS_RELEASE}" "${libmysqlclient_FRAMEWORK_DIRS_RELEASE}")

set(libmysqlclient_LIBRARIES_TARGETS "") # Will be filled later


######## Create an interface target to contain all the dependencies (frameworks, system and conan deps)
if(NOT TARGET libmysqlclient_DEPS_TARGET)
    add_library(libmysqlclient_DEPS_TARGET INTERFACE IMPORTED)
endif()

set_property(TARGET libmysqlclient_DEPS_TARGET
             APPEND PROPERTY INTERFACE_LINK_LIBRARIES
             $<$<CONFIG:Release>:${libmysqlclient_FRAMEWORKS_FOUND_RELEASE}>
             $<$<CONFIG:Release>:${libmysqlclient_SYSTEM_LIBS_RELEASE}>
             $<$<CONFIG:Release>:openssl::openssl;ZLIB::ZLIB;zstd::libzstd_static;LZ4::lz4_static>)

####### Find the libraries declared in cpp_info.libs, create an IMPORTED target for each one and link the
####### libmysqlclient_DEPS_TARGET to all of them
conan_package_library_targets("${libmysqlclient_LIBS_RELEASE}"    # libraries
                              "${libmysqlclient_LIB_DIRS_RELEASE}" # package_libdir
                              "${libmysqlclient_BIN_DIRS_RELEASE}" # package_bindir
                              "${libmysqlclient_LIBRARY_TYPE_RELEASE}"
                              "${libmysqlclient_IS_HOST_WINDOWS_RELEASE}"
                              libmysqlclient_DEPS_TARGET
                              libmysqlclient_LIBRARIES_TARGETS  # out_libraries_targets
                              "_RELEASE"
                              "libmysqlclient"    # package_name
                              "${libmysqlclient_NO_SONAME_MODE_RELEASE}")  # soname

# FIXME: What is the result of this for multi-config? All configs adding themselves to path?
set(CMAKE_MODULE_PATH ${libmysqlclient_BUILD_DIRS_RELEASE} ${CMAKE_MODULE_PATH})

########## GLOBAL TARGET PROPERTIES Release ########################################
    set_property(TARGET libmysqlclient::libmysqlclient
                 APPEND PROPERTY INTERFACE_LINK_LIBRARIES
                 $<$<CONFIG:Release>:${libmysqlclient_OBJECTS_RELEASE}>
                 $<$<CONFIG:Release>:${libmysqlclient_LIBRARIES_TARGETS}>
                 )

    if("${libmysqlclient_LIBS_RELEASE}" STREQUAL "")
        # If the package is not declaring any "cpp_info.libs" the package deps, system libs,
        # frameworks etc are not linked to the imported targets and we need to do it to the
        # global target
        set_property(TARGET libmysqlclient::libmysqlclient
                     APPEND PROPERTY INTERFACE_LINK_LIBRARIES
                     libmysqlclient_DEPS_TARGET)
    endif()

    set_property(TARGET libmysqlclient::libmysqlclient
                 APPEND PROPERTY INTERFACE_LINK_OPTIONS
                 $<$<CONFIG:Release>:${libmysqlclient_LINKER_FLAGS_RELEASE}>)
    set_property(TARGET libmysqlclient::libmysqlclient
                 APPEND PROPERTY INTERFACE_INCLUDE_DIRECTORIES
                 $<$<CONFIG:Release>:${libmysqlclient_INCLUDE_DIRS_RELEASE}>)
    # Necessary to find LINK shared libraries in Linux
    set_property(TARGET libmysqlclient::libmysqlclient
                 APPEND PROPERTY INTERFACE_LINK_DIRECTORIES
                 $<$<CONFIG:Release>:${libmysqlclient_LIB_DIRS_RELEASE}>)
    set_property(TARGET libmysqlclient::libmysqlclient
                 APPEND PROPERTY INTERFACE_COMPILE_DEFINITIONS
                 $<$<CONFIG:Release>:${libmysqlclient_COMPILE_DEFINITIONS_RELEASE}>)
    set_property(TARGET libmysqlclient::libmysqlclient
                 APPEND PROPERTY INTERFACE_COMPILE_OPTIONS
                 $<$<CONFIG:Release>:${libmysqlclient_COMPILE_OPTIONS_RELEASE}>)

########## For the modules (FindXXX)
set(libmysqlclient_LIBRARIES_RELEASE libmysqlclient::libmysqlclient)
