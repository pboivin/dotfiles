#!/usr/bin/env bash

BACKUP_FILES="false" # otherwise existing files will be skipped
LINK_FILES="true" # otherwise files will be copied

CONFIG="$PWD/config"
SCRIPTS="$PWD/scripts"
DESTINATION="$HOME"
CONFIG_FILES=".bashrc_main .gitconfig .gitignore_global .tmux.conf .vimrc"
CONFIG_LOCALS=".bashrc_local .vimrc_local"

#
# Helper functions
#

function backup_file() {
    local original_file="$1"
    local backup_file="$original_file.backup.$(date +%s)"

    if [ -e "$original_file" ]; then
        echo
        echo "Backing up $original_file"
        mv "$original_file" "$backup_file"
    fi
}

function install_file() {
    local from_file="$1"
    local to_file="$2"

    if [ ! -e "$from_file" ]; then
        echo "ERROR: $from_file (file not found)"
        exit 1
    fi

    if [ -e "$to_file" ]; then
        echo
        echo "Skipping $to_file (file exists)"
    else
        echo
        echo "Installing $to_file"

        if [ "$LINK_FILES" == "true" ]; then
            ln -s "$from_file" "$to_file"
        else
            cp -r "$from_file" "$to_file"
        fi
    fi
}

function install_local_file() {
    local from_file="$1"
    local to_file="$2"

    if [ -e "$to_file" ]; then
        echo
        echo "Skipping $to_file (file exists)"
    else
        echo
        echo "Installing $to_file"

        if [ -e "$from_file" ]; then
            cp -r "$from_file" "$to_file"
        else
            touch "$to_file"
        fi
    fi
}

#
# Check if we're in the dotfiles directory
#

if [ -e "$CONFIG" ]; then
    echo
else
    echo "Error: can't find the $CONFIG folder"
    exit 1
fi

#
# Install config files
#

for file in $CONFIG_FILES; do
    from_file="$CONFIG/$file"
    to_file="$DESTINATION/$file"

    if [ "$BACKUP_FILES" == "true" ]; then
        backup_file "$to_file"
    fi

    install_file "$from_file" "$to_file"
done

#
# Create local config files if needed
#

for file in $CONFIG_LOCALS; do
    from_file="$CONFIG/$file"
    to_file="$DESTINATION/$file"

    install_local_file "$from_file" "$to_file"
done

#
# Install scripts
#

mkdir -p "$HOME/bin"

cd "$SCRIPTS"

chmod 755 *

for file in *; do
    from_file="$SCRIPTS/$file"
    to_file="$HOME/bin/$file"

    install_file "$from_file" "$to_file"
done


echo
echo "DONE"
echo
