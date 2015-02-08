# look in ect/paths as well

. "$HOME/.bashrc"
. "$HOME/.paths"
. "$HOME/.aliases"

ulimit -n 10240

# Tell ls to be colourful
export CLICOLOR=1
export LSCOLORS=ExFxCxDxBxegedabagacad
export GREP_OPTIONS='--color=auto'
source "`brew --prefix grc`/etc/grc.bashrc"
