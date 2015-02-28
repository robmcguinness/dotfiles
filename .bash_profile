# look in ect/paths as well
. "$HOME/.paths"
. "$HOME/.bashrc"
. "$HOME/.aliases"

ulimit -n 10240

# Tell ls to be colourful
export CLICOLOR=1
export LSCOLORS=ExFxCxDxBxegedabagacad
export GREP_OPTIONS='--color=auto'
