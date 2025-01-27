########### AGGREGATED COMPONENTS AND DEPENDENCIES FOR THE MULTI CONFIG #####################
#############################################################################################

set(lz4_COMPONENT_NAMES "")
if(DEFINED lz4_FIND_DEPENDENCY_NAMES)
  list(APPEND lz4_FIND_DEPENDENCY_NAMES )
  list(REMOVE_DUPLICATES lz4_FIND_DEPENDENCY_NAMES)
else()
  set(lz4_FIND_DEPENDENCY_NAMES )
endif()

########### VARIABLES #######################################################################
#############################################################################################
set(lz4_PACKAGE_FOLDER_RELEASE "/home/zerosharp/.conan2/p/b/lz46126c94e98e4b/p")
set(lz4_BUILD_MODULES_PATHS_RELEASE )


set(lz4_INCLUDE_DIRS_RELEASE )
set(lz4_RES_DIRS_RELEASE )
set(lz4_DEFINITIONS_RELEASE )
set(lz4_SHARED_LINK_FLAGS_RELEASE )
set(lz4_EXE_LINK_FLAGS_RELEASE )
set(lz4_OBJECTS_RELEASE )
set(lz4_COMPILE_DEFINITIONS_RELEASE )
set(lz4_COMPILE_OPTIONS_C_RELEASE )
set(lz4_COMPILE_OPTIONS_CXX_RELEASE )
set(lz4_LIB_DIRS_RELEASE "${lz4_PACKAGE_FOLDER_RELEASE}/lib")
set(lz4_BIN_DIRS_RELEASE )
set(lz4_LIBRARY_TYPE_RELEASE STATIC)
set(lz4_IS_HOST_WINDOWS_RELEASE 0)
set(lz4_LIBS_RELEASE lz4)
set(lz4_SYSTEM_LIBS_RELEASE )
set(lz4_FRAMEWORK_DIRS_RELEASE )
set(lz4_FRAMEWORKS_RELEASE )
set(lz4_BUILD_DIRS_RELEASE )
set(lz4_NO_SONAME_MODE_RELEASE FALSE)


# COMPOUND VARIABLES
set(lz4_COMPILE_OPTIONS_RELEASE
    "$<$<COMPILE_LANGUAGE:CXX>:${lz4_COMPILE_OPTIONS_CXX_RELEASE}>"
    "$<$<COMPILE_LANGUAGE:C>:${lz4_COMPILE_OPTIONS_C_RELEASE}>")
set(lz4_LINKER_FLAGS_RELEASE
    "$<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${lz4_SHARED_LINK_FLAGS_RELEASE}>"
    "$<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${lz4_SHARED_LINK_FLAGS_RELEASE}>"
    "$<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${lz4_EXE_LINK_FLAGS_RELEASE}>")


set(lz4_COMPONENTS_RELEASE )