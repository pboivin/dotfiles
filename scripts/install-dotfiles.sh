#!/usr/bin/env bash

#
# Config
#

LINK="true"    # otherwise files will be copied
SRC="$PWD/src"
DEST="$HOME"
DOTFILES="bashrc vimrc vimrc-plugins gitconfig"

#
# Helper functions
#

function backup_file() {
    local original_file="$1"
    local backup_file="$ORIG-bk-$(date +%s)"

    if [ -e "$original_file" ]; then
        echo "Backing up $original_file"
        mv "$original_file" "$backup_file" 
    fi
}

function install_file() {
    local from_file="$1"
    local to_file="$2"

    echo "Installing $TO"

    if [ "$LINK" == "true" ]; then
        ln -s "$from_file" "$to_file"
    else
        cp -r "$from_file" "$to_file"
    fi
}

#
# Check if we're in the dotfiles directory
#

if [ -e "$SRC" ]; then
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

for file in $DOTFILES; do
    from_file="$SRC/$file"
    to_file="$DEST/.$file"

    backup_file "$to_file"
    install_file "$from_file" "$to_file"
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
    bashrc_file="$DEST/.bashrc"
    profile_file="$DEST/.profile"

    backup_file "$profile_file"
    ln -s "$bashrc_file" "$profile_file"
fi

echo
echo "DONE!"
echo

