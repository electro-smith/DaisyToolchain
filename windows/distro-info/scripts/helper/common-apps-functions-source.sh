# -----------------------------------------------------------------------------
# This file is part of the xPack distribution.
#   (https://xpack.github.io)
# Copyright (c) 2020 Liviu Ionescu.
#
# Permission to use, copy, modify, and/or distribute this software 
# for any purpose is hereby granted, under the terms of the MIT license.
# -----------------------------------------------------------------------------

# Helper script used in xPack Developer Tools build scripts. 
# As the name implies, it should contain only functions and 
# should be included with 'source' by the build scripts (both native
# and container).

# -----------------------------------------------------------------------------

function build_patchelf() 
{
  # https://nixos.org/patchelf.html
  # https://github.com/NixOS/patchelf
  # https://github.com/NixOS/patchelf/releases/
  # https://github.com/NixOS/patchelf/releases/download/0.12/patchelf-0.12.tar.bz2
  # https://github.com/NixOS/patchelf/archive/0.12.tar.gz
  
  # 2016-02-29, "0.9"
  # 2019-03-28, "0.10"
  # 2020-06-09, "0.11"
  # 2020-08-27, "0.12"

  local patchelf_version="$1"

  local patchelf_src_folder_name="patchelf-${patchelf_version}"

  local patchelf_archive="${patchelf_src_folder_name}.tar.bz2"
  # GitHub release archive.
  local patchelf_github_archive="${patchelf_version}.tar.gz"
  local patchelf_url="https://github.com/NixOS/patchelf/archive/${patchelf_github_archive}"

  local patchelf_folder_name="${patchelf_src_folder_name}"

  local patchelf_stamp_file_path="${STAMPS_FOLDER_PATH}/stamp-${patchelf_folder_name}-installed"
  if [ ! -f "${patchelf_stamp_file_path}" ]
  then

    cd "${SOURCES_FOLDER_PATH}"

    download_and_extract "${patchelf_url}" "${patchelf_archive}" \
      "${patchelf_src_folder_name}"

    mkdir -pv "${LOGS_FOLDER_PATH}/${patchelf_folder_name}"

    (
      if [ ! -x "${SOURCES_FOLDER_PATH}/${patchelf_src_folder_name}/configure" ]
      then

        cd "${SOURCES_FOLDER_PATH}/${patchelf_src_folder_name}"
        
        xbb_activate
        xbb_activate_installed_dev

        run_verbose bash ${DEBUG} "bootstrap.sh"

      fi
    ) 2>&1 | tee "${LOGS_FOLDER_PATH}/${patchelf_folder_name}/autogen-output.txt"

    (
      mkdir -pv "${LIBS_BUILD_FOLDER_PATH}/${patchelf_folder_name}"
      cd "${LIBS_BUILD_FOLDER_PATH}/${patchelf_folder_name}"

      xbb_activate
      xbb_activate_installed_dev

      CPPFLAGS="${XBB_CPPFLAGS}"
      CFLAGS="${XBB_CFLAGS_NO_W}"
      CXXFLAGS="${XBB_CXXFLAGS_NO_W}"
      LDFLAGS="${XBB_LDFLAGS_APP_STATIC_GCC}"
      if [ "${TARGET_PLATFORM}" == "linux" ]
      then
        LDFLAGS+=" -Wl,-rpath,${LD_LIBRARY_PATH}"
      fi      
      if [ "${IS_DEVELOP}" == "y" ]
      then
        LDFLAGS+=" -v"
      fi

      export CPPFLAGS
      export CFLAGS
      export CXXFLAGS
      export LDFLAGS

      env | sort

      if [ ! -f "config.status" ]
      then
        (
          echo
          echo "Running patchelf configure..."

          bash "${SOURCES_FOLDER_PATH}/${patchelf_src_folder_name}/configure" --help

          config_options=()

          config_options+=("--prefix=${LIBS_INSTALL_FOLDER_PATH}")
            
          config_options+=("--build=${BUILD}")
          config_options+=("--host=${HOST}")
          config_options+=("--target=${TARGET}")

          run_verbose bash ${DEBUG} "${SOURCES_FOLDER_PATH}/${patchelf_src_folder_name}/configure" \
            ${config_options[@]}

          cp "config.log" "${LOGS_FOLDER_PATH}/${patchelf_folder_name}/config-log.txt"
        ) 2>&1 | tee "${LOGS_FOLDER_PATH}/${patchelf_folder_name}/configure-output.txt"
      fi

      (
        echo
        echo "Running patchelf make..."

        # Build.
        run_verbose make -j ${JOBS}

        if [ "${WITH_STRIP}" == "y" ]
        then
          run_verbose make install-strip
        else
          run_verbose make install
        fi

        show_libs "${LIBS_INSTALL_FOLDER_PATH}/bin/patchelf"

      ) 2>&1 | tee "${LOGS_FOLDER_PATH}/${patchelf_folder_name}/make-output.txt"

      copy_license \
        "${SOURCES_FOLDER_PATH}/${patchelf_src_folder_name}" \
        "${patchelf_folder_name}"

    )

    (
      test_patchelf
    ) 2>&1 | tee "${LOGS_FOLDER_PATH}/${patchelf_folder_name}/test-output.txt"

    touch "${patchelf_stamp_file_path}"

  else
    echo "Component patchelf already installed."
  fi
}

function test_patchelf()
{
  (
    xbb_activate

    echo
    echo "Checking the patchelf shared libraries..."

    show_libs "${LIBS_INSTALL_FOLDER_PATH}/bin/patchelf"

    echo
    echo "Checking if patchelf starts..."
    "${LIBS_INSTALL_FOLDER_PATH}/bin/patchelf" --version
    "${LIBS_INSTALL_FOLDER_PATH}/bin/patchelf" --help
  )
}

# -----------------------------------------------------------------------------

function build_automake() 
{
  # https://www.gnu.org/software/automake/
  # https://ftp.gnu.org/gnu/automake/

  # https://archlinuxarm.org/packages/any/automake/files/PKGBUILD
  # https://aur.archlinux.org/cgit/aur.git/tree/PKGBUILD?h=automake-git

  # 2015-01-05, "1.15"
  # 2018-02-25, "1.16"
  # 2020-03-21, "1.16.2"
  # 2020-11-18, "1.16.3"

  local automake_version="$1"

  local automake_src_folder_name="automake-${automake_version}"

  local automake_archive="${automake_src_folder_name}.tar.xz"
  local automake_url="https://ftp.gnu.org/gnu/automake/${automake_archive}"

  local automake_folder_name="${automake_src_folder_name}"

  # help2man: can't get `--help' info from automake-1.16
  # Try `--no-discard-stderr' if option outputs to stderr

  local automake_patch_file_path="${BUILD_GIT_PATH}/patches/${automake_folder_name}.patch"
  local automake_stamp_file_path="${STAMPS_FOLDER_PATH}/stamp-${automake_folder_name}-installed"
  if [ ! -f "${automake_stamp_file_path}" -o ! -d "${BUILD_FOLDER_PATH}/${automake_folder_name}" ]
  then

    cd "${SOURCES_FOLDER_PATH}"

    download_and_extract "${automake_url}" "${automake_archive}" \
      "${automake_src_folder_name}" \
      "${automake_patch_file_path}"

    mkdir -pv "${LOGS_FOLDER_PATH}/${automake_folder_name}"

    (
      mkdir -pv "${BUILD_FOLDER_PATH}/${automake_folder_name}"
      cd "${BUILD_FOLDER_PATH}/${automake_folder_name}"

      xbb_activate
      xbb_activate_installed_dev

      export CPPFLAGS="${XBB_CPPFLAGS}"
      export CFLAGS="${XBB_CFLAGS_NO_W}"
      export CXXFLAGS="${XBB_CXXFLAGS_NO_W}"
      export LDFLAGS="${XBB_LDFLAGS_APP}"

      env | sort

      if [ ! -f "config.status" ]
      then
        (
          echo
          echo "Running automake configure..."

          bash "${SOURCES_FOLDER_PATH}/${automake_src_folder_name}/configure" --help

          run_verbose bash ${DEBUG} "${SOURCES_FOLDER_PATH}/${automake_src_folder_name}/configure" \
            --prefix="${LIBS_INSTALL_FOLDER_PATH}" \
            \
            --build="${BUILD}" \

          cp "config.log" "${LOGS_FOLDER_PATH}/${automake_folder_name}/config-log.txt"
        ) 2>&1 | tee "${LOGS_FOLDER_PATH}/${automake_folder_name}/configure-output.txt"
      fi

      (
        echo
        echo "Running automake make..."

        # Build.
        run_verbose make -j ${JOBS}

        # make install-strip
        run_verbose make install

        # Takes too long and some tests fail.
        # XFAIL: t/pm/Cond2.pl
        # XFAIL: t/pm/Cond3.pl
        # ...
        if false # [ "${RUN_LONG_TESTS}" == "y" ]
        then
          run_verbose make -j1 check
        fi

      ) 2>&1 | tee "${LOGS_FOLDER_PATH}/${automake_folder_name}/make-output.txt"
    )

    (
      test_automake
    ) 2>&1 | tee "${LOGS_FOLDER_PATH}/${automake_folder_name}/test-output.txt"

    hash -r

    touch "${automake_stamp_file_path}"

  else
    echo "Component automake already installed."
  fi

  test_functions+=("test_automake")
}

function test_automake()
{
  (
    xbb_activate_installed_bin

    echo
    echo "Testing if automake binaries start properly..."

    run_verbose "${LIBS_INSTALL_FOLDER_PATH}/bin/automake" --version
  )
}

# -----------------------------------------------------------------------------
