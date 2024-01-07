#!/usr/bin/env bash

cd "$HOME"

# backup existing .vim
if [ -e ".vim" ]; then
    mv ".vim" ".vim.backup.$(date +%s)"
fi

# create .vim directory structure
mkdir ".vim"
mkdir ".vim/autoload"
mkdir ".vim/bundle"
mkdir ".vim/colors"
mkdir ".vim/doc"
mkdir ".vim/ftdetect"
mkdir ".vim/plugin"
mkdir ".vim/snippets"
mkdir ".vim/spell"
mkdir ".vim/swap"
mkdir ".vim/syntax"

# TODO install plugins

echo
echo DONE
echo
