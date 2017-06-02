#!/usr/bin/env bash

echo
echo
echo "Press ENTER to install Homebrew"
read foo

/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

echo
echo
echo "Press ENTER to install Cask"
read foo

brew tap caskroom/cask

