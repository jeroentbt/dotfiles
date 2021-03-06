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
export GIT_PS1_SHOWDIRTYSTATE=1
export GIT_PS1_SHOWSTASHSTATE=1
export GIT_PS1_SHOWUNTRACKEDFILES=1
# Explicitly unset color (default anyhow). Use 1 to set it.
export GIT_PS1_SHOWCOLORHINTS=1
export GIT_PS1_DESCRIBE_STYLE="branch"
export GIT_PS1_SHOWUPSTREAM="auto git"

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

# z cd jumper
. /usr/lib/z.sh


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



    ## Colors
    RESET='\e[0m'
    BLUE='\e[1;34m'
    RED='\e[1;31m'
    YELLOW='\e[1;33m'

    ## Special chars
    # Get the hex value of unicode chars by copy pasting them and do
    # echo -n [unicode] | hexdump
    # ----TODO: there must be a better way to get these unicode chars in there
    TOPLokChar=`echo -e '\342\224\214'` #square
    TOPLerrorChar=`echo -e '\342\224\234'`
    STRIPE=`echo -e '\342\224\200'`
    BOTL=`echo -e '\342\224\224'`
    # combined chars
    O="${BLUE}(${RESET}"
    C="${BLUE})"
    TOPLOK="${BLUE}${TOPLokChar}"
    TOPLER="${RED}${TOPLerrorChar}"

    ## check username
    # FIXME: Does not work
    local WHOWHERE=''
    if [ \u != "jeroen" ]; then
        WHOWHERE+="${RESET}\u${BLUE}@"
    fi
    WHOWHERE+="${RESET}\h"


    ## start building the prompt
    PS1='$(if [[ $? -eq 0 ]];then printf "${TOPLOK}"; else printf "${TOPLER}"; fi)'
    PS1+="${STRIPE}${O}${WHOWHERE}${C}"
    PS1+="${STRIPE}${O}\w${C}"
    PS1+='$(__git_ps1 "${STRIPE}${O}${YELLOW}%s${C}")'
    PS1+="\n${BOTL}${BLUE}\$ ${RESET}"

    # PS1="${BLUE}${TOPL}${RETURN}${WHOWHERE}${WD}${GIT}${PROMPT}"
    PS2="${BLUE}${STRIPE}>${RESET} "
}

# set a dumb prompt for tramp compatibility
case $TERM in
    "dumb")
        PS1="> "
        ;;
    xterm*|*rxvt*|eterm*|screen*)
        set_prompt
        ;;
    *)
        PS1="> "
        ;;
esac
