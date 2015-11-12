#!/usr/bin/env bash

FILES=".bashrc .vimrc .vimrc-plugins .gitconfig .npmrc"

for f in $FILES; do
    NEW="$PWD/$f"
    ORIG="$HOME/$f"
    BACKUP="$HOME/$f-bk-$(date +%s)"

    if [ -e $ORIG ]; then
        mv $ORIG $BACKUP 
    fi
    ln -s $NEW $ORIG
done
