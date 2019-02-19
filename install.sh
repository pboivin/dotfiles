#!/usr/bin/env bash


CONFIG_LINK="true"    # otherwise files will be copied
CONFIG_SRC="$PWD/src"
CONFIG_DEST="$HOME"
CONFIG_DOTFILES=".bashrc-main .vimrc .vimrc-plugins .gitconfig .tmux.conf"
CONFIG_LOCAL=".bashrc_local .vimrc_local"


#
# Helper functions
#

function say() {
    echo
    echo "$1"
}

function backup_file() {
    local original_file="$1"
    local backup_file="$original_file-bk-$(date +%s)"

    if [ -e "$original_file" ]; then
        say "Backing up $original_file"
        mv "$original_file" "$backup_file"
    fi
}

function install_file() {
    local from_file="$1"
    local to_file="$2"

    say "Installing $to_file"

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
    say "Ready"
else
    say "Error: can't find the 'src/' folder"
    exit 1
fi

#
# Install all static dotfiles
#

for file in $CONFIG_DOTFILES; do
    from_file="$CONFIG_SRC/$file"
    to_file="$CONFIG_DEST/$file"

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
# All platforms
#

bashrc_system="$CONFIG_DEST/.bashrc"
bashrc_main="$CONFIG_DEST/.bashrc-main"

touch "$bashrc_system"
echo "
. \"$bashrc_main\"

" >> "$bashrc_system"

#
# macOS
#

if [ "$(uname)" == "Darwin" ]
then
    bashrc_file="$CONFIG_DEST/.bashrc"
    profile_file="$CONFIG_DEST/.profile"

    backup_file "$profile_file"
    cp "$bashrc_file" "$profile_file"
fi

say "DONE!"
say ""

