#!/usr/bin/env bash

cd "$HOME"

# backup existing .vim
mv ".vim" ".vim-bk-$(date +%s)"

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
mkdir ".vim/syntax"

# install Vundle
cd ".vim/bundle"
git clone https://github.com/gmarik/Vundle.vim.git Vundle.vim

# run vim and install plugins
vim -c "PluginUpdate"

