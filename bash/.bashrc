#
# ~/.bashrc
#

[[ $- != *i* ]] && return

export EDITOR='emacsclient -c -a ""'
export ALTERNATE_EDITOR=" "
export BROWSER='firefox'
## history
export HISTCONTROL=erasedups
export HISTSIZE=10000
# add history of all shells to the history
shopt -s histappend
## __git_ps1
export GIT_PS1_SHOWDIRTYSTATE=true

[[ -f /usr/share/git/completion/git-prompt.sh ]] &&
    . /usr/share/git/completion/git-prompt.sh

alias ls='ls --color=auto'
alias l='ls -1'
alias ll='ls -l'
alias la='ls -al'
alias lal='ls -hal'
alias lat='ls -alt'
alias latr='ls -altr'
alias lg='ls -al | grep -i'
alias pg='ps aux | grep -i'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias pyserve='python3 -m http.server'
alias e='emacsclient -c -a ""'
alias et='emacsclient -t -a ""'
alias sudoh='sudo !!'
alias grep='grep --color=auto'

function ediff() {
    if [ "X${2}" = "X" ]; then
        echo "USAGE: ediff <file1> <file2>"
    else
        emacsclient -c -a "" -e "(ediff-files \"$1\" \"$2\")"
    fi
}

function tediff() {
    if [ "X${2}" = "X" ]; then
        echo "USAGE: ediff <file1> <file2>"
    else
        emacsclient -t -a "" -e "(ediff-files \"$1\" \"$2\")"
    fi
}

function gi() { curl -s http://www.gitignore.io/api/$@ ;}

# Alias set up to connect to default tmux session, or create that session
# servers set up in ~/.ssh/config also works (with no mandatory tmux)
ssht() {
    ssh $1 -t 'tmux attach -d -t default || tmux new-session -s default'
}


function set_prompt {

    local STATUS=$?

    ## Colors
    local RESET='\[\e[0m\]'
    local BLUE='\[\e[1;34m\]'
    local RED='\[\e[1;31m\]'
    local YELLOW='\[\e[1;33m\]'
    # prep var for interactive color
    local IColor=''

    ## Special chars
    # Get the hex value of unicode chars by copy pasting them and do
    # echo -n [unicode] | hexdump
    # ----TODO: there must be a better way to get these unicode chars in there
    local TOPLok=`echo -e '\342\224\214'` #square
    local TOPLerror=`echo -e '\342\224\234'`
    local TOPL=''
    local STRIPE=`echo -e '\342\224\200'`
    local BOTL=`echo -e '\342\224\224'`
    # combined chars
    local O="${BLUE}(${RESET}"
    local C="${BLUE})"


    ## check exit status previous command
    if [[ $STATUS = "0" ]]; then
        IColor=${BLUE}
        TOPL=${TOPLok}
    else
        IColor=${RED}
        TOPL=${TOPLerror}
    fi

    ## check username
    # FIXME: Does not work
    local WHOWHERE=''
    if [ \u != "jeroen" ]; then
        WHOWHERE+="${RESET}\u${BLUE}@"
    fi
    WHOWHERE+="${RESET}\h"


    ## start building the prompt
    PS1="${IColor}${TOPL}${STRIPE}"
    PS1+="${O}${WHOWHERE}${C}"
    PS1+="${STRIPE}${O}\w${C}"
    PS1+=$(__git_ps1 "${STRIPE}${O}${YELLOW}%s${C}")
    PS1+="\n${IColor}${BOTL}${BLUE}\$ ${RESET}"

    # PS1="${BLUE}${TOPL}${RETURN}${WHOWHERE}${WD}${GIT}${PROMPT}"
    PS2="${BLUE}${STRIPE}>${RESET} "
}

PROMPT_COMMAND='set_prompt'
#set_prompt $?

# set a dumb prompt for tramp compatibility
#case "$TERM" in
# "dumb")
#         PS1="> "
#         ;;
# xterm*|rxvt*|eterm*|screen*)
# PS1='[\u@\h \W]\$ '
#         ;;
# *)
#         PS1="> "
#         ;;
#esac
