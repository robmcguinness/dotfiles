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

[[ -s `brew --prefix`/etc/autojump.sh ]] && . `brew --prefix`/etc/autojump.sh

if [ -f `brew --prefix`/etc/bash_completion ]; then
  . `brew --prefix`/etc/bash_completion
fi

eval "$(jenv init -)"
