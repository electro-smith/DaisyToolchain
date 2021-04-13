# macOS toolchain

## Usage

To install, open the Terminal application, type `cd` and drag the macOS directory. You should place a space between the words `cd` and the path being dragged in.

Press enter.

Now type

`./install.sh` and press enter.

This will run the brew installer (if needed), use it to install any tools, and update the PATH variable to have the arm toolchain in it.

## Where did these files come from?

Make was installed through the MacOS Developer Tools (usually queried when attempting t run make)

The arm toolchain (gcc, g++, ar, etc.) are stored locally.

All other tools installed via brew

## Major tool versions

 - gcc-arm-embedded: [10-2020-q4-major](https://developer.arm.com/-/media/Files/downloads/gnu-rm/10-2020q4/gcc-arm-none-eabi-10-2020-q4-major-mac.tar.bz2?revision=48a4e09a-eb5a-4eb8-8b11-d65d7e6370ff&la=en&hash=8AACA5F787C5360D2C3C50647C52D44BCDA1F73F)

## Licenses

Licenses can be found in each tool's folder in the LICENSE file.