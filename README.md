dotfiles
========

Here I share some of the configuration files I have assembled from various sources over time.

Installation
------------

1. Clone the repository

  ```
  git clone https://github.com/pboi20/dotfiles.git
  cd dotfiles
  ```

2. Run the install script

  ```
  bash install-dotfiles.sh
  ```

This will create a symlink in your $HOME directory for each configuration file. The script will leave a backup of any file that's already there. Alternatively, you could manually copy only the files you want.

3. Run the setup scripts

  ```
  setup-vim-vundle.sh
      Setup Vim and plugins, using Vundle as plugin manager

  setup-homebrew-cask.sh
      Install Homebrew as package manager, including Cask for common apps

  setup-rupa-z.sh
        Install the z command-line tool
  ```

Disclaimer
----------

This is a work in progress :)
