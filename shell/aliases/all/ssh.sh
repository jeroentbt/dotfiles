# Aliases set up to connect to default tmux session, or create that session
# servers set up in ~/.ssh/config so "ssh server" also works (with no mandatory tmux)

# due to escaping issues, this is a function
tmussh() {
    ssh $1 -t 'tmux attach -d -t default || tmux new-session -s default'
}

alias makaku="tmussh makaku"
alias zalem="tmussh zalem"
alias jeru="tmussh jeru"
alias abattoir="tmussh abattoir"
