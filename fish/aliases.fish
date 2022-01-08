alias j=z
alias ..='cd ..'
alias ..2='cd ../..'
alias ..3='cd ../../..'
alias ..4='cd ../../../..'

alias c="clear"

alias l='exa -la'
alias tree="find . -print | sed -e 's;[^/]*/;|____;g;s;____|; |;g'"

# alias dog='pygmentize -O style=monokai -f console256 -g'

alias sshkeys="tail +1 ~/.ssh/*.pub"

# git
alias pubkey='pbcopy < ~/.ssh/id_rsa.pub'

# iterate through all git repos and show the url
alias gurls='find . -type d -name .git -exec sh -c "cd \"{}\"/../ && git config --get remote.origin.url" \;'

# iterate through all git repos and run `git pull`
alias gua='find . -type d -name .git -exec sh -c "cd \"{}\"/../ && pwd && git pull" \;'

alias cm="clean-mark"
