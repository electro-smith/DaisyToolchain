#!/bin/bash
MACOS="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
MACOS="$MACOS"/bin
echo -e "\nexport PATH="$MACOS:'$PATH'"" >> ~/.bashrc
echo -e "\nexport PATH="$MACOS:'$PATH'"" >> ~/.zshrc
