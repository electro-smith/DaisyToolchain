#----------------------------------------------------------------
# Generated CMake target import file for configuration "Release".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "hidapi::darwin" for configuration "Release"
set_property(TARGET hidapi::darwin APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(hidapi::darwin PROPERTIES
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib/libhidapi.0.11.2.dylib"
  IMPORTED_SONAME_RELEASE "@rpath/libhidapi.0.dylib"
  )

list(APPEND _IMPORT_CHECK_TARGETS hidapi::darwin )
list(APPEND _IMPORT_CHECK_FILES_FOR_hidapi::darwin "${_IMPORT_PREFIX}/lib/libhidapi.0.11.2.dylib" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
