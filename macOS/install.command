#!/bin/bash

# path variable
echo "Installing DaisyToolchain"
SCRIPTPATH=$(cd `dirname "${BASH_SOURCE[0]}"` && pwd)

# install brew
if ! command -v brew &> /dev/null
then
    echo "Installing Homebrew: Follow onscreen instructions"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

#upgrade homebrew
echo "Updating Homebrew"
brew update
#brew upgrade # I don't think we should force everyone's tools to update.

echo "Installing packages with Homebrew"
brew install openocd dfu-util
brew install $SCRIPTPATH/gcc-arm-embedded.rb --cask

find /usr/local/Caskroom/gcc-arm-embedded -type f -perm +111 -print | xargs spctl --add --label "gcc-arm-embedded"
find /usr/local/Caskroom/gcc-arm-embedded | xargs xattr -d com.apple.quarantine

echo "Done"
