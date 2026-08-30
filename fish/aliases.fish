alias j=z
alias ..='cd ..'
alias ..2='cd ../..'
alias ..3='cd ../../..'
alias ..4='cd ../../../..'

alias c="clear"

alias npx="pnx"

# Enhanced eza
alias l='eza -la --icons --git'
alias ll='eza -l --icons --git'
alias la='eza -la --icons --git'
alias lt='eza -laT --level=2 --icons --git'
alias tree="find . -print | sed -e 's;[^/]*/;|____;g;s;____|; |;g'"

# alias dog='pygmentize -O style=monokai -f console256 -g'

alias sshkeys="tail +1 ~/.ssh/*.pub"

# git
alias pubkey='pbcopy < ~/.ssh/id_rsa.pub'

# iterate through all git repos and show the url
alias gurls='find . -type d -name .git -exec sh -c "cd \"{}\"/../ && git config --get remote.origin.url" \;'

# iterate through all git repos and run `git pull`
alias gua='find . -type d -name .git -exec sh -c "cd \"{}\"/../ && pwd && git pull" \;'

alias tower="gittower"

alias ci='code-insiders'
alias cc='claude'
alias co='codium'

# Modern tool aliases
alias cat='bat'
alias find='fd'
alias grep='rg'
alias ps='procs'
alias du='dust'
alias top='btop'

# Quick edits
alias fishrc='$EDITOR ~/.config/fish/config.fish'
alias aliases='$EDITOR ~/.config/fish/aliases.fish'
alias reload='source ~/.config/fish/config.fish'

# Utilities
alias ports='lsof -iTCP -sTCP:LISTEN -n -P'
alias localip='ipconfig getifaddr en0'
alias pubip='curl -s ifconfig.me'