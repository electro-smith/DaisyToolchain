project(DaisyToolchain)

cmake_minimum_required(VERSION 3.20)

set(CPACK_PACKAGE_DESCRIPTION_SUMMARY "Daisy Toolchain")
set(CPACK_PACKAGE_VENDOR "Electro-Smith")
# set(CPACK_PACKAGE_DESCRIPTION_FILE "${CMAKE_CURRENT_SOURCE_DIR}/ReadMe.txt")
# set(CPACK_RESOURCE_FILE_LICENSE "${CMAKE_CURRENT_SOURCE_DIR}/Copyright.txt")
set(CPACK_PACKAGE_VERSION_MAJOR "1")
set(CPACK_PACKAGE_VERSION_MINOR "0")
set(CPACK_PACKAGE_VERSION_PATCH "0")
set(CPACK_PACKAGE_INSTALL_DIRECTORY "DaisyToolchain")
if(WIN32 AND NOT UNIX)
#   There is a bug in NSI that does not handle full UNIX paths properly.
#   Make sure there is at least one set of four backlashes.
# set(CPACK_PACKAGE_ICON  "${CMAKE_CURRENT_SOURCE_DIR}/resources\\\\DaisyPrime.bmp")
  set(CPACK_NSIS_INSTALLED_ICON_NAME "bin\\\\DaisyToolchain.exe")
  set(CPACK_NSIS_DISPLAY_NAME "${CPACK_PACKAGE_INSTALL_DIRECTORY}")
  set(CPACK_NSIS_HELP_LINK "http:\\\\\\\\www.github.com/electro-smith/DaisyWiki/wiki/1.-Setting-Up-Your-Development-Environment")
  set(CPACK_NSIS_URL_INFO_ABOUT "http:\\\\\\\\www.electro-smith.com")
  set(CPACK_NSIS_CONTACT "hello@electro-smith.com")
  set(CPACK_NSIS_MODIFY_PATH ON)
  set(CPACK_NSIS_DaisyToolchain_INSTALL_DIRECTORY "Release\\\\")
  set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} "${CMAKE_SOURCE_DIR}/") # custom nsis location
  install(DIRECTORY ../windows/bin DESTINATION .)

else()
  set(CPACK_STRIP_FILES "bin/DaisyToolchain")
  set(CPACK_SOURCE_STRIP_FILES "")
endif()

set(CPACK_PACKAGE_EXECUTABLES "DaisyToolchain" "Daisy Toolchain")
include(CPack)
