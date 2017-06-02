#!/usr/bin/env bash

echo
echo
echo "Installing Homebrew"
echo
sleep 2

/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

echo
echo
echo "Installing Cask"
echo
sleep 2

brew tap caskroom/cask

