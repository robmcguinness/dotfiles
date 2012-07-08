# look in ect/paths as well

. "$HOME/.bashrc"
. "$HOME/.paths"
. "$HOME/.aliases"

. ~/.nvm/nvm.sh

# Tell ls to be colourful
export CLICOLOR=1
export LSCOLORS=ExFxCxDxBxegedabagacad
export GREP_OPTIONS='--color=auto'

# RVM
if [[ -s /Users/robertmcguinness/.rvm/scripts/rvm ]] ; then
  source /Users/robertmcguinness/.rvm/scripts/rvm;
fi

if [ -f `brew --prefix`/etc/autojump ]; then
  . `brew --prefix`/etc/autojump
fi

if [ -f `brew --prefix`/etc/bash_completion ]; then
  . `brew --prefix`/etc/bash_completion
fi
