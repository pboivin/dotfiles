#!/usr/bin/env bash

if [ ! -e "$HOME/src" ]; then
    mkdir "$HOME/src"
fi
cd "$HOME/src"

if [ ! -e "$HOME/src/z" ]; then
    git clone https://github.com/rupa/z.git && \
    echo ". $PWD/z/z.sh" >> $HOME/.bashrc_local
else
    cd z
    git pull
fi
