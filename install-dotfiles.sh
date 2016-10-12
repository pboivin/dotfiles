#!/usr/bin/env bash

LINK="true"
FILES=".bashrc .vimrc .vimrc-plugins .gitconfig .npmrc"

for f in $FILES; do
    NEW="$PWD/$f"
    ORIG="$HOME/$f"
    BACKUP="$HOME/$f-bk-$(date +%s)"

    if [ -e "$ORIG" ]; then
        mv "$ORIG" "$BACKUP" 
    fi

    if [ "$LINK" == "true" ]; then
        ln -s "$NEW" "$ORIG"
    else
        cp -r "$NEW" "$ORIG"
    fi
done
