#-------------------------------
# command completion by homebrew
#-------------------------------
if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
fi
