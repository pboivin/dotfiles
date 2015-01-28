dotfiles
========

Here I share some of the configuration files I have assembled from various sources over time.

Installation
------------

*1. Clone the repository*

  ```
  git clone https://github.com/pboi20/dotfiles.git
  cd dotfiles
  ```

*2. Run the install script*

  ```
  bash install-dotfiles.sh
  ```

This will create a symlink in your $HOME directory for each configuration file. The script will leave a backup of any file that's already there. Alternatively, you could manually copy only the files you want.

*3. Run the Vim setup script*

  ```
  bash setup-vim-vundle.sh
  ```

This will install and configure Vundle, a plugin manager for Vim. This will also install all the plugins that are specified at the top of the .vimrc file.

Disclaimer
----------

This is a work in progress. 
