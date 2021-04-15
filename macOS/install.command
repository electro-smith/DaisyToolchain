#!/bin/bash

# path variable
echo "Installing DaisyToolchain"

MACOS="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
MACOS="$MACOS"/gcc-arm-none-eabi/bin
echo -e "\nexport PATH="$MACOS:'$PATH'"" >> ~/.bash_profile
echo -e "\nexport PATH="$MACOS:'$PATH'"" >> ~/.zprofile

# install brew
if ! command -v brew &> /dev/null
then
    echo "Installing Homebrew: Follow onscreen instructions"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

#upgrade homebrew
echo "Upgrading Homebrew"
brew update
#brew upgrade # I don't think we should force everyone's tools to update.

echo "Installing packages with Homebrew"
brew install openocd dfu-util gcc-arm-embedded

