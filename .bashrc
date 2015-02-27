# A basic Bash configuration file
# Assembled by Patrick Boivin from various sources

#=============================================================================
# Path
#=============================================================================

PATH=$HOME/bin:$PATH

# Node.js
NPM_PACKAGES="${HOME}/.npm-packages"
NODE_PATH="$NPM_PACKAGES/lib/node_modules:$NODE_PATH"
PATH="$NPM_PACKAGES/bin:$PATH"

#=============================================================================
# Prompt
#=============================================================================

function color_normal() {
    echo '\e[0;49;'$1'm'
}

function color_bold() {
    echo '\e[01;'$1'm'
}

function color_clear() {
    echo '\e[0m'
}

COLOR_RED="31"
COLOR_GREEN="32"
COLOR_YELLOW="33"
COLOR_BLUE="34"
COLOR_WHITE="37"
COLOR_GREY="90"

PS1_NAME=$(hostname)
PS1=''$(color_normal $COLOR_YELLOW)'($(date +%H:%M:%S)) \u@'$PS1_NAME' : '$(color_bold $COLOR_WHITE)'\w'$(color_clear)'\n$ '

#=============================================================================
# Aliases
#=============================================================================

# Platform-specific

if [ "$(uname)" == "Linux" ]
then
    alias ls='env ls -FC --color=auto --group-directories-first'
    alias l1='env ls -1F --color=auto'
    alias go='gnome-open'
fi

if [ "$(uname)" == "Darwin" ]
then
    alias ls='env ls -FCG'
    alias l1='env ls -1FG'
    alias mvim='/Applications/MacVim.app/Contents/MacOS/Vim -g'
    alias tedit='open -a textedit'
fi

# Shell

alias l='ls -lh'
alias ll='l -A'
alias la='ls -A'
alias l2='ls *'

alias bk='cd "$OLDPWD"'

function ccd {
    cd $(dirname "$1")
}

alias cd..="cd .."

alias dus='du -s * . | sort -n'

function findi {
    find . -iname "*$1*"
}

alias fl='find .| sort | less'

#alias gi='grep -i'
#alias giv='grep -iv'

function grepi {
    local cmd="grep -nri $1 ."
    local i

    if [ $# -lt 1 ]
    then
        echo "Error: need at least one argument"
        return
    fi

    # build grep chain with function arguments
    i=2
    while [ $i -le $# ]
    do
        eval 'cmd="$cmd | grep -i $'$i'"'
        let i+=1
    done

    # run grep chain
    eval "$cmd"
}

# Editors

alias nano='nano -u'
alias vimm='vim -u NONE'

# Git

alias gd="git diff"
alias gp="git log -p"
alias gl="git log"
alias gll="git log --name-status"
alias gs="git status"

# Places

alias si="cd $HOME/Sites"
alias wo="cd $HOME/Workspace"

#=============================================================================
# Local config
#=============================================================================

if [ -e ~/.bashrc_local ]
then
    . ~/.bashrc_local
fi
