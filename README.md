dotfiles
========

Here are some of the configuration files I have assembled from various sources over time.


Installation
------------

#### 1. Clone the repository

```
git clone https://github.com/pboi20/dotfiles.git
cd dotfiles/src
```

#### 2. Manually copy the files to your home directory

```
cp .bashrc-main "$HOME/.bashrc"
cp .vimrc "$HOME/.vimrc"
cp .vimrc-plugins "$HOME/.vimrc-plugins"
```

#### 3. Alternatively, run the install scripts

```
bash install.sh
```

This will create a symlink in your `$HOME` directory for each configuration file. The script will leave a backup of any file that's already there.

```
bash setup-vim.sh
```

This will setup your `$HOME/.vim` directory and install Vundle as a plugin manager.


Disclaimer
----------

This is a work in progress :)
