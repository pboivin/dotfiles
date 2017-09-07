wget https://raw.githubusercontent.com/pboi20/dotfiles/master/src/vimrc -O $HOME/.vimrc
wget https://raw.githubusercontent.com/pboi20/dotfiles/master/src/bashrc -O $HOME/.bashrc_pboivin

echo '' >> $HOME/.bashrc
echo '. $HOME/.bashrc_pboivin' >> $HOME/.bashrc
