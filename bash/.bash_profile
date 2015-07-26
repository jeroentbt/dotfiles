#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

RUBYPATH=$(ruby -rubygems -e "puts Gem.user_dir")/bin
export PATH=$RUBYPATH:~/.cask/bin:~/bin:$PATH

[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec startx
