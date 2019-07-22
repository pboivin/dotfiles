"==============================================================================
" Plugins
"==============================================================================

" Map leader
let mapleader=","

if !empty(glob("~/.vimrc-plugins"))
    source ~/.vimrc-plugins
endif

"==============================================================================
" General Editor Settings
"==============================================================================

" Turn off vi compatibility
set nocompatible

" Use unicode
set encoding=utf-8

" Unix line endings
set fileformat=unix
" Alternatively,
" > set fileformat=dos

" No in-place "file~" backups
set nobackup
" Alternatively, set a backup directory
" > set backupdir=~/.vim/backup

" Enable swap files
set swapfile
" Alternatively,
" > set directory=~/.vim/swap

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

" Reset the terminal code for the visual bell.
set t_vb=

" Mouse integration
" > a: All modes
" > i: Insert mode only
" > n: Normal mode only (useful for copy/pasting with Xorg buffer while in insert mode)
set mouse=n

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

" Wrap long lines, don't break words
set wrap
set linebreak

" Include hyphenated keywords in autocomplete suggestions
"set iskeyword+=\-

" Preserve selection when un/indenting lines
vmap > >gv
vmap < <gv

"==============================================================================
" Copy/Paste
"==============================================================================

" Select everything
noremap <leader>a ggVG

" Yank to system clipboard
noremap <leader>y "+y

" Paste from system clipboard with extra effort
function! PasteFromSystemFn()
    set paste
    execute 'normal "+P'
    set nopaste
endfunction
command! PasteFromSystem call PasteFromSystemFn()
noremap <leader>p :PasteFromSystem<CR>

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

" Search for visually selected text
vnoremap // y/<c-r>"<cr>

" Grep files in cwd, recursive
function! GrepFn(search)
    execute "vimgrep " . a:search . " **/*"
    execute "cwindow"
endfunction
command! -nargs=1 Grep call GrepFn("<args>")

" Grep help files
function! GrepHelpFn(search)
    execute "helpgrep " . a:search
    execute "cwindow"
endfunction
command! -nargs=1 GrepHelp call GrepHelpFn("<args>")

"==============================================================================
" Custom Movements
"==============================================================================

" Go to ^ and $
noremap  <S-Left> 0
inoremap <S-Left> <Esc>0i
noremap  <S-Right> $
inoremap <S-Right> <Esc>A

" Faster movements up and down
noremap  <S-Down> 3j
inoremap <S-Down> <Esc>3ja
noremap  <S-Up> 3k
inoremap <S-Up> <Esc>3ka

noremap  <C-d> 3j
inoremap <C-d> <Esc>3ja
noremap  <C-u> 3k
inoremap <C-u> <Esc>3ka

noremap  <C-j> 3j
inoremap <C-j> <Esc>3ja
noremap  <C-k> 3k
inoremap <C-k> <Esc>3ka

" Faster movements up and down with scrolling
noremap  <C-Down> 9jzz
inoremap <C-Down> <Esc>9jzza
noremap  <C-Up> 9kzz
inoremap <C-Up> <Esc>9kzza

noremap  <C-f> 9jzz
inoremap <C-f> <Esc>9jzza
noremap  <C-b> 9kzz
inoremap <C-b> <Esc>9kzza

" Fine-grained word jumping
" > Note that <C-Left> is assigned to 'b' and next 'bn' is assigned to ':bn' 
" > without any conflict because of noremap
noremap <C-Left> b
noremap <C-Right> w

" Buffer switching
noremap bp :bp<CR>
noremap bn :bn<CR>
noremap bl :ls<CR>

" Tab switching
nnoremap tp :tabprev<CR>
nnoremap tn :tabnext<CR>
nnoremap tt :tabnew<CR>
nnoremap tc :tabclose<CR>
nnoremap te :tabnew<CR>:e .<CR>
nnoremap t0 :tabmove 0<CR>

" Next Window (Fast)
noremap  <S-W> <C-W><C-W>

" Next Tab (Fast)
nnoremap <S-T> :tabnext<CR>

"==============================================================================
" GUI
"==============================================================================

" Default font
set guifont=Monospace\ 9

" Font select shortcut
command! Font set guifont=*

"==============================================================================
" Spell Check
"==============================================================================

command! SpellFr setlocal spell spelllang=fr
command! SpellEn setlocal spell spelllang=en
command! SpellOff setlocal nospell

"==============================================================================
" Custom Commands / Shortcuts
"==============================================================================

"------------
" Whitespace
"------------

function! TabsToSpacesFn()
    let l:count = 0
    let l:softtab = ""
    while l:count < &softtabstop
        let l:softtab .= " "
        let l:count += 1
    endwhile
    execute "%s/\t/" . l:softtab . "/g"
endfunction
command! TabsToSpaces call TabsToSpacesFn()

command! TabsFind /\t/

command! TrimLineEndings %s/\(\w*\) \+$/\1/g

command! RemoveEmptyLines g/^\s*$/d

" Use soft tabs
function! SetSoftTabsFn(width)
    execute "set shiftwidth=" . a:width
    execute "set softtabstop=" . a:width
    set tabstop=8
    set smarttab
    set expandtab
endfunction
command! -nargs=1 SetSoftTabs call SetSoftTabsFn("<args>")

" Use hard tabs
function! SetHardTabsFn(width)
    execute "set shiftwidth=" . a:width
    execute "set softtabstop=" . a:width
    execute "set tabstop=" . a:width
    set nosmarttab
    set noexpandtab
endfunction
command! -nargs=1 SetHardTabs call SetHardTabsFn("<args>")

"------------
" Quoting
"------------

command! -range SingleToDoubleQuotes '<,'>s/'/"/g

command! -range DoubleToSingleQuotes '<,'>s/"/'/g

"---------------------------
" Autoindent + Virtual Edit
"---------------------------
"
" Useful mode for drawing tables or ascii art.
"

function! AveOnFn()
    set autoindent
    set virtualedit=all
endfunction
command! AveOn call AveOnFn()

function! AveOffFn()
    set noautoindent
    set virtualedit=
endfunction
command! AveOff call AveOffFn()

"---------
" Folding
"---------

" FI - Activate folding by indent. Close all folds.
function! FoldIndentFn()
    set foldmethod=indent
    execute "normal zM"
endfunction
command! FI call FoldIndentFn()

" FK - Activate folding by marker. Close all folds.
function! FoldMarkerFn()
    set foldmethod=marker
    execute "normal zM"
endfunction
command! FK call FoldMarkerFn()

" FM - Disable folding (set to manual). Open all folds.
function! FoldManualFn()
    set foldmethod=manual
    execute "normal zR"
endfunction
command! FM call FoldManualFn()

"-------------
" File Format
"-------------
"
" Reference: http://vim.wikia.com/wiki/File_format
"

function! DosToUnixFn()
    update
    edit ++ff=dos
    setlocal ff=unix
    write
endfunction
command! DosToUnix call DosToUnixFn()

function! UnixToDosFn()
    update
    edit ++ff=dos
    write
endfunction
command! UnixToDos call UnixToDosFn()

"-------------
" Code Format
"-------------

" Set filetype for auto formatting (=)
function! SetFormatFn(filetype)
    filetype indent on
    execute "set filetype=" . a:filetype
    set smartindent
endfunction
command! -nargs=1 SetFormat call SetFormatFn("<args>")

" Format JSON buffer
command! FormatJSON %!python -mjson.tool

"------
" Misc
"------

" WR - Toggle line wrapping
command! WR set wrap!

" QQ - Quickly Quit
command! QQ qa!

"==============================================================================
" Custom Commands / Shortcuts For Plugins
"==============================================================================

"------
"  AG
"------

" AG - Search content
command! -nargs=* AG Ag <args>

" AS - Search content using last search expression
command! AS AgFromSearch

" AF - Search file names
command! -nargs=* AF AgFile <args>

"-----------------
" NerdTree / Tabs
"-----------------

" NF - Highlight current file in Nerd Tree
command! NF NERDTreeTabsFind

"----------------
" Git / Fugitive
"----------------

" GP - Get the output of 'git log -p' for current file. Opens in new tab.
function! GitLogPatchFn()
    let l:cmd = "r!git log -p '" . expand("%") . "'"
    tabnew
    execute l:cmd
    SetFormat diff
    normal gg
endfunction
command! GP call GitLogPatchFn()

" GL - Alias for Glog. Opens quicklist.
command! GL Glog | :copen

" GS - Alias for Gstatus
command! GS Gstatus

"==============================================================================
" File types
"==============================================================================

au BufRead,BufNewFile *.vue set filetype=html

"==============================================================================
" Extra config. files
"==============================================================================

" Load ~/.vimrc_local if it exists
if !empty(glob("~/.vimrc_local"))
    source ~/.vimrc_local
endif

" Load project .vimrc if it exists
set exrc
