ulimit -n 8192

# set -Ux LSCOLORS gxfxcxdxbxegedabagacad

alias j=z
alias ..='cd ..'
alias ..2='cd ../..'
alias ..3='cd ../../..'
alias ..4='cd ../../../..'
alias c="clear"
alias l='ls -lah'
alias lf='ls -Gl | grep ^d' # only list directories
alias lsd='ls -Gal | grep ^d' # only list directories, including hidden ones
alias tree="find . -print | sed -e 's;[^/]*/;|____;g;s;____|; |;g'"

alias dog='pygmentize -O style=monokai -f console256 -g'

alias k9='kill -9'
alias hs='history | grep'
alias sshkeys="tail +1 ~/.ssh/*.pub"

# git
alias gc='git clone'
alias gp='git pull'
alias gpu='git push'
alias gll='git log --pretty=format:"%C(yellow)%h%Cred%d %Creset%s%Cblue [%cn]" --decorate'
alias gl='git log --pretty=format:"%C(yellow)%h\\ %ad%Cred%d\\ %Creset%s%Cblue\\ [%cn]" --decorate --date=short'
alias gs='git status -sb'
alias gf='git fetch'
alias gd='git diff'
alias gm='git commit -m'
alias gma='git commit -am'
alias gb='git branch'
alias gco='git checkout'
alias gfo='git fetch origin'
alias gra='git remote add'
alias grr='git remote rm'
alias gbr='git branch -r'
alias gba='git branch -a'
alias pubkey='pbcopy < ~/.ssh/id_rsa.pub'
alias sourcme='source ~/.config/fish/config.fish'
alias showa="dog ~/.config/fish/config.fish"

# iterate through all git repos and show the url
alias gurls='find . -type d -name .git -exec sh -c "cd \"{}\"/../ && git config --get remote.origin.url" \;'
# iterate through all git repos and run `git pull`
alias gua='find . -type d -name .git -exec sh -c "cd \"{}\"/../ && pwd && git pull" \;'

function nvm
  bass source ~/.nvm/nvm.sh ';' nvm $argv
end

function md
  mkdir -p $argv
  cd $argv
end

function gpp
  cd $argv
  gp
  ..
end

function search
  history | grep $argv | percol
end

# show remote git tags
#
#     ❯ gtr
#     From https://robmcguinness@github.com/Availity/availity-ekko
#     v1.0.0
#     v1.0.1
#     v1.1.0
#     v1.2.0
#
function gtr
  bass git ls-remote --tags | awk '{ print $2}' | sed -e 's;^refs/tags/;;' -e 's;\^{};;' | sort | uniq
end

# Fisher Plugins:
# fisher edc/bass grc debug z omf/sublime rafaelrinaldi/pure settitle simple barnybug/docker-fish-completion fin

set fisher_home ~/.local/share/fisherman
set fisher_config ~/.config/fisherman
source $fisher_home/config.fish

# docker (use docker for mac)

# set -gx DOCKER_TLS_VERIFY "1";
# set -gx DOCKER_HOST "tcp://192.168.99.100:2376";
# set -gx DOCKER_CERT_PATH "~/.docker/machine/machines/dev";
# set -gx DOCKER_MACHINE_NAME "dev";
