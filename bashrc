# Internal commands
_path_add() {
    # Adds a directory to $PATH, but only if it isn't already present.
    # http://superuser.com/questions/39751/add-directory-to-path-if-its-not-already-there/39995#39995
    if [[ ":$PATH:" != *":$1:"* ]]; then
        PATH="$PATH:$1"
    fi
}
_dir_chomp () {
    # Shortens the working directory.
    # First param is pwd, second param is the soft limit.
    # From http://stackoverflow.com/questions/3497885/code-challenge-bash-prompt-path-shortener/3499237#3499237
    # which asks for the shortest solution in characters, explaining the complete lack of readability or clarity.
    local IFS=/ c=1 n d
    local p=(${1/#$HOME/\~}) r=${p[*]}
    local s=${#r}
    while ((s>$2&&c<${#p[*]}-1))
    do
        d=${p[c]}
        n=1;[[ $d = .* ]]&&n=2
        ((s-=${#d}-n))
        p[c++]=${d:0:n}
    done
    echo "${p[*]}"
}
_command_exists() {
    type "$1" &> /dev/null ;
}
_set_exit_color() {
    if [[ $? != "0" ]]; then EXITCOLOR=$C_RED; else EXITCOLOR=$C_GREEN; fi
}
_set_git_prompt_string() {
    if type -t __git_ps1 &> /dev/null; then
        PS1_GIT="$(__git_ps1)"
    fi 
}

# Paths and environment variables for non-interactive shells
PATH="/usr/local/sbin:/usr/local/bin:$PATH" # These REALLY need to come first
_path_add ~/Applications/bin
export NODE_PATH=/usr/local/lib/node

# If this is a non-interactive shell, return
if [[ $- != *i* ]]
then
  return
fi

# Prompt: define colors
C_DEFAULT="\[\033[m\]"
C_WHITE="\[\033[1m\]"
C_BLACK="\[\033[30m\]"
C_RED="\[\033[31m\]"
C_GREEN="\[\033[32m\]"
C_YELLOW="\[\033[33m\]"
C_BLUE="\[\033[34m\]"
C_PURPLE="\[\033[35m\]"
C_CYAN="\[\033[36m\]"
C_LIGHTGRAY="\[\033[37m\]"
C_DARKGRAY="\[\033[1;30m\]"
C_LIGHTRED="\[\033[1;31m\]"
C_LIGHTGREEN="\[\033[1;32m\]"
C_LIGHTYELLOW="\[\033[1;33m\]"
C_LIGHTBLUE="\[\033[1;34m\]"
C_LIGHTPURPLE="\[\033[1;35m\]"
C_LIGHTCYAN="\[\033[1;36m\]"
C_BG_BLACK="\[\033[40m\]"
C_BG_RED="\[\033[41m\]"
C_BG_GREEN="\[\033[42m\]"
C_BG_YELLOW="\[\033[43m\]"
C_BG_BLUE="\[\033[44m\]"
C_BG_PURPLE="\[\033[45m\]"
C_BG_CYAN="\[\033[46m\]"
C_BG_LIGHTGRAY="\[\033[47m\]"

# Prompt: Set variables
PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
# Environment variables for interactive shells
export CLICOLOR=1
export LSCOLORS=gxfxbEaEBxxEhEhBaDaCaD

# Aliases and commands
alias ls='ls -F'
alias v='ls -ahlO'
alias cls='clear'
alias rot13="tr '[A-Za-z]' '[N-ZA-Mn-za-m]'"
alias whatismyip='curl http://whatismyip.org/ && echo'

alias ls='ls -lah --color'

mkcd() {
    dir="$*";
    mkdir -p "$dir" && cd "$dir";
}
extract () {
    if [ -f $1 ] ; then
        case $1 in
            *.tar.bz2)  tar xjf $1      ;;
            *.tar.gz)   tar xzf $1      ;;
            *.bz2)      bunzip2 $1      ;;
            *.rar)      rar x $1        ;;
            *.gz)       gunzip $1       ;;
            *.tar)      tar xf $1       ;;
            *.tbz2)     tar xjf $1      ;;
            *.tgz)      tar xzf $1      ;;
            *.zip)      unzip $1        ;;
            *.Z)        uncompress $1   ;;
            *)          echo "'$1' cannot be extracted via extract()" ;;
    esac
    else
        echo "'$1' is not a valid file"
    fi
}
if _command_exists hub; then
	`hub alias -s bash`
fi

# Show the fortune while we set up other things
if _command_exists fortune && [ "$TERM_PROGRAM" != "DTerm" ]; then
	fortune
	echo
fi

if [ -f /usr/local/etc/bash_completion ]; then
    . /usr/local/etc/bash_completion
elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi
if _command_exists dircolors; then
    eval `dircolors --bourne-shell ~/.dir_colors`
fi

# Run local config
if [ -f ~/.bashrc.local ]; then
	. ~/.bashrc.local
fi

