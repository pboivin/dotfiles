#!/usr/bin/env bash

#
# Config
#

CONFIG_LINK="true"    # otherwise files will be copied
CONFIG_SRC="$PWD/src"
CONFIG_DEST="$HOME"
CONFIG_DOTFILES="bashrc vimrc vimrc-plugins gitconfig"
CONFIG_LOCAL="bashrc_local vimrc_local"

#
# Helper functions
#

function backup_file() {
    local original_file="$1"
    local backup_file="$original_file-bk-$(date +%s)"

    if [ -e "$original_file" ]; then
        echo "Backing up $original_file"
        mv "$original_file" "$backup_file" 
    fi
}

function install_file() {
    local from_file="$1"
    local to_file="$2"

    echo "Installing $to_file"

    if [ "$CONFIG_LINK" == "true" ]; then
        ln -s "$from_file" "$to_file"
    else
        cp -r "$from_file" "$to_file"
    fi
}

#
# Check if we're in the dotfiles directory
#

if [ -e "$CONFIG_SRC" ]; then
    echo 
    echo "Ready"
    echo 
else
    echo 
    echo "Error: can't find the 'src/' folder"
    echo 
    exit 1
fi

#
# Install all static dotfiles
#

for file in $CONFIG_DOTFILES; do
    from_file="$CONFIG_SRC/$file"
    to_file="$CONFIG_DEST/.$file"

    backup_file "$to_file"
    install_file "$from_file" "$to_file"
done

#
# Create local config files (if needed)
#

for file in $CONFIG_LOCAL; do
    touch "$CONFIG_DEST/$file"
done

#
# Platform-specific stuff
#

if [ "$(uname)" == "Linux" ]
then
    # Nothing here
    echo
fi

if [ "$(uname)" == "Darwin" ]
then
    bashrc_file="$CONFIG_DEST/.bashrc"
    profile_file="$CONFIG_DEST/.profile"

    backup_file "$profile_file"
    ln -s "$bashrc_file" "$profile_file"
fi

echo
echo "DONE!"
echo

