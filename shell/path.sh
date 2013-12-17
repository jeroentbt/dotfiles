export PATH=$HOME/bin:/usr/local/bin:$PATH

path_add() {
  if [ -d "$1" ] && [[ ":$PATH:" != *":$1:"* ]]; then
    export PATH="${PATH:+"$PATH:"}$1"
  fi
}

path_add "/usr/local/sbin"
path_add "/usr/local/share/python/"
path_add "/usr/local/share/npm/bin"
