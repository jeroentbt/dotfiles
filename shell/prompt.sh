#---------------------
# Extras for git Prompt __git_ps1
#---------------------
# Caution: each option adds a delay to your prompt printing (non-issue when not in git repo)
export GIT_PS1_SHOWDIRTYSTATE=true
# export GIT_PS1_SHOWUNTRACKEDFILES=true
#export GIT_PS1_SHOWSTASHSTATE=true

#---------------------
# Prompt
#---------------------


function set_prompt {

    local STATUS=$1

    ## Colors
    local RESET='\[\e[0m\]'
    local BLUE='\[\e[1;34m\]'
    local RED='\[\e[1;31m\]'
    local YELLOW='\[\e[1;33m\]'

    ## Special chars
    # Get the hex value of unicode chars by copy pasting them and do
    # echo -n [unicode] | hexdump
    # ----TODO: there must be a better way to get these unicode chars in there
    local TOPL=`echo -e '\xe2\x95\xad '`
    local STRIPE=`echo -e '\xe2\x94\x81 '`
    local TOPR=`echo -e '\xe2\x95\xae '`
    local BOTL=`echo -e '\xe2\x95\xb0 '`

    # check exit status previous command
    # ----TODO: Does not work....
   # STATUS=0
    if [[ $STATUS = "0" ]]; then
	local RETURN=$STRIPE
    else
	local RETURN="$RED$TOPR"
    fi

    local O="${BLUE}(${RESET}"
    local C="${BLUE})"

    local WHOWHERE="${O}\u${BLUE}@${RESET}\h${C}"
    local WD="-${O}\w${C}"
    local GIT='$(__git_ps1 "-${0}${YELLOW}%s${C}")'
    local PROMPT="\n${BOTL}\$ ${RESET}"

    PS1="${BLUE}${TOPL}${RETURN}${WHOWHERE}${WD}${GIT}${PROMPT}"
}

#PS1=$(set_prompt \$?)
#set_prompt $?

PS1=$'\[\e[1;34m\]\xe2\x95\xad `if [[ \$? = "0" ]]; then echo "\xe2\x94\x81"; else echo "\[\e[1;31m\]\xe2\x95\xae\[\e[1;34m\]"; fi` (\[\e[0m\]\u\[\e[1;34m\]@\[\e[0m\]\h\[\e[1;34m\])-(\[\e[0m\]\w\[\e[1;34m\])$(__git_ps1 "-(\[\e[1;33m\]%s\[\e[1;34m\])")\n\xe2\x95\xb0 $ \[\e[0m\]'
