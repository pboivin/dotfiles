#!/usr/bin/env bash

FILES=".bashrc .vimrc .gitrc"

for f in $FILES
do
    mv "$HOME/$f" "$HOME/$f-bk-$(date +%s)"
    ln -s "$PWD/$f" "$HOME/$f"
done
