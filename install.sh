#!/usr/bin/env bash

LINK_FILES="true" # otherwise files will be copied
SOURCE="$PWD/config"
DESTINATION="$HOME"
CONFIG_FILES=".gitconfig .gitignore_global .vimrc"
CONFIG_LOCALS=".bashrc_local .vimrc_local"

#
# Helper functions
#

function say() {
    echo
    echo "$1"
}

function backup_file() {
    local original_file="$1"
    local backup_file="$original_file.backup.$(date +%s)"

    if [ -e "$original_file" ]; then
        say "Backing up $original_file"
        mv "$original_file" "$backup_file"
    fi
}

function install_file() {
    local from_file="$1"
    local to_file="$2"

    say "Installing $to_file"

    if [ "$LINK_FILES" == "true" ]; then
        ln -s "$from_file" "$to_file"
    else
        cp -r "$from_file" "$to_file"
    fi
}

#
# Check if we're in the dotfiles directory
#

if [ -e "$SOURCE" ]; then
    say "Ready"
else
    say "Error: can't find the $SOURCE folder"
    exit 1
fi

#
# Install config files
#

for file in $CONFIG_FILES; do
    from_file="$SOURCE/$file"
    to_file="$DESTINATION/$file"

    backup_file "$to_file"
    install_file "$from_file" "$to_file"
done

#
# Create local config files if needed
#

for file in $CONFIG_LOCALS; do
    touch "$DESTINATION/$file"
done

#
# Setup bashrc
#

bashrc_system="$DESTINATION/.bashrc"
bashrc_main="$DESTINATION/.bashrc-main"

touch "$bashrc_system"
echo "
. \"$bashrc_main\"

" >> "$bashrc_system"

say "DONE"

