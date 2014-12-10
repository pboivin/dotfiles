" A basic VIM configuration file
" Assembled Patrick Boivin from various sources
"
" References :
"   http://vim.wikia.com/wiki/Example_vimrc

"==============================================================================
" Plugins
"==============================================================================

" Plugin manager
if exists('g:loaded_pathogen')
    call pathogen#infect() 
    Helptags 
endif   

"==============================================================================
" Editor
"==============================================================================

" Use unicode
set encoding=utf-8

" Unix line endings
set fileformat=unix

" Alternatively,
"#  set fileformat=dos

" Turn off vi compatibility
set nocompatible

" No in-place "file~" backups
set nobackup

" Alternatively, set a backup directory
"#  set backupdir=~/.vim/backup

" No in-place "file.swp"
set noswapfile

" Alternatively,
"#  set directory=~/.vim/swap

" Enable syntax highlighting
syntax on

" Display line numbers on the left
set number

" Display the cursor position on the last line of the screen
set ruler

" Show current mode in status bar
set showmode

" Allows to switch from an unsaved buffer without saving it first
set hidden

" Better command-line completion
set wildmenu

" Show partial commands in the last line of the screen
set showcmd

" Set the command window height to 2 lines
set cmdheight=2

" Allow backspacing over autoindent, line breaks and start of insert action
set backspace=indent,eol,start

" Stop certain movements from always going to the first character of a line
set nostartofline

" Always display the status line, even if only one window is displayed
set laststatus=2

" Instead of failing a command because of unsaved changes, raise a
" dialogue asking if you wish to save changed files.
set confirm

" Use visual bell instead of sound
"   (Disabled, it's kind of annoying in gvim...)
"#  set visualbell

" Reset the terminal code for the visual bell.
set t_vb=

" Mouse integration
"   a- Enable use of the mouse for all modes
"   i- Enable for Insert mode only
set mouse=a

" Quickly time out on keycodes, but never time out on mappings
set notimeout ttimeout ttimeoutlen=200

" Size of an indent
set shiftwidth=4

" A combination of spaces and tabs are used to simulate tab stops at a width
" other than the (hard)tabstop
set softtabstop=4

" Make tab insert indents instead of tabs at the beginning of a line
set smarttab

" Always uses spaces instead of tab characters
set expandtab

" Size of a hard tabstop
set tabstop=8

" No wrap by defaut but if we do enable it, don't break words
set nowrap
set linebreak

"==============================================================================
" Search
"==============================================================================

" Highlight searches
set hlsearch

" Use case insensitive search, except when using capital letters
set ignorecase
set smartcase

" Map <C-L> (redraw screen) to also turn off search highlighting until the next search
nnoremap <C-L> :nohl<CR><C-L>

" Start with highlighting off
nohl

" Center window on search result
nnoremap n nzz
nnoremap N Nzz

" Grep files in cwd, recursive
function! GrepFn(search)
    execute 'vimgrep ' . a:search . ' **/*'
    execute 'cwindow'
endfunction
command! -nargs=1 Grep call FuncFn("<args>")

" Grep help files
function! GrepHelpFn(search)
    execute 'helpgrep ' . a:search
    execute 'cwindow'
endfunction
command! -nargs=1 GrepHelp call GrepHelpFn("<args>")

"==============================================================================
" Misc mappings
"==============================================================================

" Preserve selection when un/indenting lines
vmap > >gv
vmap < <gv

" Go to ^ and $
noremap  <S-Left>  0
inoremap <S-Left>  <Esc>0i
noremap  <S-Right> $
inoremap <S-Right> <Esc>A

" Map leader
let mapleader=","

" Faster movements up and down
noremap  <S-Down> 3j
inoremap <S-Down> <Esc>3ja
noremap  <S-Up>   3k
inoremap <S-Up>   <Esc>3ka

" Faster movements up and down with scrolling
noremap  <C-Down> 9jzz
inoremap <C-Down> <Esc>9jzza
noremap  <C-Up>   9kzz
inoremap <C-Up>   <Esc>9kzza
noremap  <C-f>    <C-f>zz
noremap  <C-b>    <C-b>zz

" Fine-grained word jumping
"   Note that <C-Left> is assigned to 'b' and next 'bn' is assigned to ':bn' 
"   without any conflict because of noremap
noremap <C-Left>  b
noremap <C-Right> w

" Buffer switching
noremap [  :bp<CR>
noremap ]  :bn<CR>
noremap bp :bp<CR>
noremap bn :bn<CR>
noremap bl :ls<CR>

" Tab switching
noremap  {  :tabprev<CR>
noremap  }  :tabnext<CR>
nnoremap tp :tabprev<CR>
nnoremap tn :tabnext<CR>
nnoremap tt :tabnew<CR>
nnoremap tc :tabclose<CR>
nnoremap te :tabnew<CR>:e .<CR>

"==============================================================================
" GUI
"==============================================================================

" Default font
set guifont=Monospace\ 9

" Font select shortcut
command! Font :set guifont=*

" X11 copy and paste
noremap <C-K> "+y
noremap <C-P> "+P

" Save with Ctrl+S
noremap <C-s> :w<CR>

"==============================================================================
" Spell check
"==============================================================================

command! SpellFr  :setlocal spell spelllang=fr
command! SpellEn  :setlocal spell spelllang=en
command! SpellOff :setlocal nospell

"==============================================================================
" Custom actions
"==============================================================================

" Lazy aliases
command! W    :w
command! Q    :qa
command! WQ   :wq
command! SO   :source %

" Whitespace
command! TabsToSpaces      :%s/\t/    /g
command! TrimLineEndings   :%s/\(\w*\) \+$/\1/g
command! TrimEmptyLines    :g/^\s*$/d

" AVE on = Autoindent + Virtual Edit
function! AveOnFn()
    set autoindent
    set virtualedit=all
endfunction
command! AVE call AveOnFn()

" AVE off
function! AveOffFn()
    set noautoindent
    set virtualedit=
endfunction
command! NoAVE call AveOffFn()

" Comment : Insert # prefix
command! -range CommentShell :<line1>,<line2>s/^/# /g | nohl

" Comment : Insert // prefix
command! -range CommentJS :<line1>,<line2>s/^/\/\/ /g | nohl

" Switch to soft tabs
function! SetSoftTabsFn(width)
    execute "set shiftwidth=" . a:width
    execute "set softtabstop=" . a:width
    set smarttab
    set expandtab
    set tabstop=8
endfunction
command! -nargs=1 SetSoftTabs call SetSoftTabsFn("<args>")

" Switch to hard tabs
function! SetHardTabsFn()
    set shiftwidth=8
    set softtabstop=8
    set nosmarttab
    set noexpandtab
    set tabstop=8
endfunction
command! SetHardTabs call SetHardTabsFn()
