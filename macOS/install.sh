#!/bin/bash

# path variable
echo "Installing DaisyToolchain"

MACOS="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
MACOS="$MACOS"/bin
echo -e "\nexport PATH="$MACOS:'$PATH'"" >> ~/.bashrc
echo -e "\nexport PATH="$MACOS:'$PATH'"" >> ~/.zshrc

# install brew
if ! command -v brew &> /dev/null
then
    echo "Installing Homebrew: Follow onscreen instructions"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

#upgrade homebrew
echo "Upgrading Homebrew"
brew update
brew upgrade

# install packages
echo "Installing openocd"
brew install openocd

echo "Installing dfu-util"
brew install dfu-util
