# If not running interactively, don't do anything
if [[ ! $PS1 ]]; then
	return
fi

# barvy pro ls
if [[ -f ~/.dircolors ]]; then
	eval $(dircolors ~/.dircolors)
fi

# tabstops
tabs -4
tput cuu1
tput el

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=5000
HISTFILESIZE=10000

# append to the history file, don't overwrite it
shopt -s histappend

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

if [[ -f /usr/share/bash-completion/bash_completion ]]; then
	. /usr/share/bash-completion/bash_completion
elif [[ -f /etc/bash_completion ]]; then
	. /etc/bash_completion
elif [[ -f /usr/local/etc/bash_completion ]]; then
	. /usr/local/etc/bash_completion
fi

alias ls='ls --color=auto'
alias lsl="ls -l"

if ! command -v __git_ps1 &>/dev/null; then
	if [[ -f /usr/local/etc/bash_completion.d/git-prompt.sh ]]; then
		source /usr/local/etc/bash_completion.d/git-prompt.sh
	fi
fi

GIT_PS1_SHOWDIRTYSTATE=
GIT_PS1_SHOWSTASHSTATE=1
GIT_PS1_SHOWUNTRACKEDFILES=
GIT_PS1_SHOWUPSTREAM=1
GIT_PS1_SHOWCOLORHINTS=1

if [[ $SSH_CLIENT || $SSH_TTY ]]; then
	PROMPT_COMMAND="__git_ps1 '\[\033[1;32m\]\u\[\033[00m\]@\[\033[1;31m\]\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]' ' ' '(%s)'"
else
	PROMPT_COMMAND="__git_ps1 '\[\033[01;34m\]\w\[\033[00m\]' ' ' '(%s)'"
fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

function bashrc() {
    open -a PhpStorm ~/.bashrc
}

#------------------------FS-commands---------------------------------

alias dfscr="./dfsc.sh restart"
alias comp="./dfsc.sh composer"
alias const="./dfsc.sh constants"
alias webpack="npm run webpack-dev-w"

function dfsc() {
    if [[ $1 == retard ]]; then
        cd /Volumes/LS/flashscore && ./dfsc.sh restart
    elif [[ $1 == proxy ]]; then
        cd /Volumes/LS/flashscore && ./dfsc.sh restart -f
    elif [[ $1 == jetpack ]]; then
        cd /Volumes/LS/flashscore && npm run webpack-dev-w
    elif [[ $1 == const ]]; then
        cd /Volumes/LS/flashscore && ./dfsc.sh constants
    elif [[ $1 == comp ]]; then
        cd /Volumes/LS/flashscore && ./dfsc.sh composer
    else
        cd /Volumes/LS/flashscore && ./dfsc.sh $1 $2 $3 $4
    fi
}
