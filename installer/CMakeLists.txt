project(DaisyToolchain)

add_executable(DaisyToolchain hello_world.c)

cmake_minimum_required(VERSION 3.20)

# include(InstallRequiredSystemLibraries)

set(CPACK_PACKAGE_DESCRIPTION_SUMMARY "Daisy Toolchain")
set(CPACK_PACKAGE_VENDOR "Electro-Smith")
# set(CPACK_PACKAGE_DESCRIPTION_FILE "${CMAKE_CURRENT_SOURCE_DIR}/ReadMe.txt")
# set(CPACK_RESOURCE_FILE_LICENSE "${CMAKE_CURRENT_SOURCE_DIR}/Copyright.txt")
set(CPACK_PACKAGE_VERSION_MAJOR "0")
set(CPACK_PACKAGE_VERSION_MINOR "3")
set(CPACK_PACKAGE_VERSION_PATCH "1")
set(CPACK_PACKAGE_INSTALL_DIRECTORY "DaisyToolchain")
# if(WIN32 AND NOT UNIX)
#   There is a bug in NSI that does not handle full UNIX paths properly.
#   Make sure there is at least one set of four backlashes.
#   set(CPACK_PACKAGE_ICON "${CMake_SOURCE_DIR}/Utilities/Release\\\\InstallIcon.bmp")
  set(CPACK_NSIS_INSTALLED_ICON_NAME "bin\\\\DaisyToolchain.exe")
  set(CPACK_NSIS_DISPLAY_NAME "${CPACK_PACKAGE_INSTALL_DIRECTORY}")
  set(CPACK_NSIS_HELP_LINK "http:\\\\\\\\www.github.com/electro-smith/DaisyWiki/wiki/1.-Setting-Up-Your-Development-Environment")
  set(CPACK_NSIS_URL_INFO_ABOUT "http:\\\\\\\\www.electro-smith.com")
  set(CPACK_NSIS_CONTACT "contact@electro-smith.com")
  set(CPACK_NSIS_MODIFY_PATH ON)
  set(CPACK_NSIS_DaisyToolchain_INSTALL_DIRECTORY "Release\\\\")
  set(CPACK_NSIS_FULL_INSTALL ON)
# else()
#   set(CPACK_STRIP_FILES "bin/DaisyToolchain")
#   set(CPACK_SOURCE_STRIP_FILES "")
# endif()
set(CPACK_PACKAGE_EXECUTABLES "DaisyToolchain" "Daisy Toolchain")
include(CPack)

install(TARGETS DaisyToolchain)