# macOS toolchain

## Usage

For users, a pre-compiled installer can be found in the `bin` folder. Simply run the installer, follow the prompts, and you'll be good to go.

For development, the `ease-build.sh` script is all you need to run to generate the installer. It simply stores the version and program name, calls the `build-macos-x64.sh` script, and copies the output to the `bin` folder.

## Where did these files come from?

Make is installed through the MacOS Developer Tools (usually queried when attempting to run make).

The arm toolchain, dfu-util, and openocd are stored in `/Library/DaisyToolchain` and symlinked into `/usr/local/bin`.

## Package versions

 - openocd: 0.11.0
 - dfu-util: 0.10
 - clang-format: 10.0.0
 - arm toolchain: 10-2020-q4-major

## Licenses

Licenses can be found in each tool's folder in the LICENSE file.